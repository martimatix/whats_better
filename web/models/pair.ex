defmodule WhatsBetter.Pair do
  defstruct id: nil,
            thing_1: %{ id: nil,
                        votes: 0 },
            thing_2: %{ id: nil,
                        votes: 0 }

  require Logger

  import RethinkDB.Lambda
  import RethinkDB.Query, except: [get: 2, get: 1]
  alias RethinkDB.Record
  alias RethinkDB.Collection

  # Find or create random pair
  # The more I think about this, the more I think this is not required.
  def random(db \\ WhatsBetter.Database) do
    random_things = WhatsBetter.Thing.two_random
    pair_id = Enum.join(random_things)
    data = %{
      id: pair_id,
      things: random_things
    }
    # Todo: find a better way to upsert
    table("pairs")
    |> insert(data)
    |> RethinkDB.run(db)
    pair_id
  end

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

  # def get(id, db \\ WhatsBetter.Database) do
  #   Logger.debug("getting #{inspect id}")
  #   %Record{ data: pair } =
  #     table("pairs")
  #     |> RethinkDB.Query.get(id)
  #     |> RethinkDB.run(db)
  #   parse(pair)
  # end

  # def get_all(db \\ WhatsBetter.Database) do
  #   %Collection{ data: things } =
  #     table("pairs")
  #     |> RethinkDB.run(db)
  #   Enum.map(things, &parse/1)
  # end

  # def parse(pair) do
  #   %__MODULE__{
  #     things: pair["things"],
  #     votes: pair["votes"],
  #   }
  # end
end
