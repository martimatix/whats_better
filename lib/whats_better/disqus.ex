defmodule WhatsBetter.Disqus do
  def recent_comments do
    "http://#{disqus_site}.disqus.com/combination_widget.js?num_items=25&hide_mods=0&color=grey&default_tab=recent&excerpt_length=70"
  end

  def embed_code do
    "//#{disqus_site}.disqus.com/embed.js"
  end

  def disqus_site do
    Application.get_env(:whats_better, WhatsBetter.Endpoint)[:disqus_site]
  end
end
