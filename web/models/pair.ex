defmodule WhatsBetter.Pair do
  require Logger

  import RethinkDB.Lambda
  import RethinkDB.Query
  alias RethinkDB.Record
  alias RethinkDB.Collection
  alias WhatsBetter.Thing

  def vote(%{"thing_1" => thing_1_id, "thing_2" => thing_2_id, "vote" => winner_id}) do
    update_score_of_things(thing_1_id, thing_2_id, winner_id)
    update_or_create_votes(thing_1_id, thing_2_id, winner_id)
  end

  defp update_score_of_things(thing_1_id, thing_2_id, winner_id) do
    [thing_1, thing_2] = [Thing.get(thing_1_id), Thing.get(thing_2_id)]
    thing_1_new_score = Elo.calculate(thing_1.score, thing_2.score, points(thing_1_id, winner_id))
    thing_2_new_score = Elo.calculate(thing_2.score, thing_1.score, points(thing_2_id, winner_id))
    update_thing_params(thing_1, thing_1_new_score, winner_id) |> Thing.save
    update_thing_params(thing_2, thing_2_new_score, winner_id) |> Thing.save
  end

  defp update_thing_params(thing, thing_new_score, winner_id) do
    %{ thing | score: thing_new_score,
               total_votes: thing.total_votes + 1,
               total_wins: thing.total_wins + points(thing.id, winner_id) }
  end

  defp update_or_create_votes(thing_1_id, thing_2_id, winner_id, db \\ WhatsBetter.Database) do
    pair_id = pair_id([thing_1_id, thing_2_id])
    %Record{data: data} =
      table("pairs")
      |> get(pair_id)
      |> RethinkDB.run(db)
    case data do
      nil ->
        table("pairs")
        |> insert(new_pair(pair_id, thing_1_id, thing_2_id, winner_id))
        |> RethinkDB.run(db)
      %{"things" => things} ->
        table("pairs")
        |> get(pair_id)
        |> update(%{"things" => update_votes(things, winner_id) })
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

  def new_pair(pair_id, thing_1_id, thing_2_id, winner_id) do
    %{ "id" => pair_id,
       "things" => [%{ "id"    => thing_1_id,
                       "votes" => points(thing_1_id, winner_id) },
                    %{ "id"    => thing_2_id,
                       "votes" => points(thing_2_id, winner_id) }]
    }
  end

  defp points(thing_id, winner_id) do
    if winner_id == thing_id, do: 1, else: 0
  end

  defp update_votes(things, winner_id) do
    Enum.map(things, fn(thing) ->
      case thing do
        %{"id" => ^winner_id} ->
          Map.put(thing, "votes", thing["votes"] + 1)
        _ ->
          thing
        end
      end)
    end

  defp pair_id([thing_1_id, thing_2_id]) do
    UUID.uuid3(thing_1_id, thing_2_id)
  end
end
