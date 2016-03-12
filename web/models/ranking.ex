defmodule WhatsBetter.Ranking do
  defstruct id: nil, name: nil, rank: nil, score: nil

  # TODO: Create index on score
  @num_things 4

  import RethinkDB.Lambda
  import RethinkDB.Query, except: [get: 2, get: 1]
  alias RethinkDB.Record
  alias RethinkDB.Collection
  alias WhatsBetter.Thing

  def top do
    # TODO: handle error if get_best_things returns error
    Enum.reduce(get_best_things, [],
      fn(thing, acc) ->
        [ %__MODULE__{id: thing["id"],
                      name: thing["name"],
                      score: thing["score"],
                      rank: length(acc) + 1 } | acc ]
      end)
      |> Enum.reverse
  end

  def bottom do
    # TODO: handle error if get_worst_things returns error
    num_things = things_count
    Enum.reduce(get_worst_things, [],
      fn(thing, acc) ->
        [ %__MODULE__{id: thing["id"],
                      name: thing["name"],
                      score: thing["score"],
                      rank: num_things - length(acc) } | acc ]
      end)
  end

  def get_best_things(db \\ WhatsBetter.Database) do
    %Record{ data: things } =
      table("things")
      |> order_by(desc("score"))
      |> pluck(["name", "id", "score"])
      |> limit(@num_things)
      |> RethinkDB.run(db)
    things
  end

  def get_worst_things(db \\ WhatsBetter.Database) do
    %Record{ data: things } =
      table("things")
      |> order_by("score")
      |> pluck(["name", "id", "score"])
      |> limit(@num_things)
      |> RethinkDB.run(db)
    things
  end

  def things_count(db \\ WhatsBetter.Database) do
    %Record{ data: count } =
      table("things")
      |> count
      |> RethinkDB.run(db)
    count
  end
end
