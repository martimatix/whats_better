defmodule WhatsBetter.Pair do
  require Logger

  import RethinkDB.Lambda
  import RethinkDB.Query
  alias RethinkDB.Record
  alias RethinkDB.Collection

  def vote(%{"thing_1" => thing_1_id, "thing_2" => thing_2_id, "vote" => selected_thing}, db \\ WhatsBetter.Database) do
    pair_id = pair_id([thing_1_id, thing_2_id])
    %Record{data: data} =
      table("pairs")
      |> get(pair_id)
      |> RethinkDB.run(db)
    case data do
      nil ->
        table("pairs")
        |> insert(new_pair(pair_id, thing_1_id, thing_2_id, selected_thing))
        |> RethinkDB.run(db)
      %{"things" => things} ->
        table("pairs")
        |> get(pair_id)
        |> update(%{"things" => update_votes(things, selected_thing) })
        |> RethinkDB.run(db)
    end
    pair_id
  end

  def get_things_with_votes(pair_id, db \\ WhatsBetter.Database) do
    table("pairs")
    |> get(pair_id)
    |> get_field("things")
    |> eq_join("id", table("things"))
    |> without(%{right: "id"})
    |> zip
    |> RethinkDB.run(db)
    |> Map.get(:data)
  end

  def new_pair(pair_id, thing_1_id, thing_2_id, selected_thing) do
    %{ "id" => pair_id,
       "things" => [%{ "id"    => thing_1_id,
                       "votes" => score(thing_1_id, selected_thing) },
                    %{ "id"    => thing_2_id,
                       "votes" => score(thing_2_id, selected_thing) }]
    }
  end

  defp score(thing, selected_thing) do
    if selected_thing == thing, do: 1, else: 0
  end

  #TODO: Update the votes without rewriting the entire array
  defp update_votes(things, selected_thing) do
    Enum.map(things, fn(thing) ->
      case thing do
        %{"id" => ^selected_thing} ->
          Map.put(thing, "votes", thing["votes"] + 1)
        _ ->
          thing
        end
      end)
    end

  # TODO: No need to use pair_id and use regular id if you take advanage of `has_fields`
  defp pair_id(things) do
    things
    |> Enum.sort
    |> Enum.join
  end
end
