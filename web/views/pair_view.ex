defmodule WhatsBetter.PairView do
  use WhatsBetter.Web, :view

  def pair_link(domain, pair_id) do
    "#{domain}/pairs/#{pair_id}"
  end

  def pair_title([first_thing, second_thing]) do
    "#{first_thing["name"]} vs #{second_thing["name"]}"
  end
end
