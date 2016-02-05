defmodule WhatsBetter.Thing do
  defstruct id: nil, name: nil, image: nil, category: nil

  require Logger

  import RethinkDB.Lambda
  import RethinkDB.Query, except: [get: 2, get: 1]
  alias RethinkDB.Record
  alias RethinkDB.Collection

  def save(thing = %__MODULE__{}, db \\ WhatsBetter.Database) do
    data = %{
      name: thing.name,
      image: thing.image,
      category: thing.category,
    }
    case thing.id do
      nil ->
        query =
          table("things")
          |> insert(data)
        %Record{data: %{"generated_keys" => [id]}} = RethinkDB.run(query, db)
        %{thing | id: id}
      x ->
        table("things")
        |> RethinkDB.Query.get(x)
        |> update(data)
        |> RethinkDB.run(db)
        thing
    end
  end

  def get(id, db \\ WhatsBetter.Database) do
    Logger.debug("getting #{inspect id}")
    %Record{ data: thing } =
      table("things")
      |> RethinkDB.Query.get(id)
      |> RethinkDB.run(db)
    parse(thing)
  end

  def get_all(db \\ WhatsBetter.Database) do
    %Collection{ data: things } =
      table("things")
      |> RethinkDB.run(db)
    Enum.map(things, &parse/1)
  end

  def parse(thing) do
    %__MODULE__{
      id: thing["id"],
      name: thing["name"],
      image: thing["image"],
      category: thing["category"],
    }
  end
end
