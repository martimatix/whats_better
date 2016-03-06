# To run: $ mix run priv/repo/seeds.exs
# More info: http://stackoverflow.com/questions/32606515/how-to-pre-populate-database-on-a-phoenix-application-start-up

alias WhatsBetter.Thing

seeds = [
  %Thing{
    name: "Sex",
    category: "Philosophy",
    image: "http://www.womenshealthmag.com/sites/womenshealthmag.com/files/images/cuddle-after-sex_0.jpg"
  },
  %Thing{
    name: "Love",
    category: "Philosophy",
    image: "http://www.icytales.com/wp-content/uploads/2015/09/Love-vs-Logic.jpg"
  },
  %Thing{
    name: "A sense of humour",
    category: "Philosophy",
    image: "http://media.rd.com/rd/images/rdc/books/stealth-health/sense-of-humor-af.jpg"
  },
  %Thing{
    name: "Potato",
    category: "Food",
    image: "https://static-secure.guim.co.uk/sys-images/Guardian/Pix/pictures/2014/9/24/1411574454561/03085543-87de-47ab-a4eb-58e7e39d022e-620x372.jpeg"
  },
  %Thing{
    name: "Clark Kent",
    category: "People",
    image: "https://s-media-cache-ak0.pinimg.com/236x/32/53/be/3253beb8efb1fbe891e26dbeac751603.jpg"
  },
  %Thing{
    name: "AIDS",
    category: "Medical",
    image: "http://www.med.upenn.edu/pmharc/images/aids_banner.jpg"
  },
  %Thing{
    name: "The Holocaust",
    category: "History",
    image: "http://www.theholocaustexplained.org/public/cms/70/92/204/268/yN7eKq_web.jpg"
  }
]

Enum.each(seeds, fn(x) -> Thing.save(x) end)
