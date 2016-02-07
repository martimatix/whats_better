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
      %{"things" => %{^selected_thing => votes}} ->
        table("pairs")
        |> get(pair_id)
        |> update(%{"things" => %{selected_thing => (votes + 1)}})
        |> RethinkDB.run(db)
    end
  end

  defp new_pair(pair_id, thing_1_id, thing_2_id, selected_thing) do
    %{ "id" => pair_id,
       "things" => %{thing_1_id => 0,
                     thing_2_id => 0 }
    }
    |> put_in(["things", selected_thing], 1)
  end

  # No need to use pair_id and use regular id if you take advanage of `has_fields`
  defp pair_id(things) do
    things
    |> Enum.sort
    |> Enum.join
  end
end
