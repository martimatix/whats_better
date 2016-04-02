defmodule WhatsBetter.PairView do
  use WhatsBetter.Web, :view

  def pair_link(domain, pair_id) do
    "#{domain}/pairs/#{pair_id}"
  end

  def pair_title([first_thing, second_thing]) do
    "#{first_thing["name"]} vs #{second_thing["name"]}"
  end

  def wins_against_other_thing(things, this_thing) do
    "Wins against #{other_thing_name(things, this_thing)}:"
  end

  defp other_thing_name(things, this_thing) do
    Enum.filter(things, fn(thing) -> thing["id"] != this_thing["id"] end)
      |> List.first
      |> Map.get("name")
  end
end
