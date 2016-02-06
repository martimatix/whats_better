defmodule WhatsBetter.Pair do
  defstruct things: [], votes: []

  require Logger

  import RethinkDB.Lambda
  import RethinkDB.Query, except: [get: 2, get: 1]
  alias RethinkDB.Record
  alias RethinkDB.Collection

  def save(pair = %__MODULE__{}, db \\ WhatsBetter.Database) do
    data = %{
      things: pair.things,
      votes: pair.votes,
    }
    case pair.id do
      nil ->
        query =
          table("pairs")
          |> insert(data)
        %Record{data: %{"generated_keys" => [id]}} = RethinkDB.run(query, db)
        %{pair | id: id}
      x ->
        table("pairs")
        |> RethinkDB.Query.get(x)
        |> update(data)
        |> RethinkDB.run(db)
        pair
    end
  end

  def get(id, db \\ WhatsBetter.Database) do
    Logger.debug("getting #{inspect id}")
    %Record{ data: pair } =
      table("pairs")
      |> RethinkDB.Query.get(id)
      |> RethinkDB.run(db)
    parse(pair)
  end

  def get_all(db \\ WhatsBetter.Database) do
    %Collection{ data: things } =
      table("pairs")
      |> RethinkDB.run(db)
    Enum.map(things, &parse/1)
  end

  def parse(pair) do
    %__MODULE__{
      things: pair["things"],
      votes: pair["votes"],
    }
  end
end
