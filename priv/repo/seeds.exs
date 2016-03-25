# To run: $ mix run priv/repo/seeds.exs
# More info: http://stackoverflow.com/questions/32606515/how-to-pre-populate-database-on-a-phoenix-application-start-up

alias WhatsBetter.Thing

seeds = [
  %Thing{
    name: "Sex",
    category: "Philosophy",
    image: "http://imgur.com/oxPRfuZ.jpg"
  },
  %Thing{
    name: "Love",
    category: "Philosophy",
    image: "http://imgur.com/AfQOBkb.jpg"
  },
  %Thing{
    name: "A sense of humour",
    category: "Philosophy",
    image: "http://imgur.com/oprtPq9.jpg"
  },
  %Thing{
    name: "Potato",
    category: "Food",
    image: "http://imgur.com/suQrG5N.jpg"
  },
  %Thing{
    name: "Clark Kent",
    category: "People",
    image: "http://i.imgur.com/78BoHWM.jpg"
  },
  %Thing{
    name: "AIDS",
    category: "Medical",
    image: "http://imgur.com/YzrLSKF.jpg"
  },
  %Thing{
    name: "The Holocaust",
    category: "History",
    image: "http://imgur.com/Wu4HZ1e.jpg"
  },
  %Thing{
    name: "Smelling fingers in public",
    category: "Philosophy",
    image: "http://imgur.com/aqanixB.jpg"
  },
  %Thing{
    name: "Free money",
    category: "Philosophy",
    image: "http://imgur.com/8kXpxoD.jpg"
  },
  %Thing{
    name: "Batman",
    category: "People",
    image: "http://imgur.com/das8xQS.jpg"
  },
  %Thing{
    name: "Superman",
    category: "People",
    image: "http://imgur.com/dgO0Axe.jpg"
  },
  %Thing{
    name: "Taylor Swift",
    category: "Music",
    image: "http://imgur.com/ChqNVAR.jpg"
  },
  %Thing{
    name: "House of Cards",
    category: "Entertainment",
    image: "http://imgur.com/Fd9tQ0K.jpg"
  },
  %Thing{
    name: "Pikachu",
    category: "Anime",
    image: "http://imgur.com/ceXdMfp.jpg"
  },
  %Thing{
    name: "Receiving a gift",
    category: "Philosophy",
    image: "http://imgur.com/t0ZMLyB.jpg"
  },
  %Thing{
    name: "Giving a gift",
    category: "Philosophy",
    image: "http://imgur.com/t0ZMLyB.jpg"
  },
  %Thing{
    name: "Children with cancer",
    category: "Medical",
    image: "http://imgur.com/ONXyVzW.jpg"
  },
  %Thing{
    name: "Donald Trump",
    category: "People",
    image: "http://imgur.com/K4ewOZ3.jpg"
  },
  %Thing{
    name: "Hillary Clinton",
    category: "People",
    image: "http://imgur.com/CYd6s1h.jpg"
  },
  %Thing{
    name: "Bernie Sanders",
    category: "People",
    image: "http://imgur.com/vOFgosg.jpg"
  },
  %Thing{
    name: "Buddhism",
    category: "Religion",
    image: "http://imgur.com/BqWSHHM.jpg"
  },
  %Thing{
    name: "High School",
    category: "Education",
    image: "http://imgur.com/kpiAVeM.jpg"
  },
  %Thing{
    name: "Reddit",
    category: "Internet",
    image: "http://imgur.com/ANV1lMJ.jpg"
  }
]

Enum.each(seeds, fn(x) -> Thing.save(x) end)
