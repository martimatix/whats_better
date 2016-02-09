defmodule WhatsBetter.User do
  defstruct id: nil, name: nil, email: nil, password: nil, password_hash: nil

  require Logger

  import RethinkDB.Lambda
  import RethinkDB.Query, except: [get: 2, get: 1]
  alias RethinkDB.Record
  alias RethinkDB.Collection

  def save(user = %__MODULE__{}, db \\ WhatsBetter.Database) do
    data = %{
      name: user.name,
      email: user.email,
      password_hash: Comeonin.Bcrypt.hashpwsalt(user.password),
    }
    case user.id do
      nil ->
        query =
          table("users")
          |> insert(data)
        %Record{data: %{"generated_keys" => [id]}} = RethinkDB.run(query, db)
        %{user | id: id}
      x ->
        table("users")
        |> RethinkDB.Query.get(x)
        |> update(data)
        |> RethinkDB.run(db)
        user
    end
  end

  def get(id, db \\ WhatsBetter.Database) do
    Logger.debug("getting #{inspect id}")
    %Record{ data: user } =
      table("users")
      |> RethinkDB.Query.get(id)
      |> RethinkDB.run(db)
    parse(user)
  end

  def get_all(db \\ WhatsBetter.Database) do
    %Collection{ data: users } =
      table("users")
      |> RethinkDB.run(db)
    Enum.map(users, &parse/1)
  end

  def parse(user) do
    %__MODULE__{
      id: user["id"],
      name: user["name"],
      email: user["image"],
      password_hash: user["category"],
    }
  end
end
