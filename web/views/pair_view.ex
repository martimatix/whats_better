defmodule WhatsBetter.PairView do
  use WhatsBetter.Web, :view

  def pair_url_(domain, pair_id) do
    "#{domain}/pairs/#{pair_id}"
  end
end
