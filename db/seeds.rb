# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

b1 = Brewery.create name: "Koff", year: 1897
b2 = Brewery.create name: "Malmgard", year: 2001
b3 = Brewery.create name: "Weihenstephaner", year: 1040

style1 = Style.create name: "European Pale Lager", description: "Similar to Munich Helles, many European countries reacted to the popularity of early pale lagers by brewing their own. Hop flavor is significant and of noble varieties, bitterness is moderate, and both are backed by a solid malt body and sweet notes from an all-malt base."
style2 = Style.create name: "English Pale Ale", description: "The English Pale Ale can be traced back to the 19th century and the city of Burton-upon-Trent, a place with an abundance of hard water, rich in calcium sulfate. As well as enhancing a beer's hop bitterness, this hard water helps achieve clarity. English Pale Ale can fall anywhere on the color spectrum between golden and reddish amber and should generally have good head retention. A mix of fruity, hoppy, earthy, buttery, and malty aromas and flavors can be found in the sip, not unlike a classic Bitter. Traditionally all ingredients are English in origin."
style3 = Style.create name: "Belgian IPA", description: "Inspired by American India Pale Ales and Double IPAs, more and more Belgian brewers (like Chouffe & Urthel) are brewing hoppy pale colored ales for the US market. There's been an increase of American brewers making Belgian IPAs, too. Generally, Belgian IPAs are considered too hoppy by Belgian beer drinkers. Various malts are used, but the beers of this style are finished with Belgian yeast strains (bottle-conditioned) while the hops employed tend to be American. You'll generally find a cleaner bitterness versus American IPAs, and a pronounced dry edge, akin to an IPA crossed with a Belgian Tripel. Alcohol by volume is on the high side. Many examples are quite cloudy, and feature tight lacing, excellent head retention, and fantastic billowy heads that mesmerize (thanks, in part, to the hops). Belgian IPA is still very much a developing style."
style4 = Style.create name: "Baltic Porter", description: "Porters of the late 1700's were quite strong compared to today's standards, easily surpassing 7 percent alcohol by volume. Some English brewers made a stronger, more robust version, to be shipped across the North Sea that they dubbed a Baltic Porter. In general, the style's dark brown color covered up cloudiness and the smoky, roasted brown malts and bitter tastes masked brewing imperfections. Historically, the addition of stale ale also lent a pleasant acidic flavor to the style, which made it quite popular. These issues were quite important given that most breweries at the time were getting away from pub brewing and opening up production facilities that could ship beer across the world."
style5 = Style.create name: "Low-alcohol Beer", description: "Low-Alcohol Beer is also commonly known as Non-Alcohol (NA) beer, despite containing small amounts of alcohol. Low-Alcohol Beers are generally subjected to one of two things: a controlled brewing process that results in a low alcohol content, or the alcohol is removed using a reverse-osmosis method which passes alcohol through a permeable membrane. They tend to be very light on aroma, body, and flavor."

b1.beers.create name: "Iso 3", style: style1
b1.beers.create name: "Karhu", style: style1
b1.beers.create name: "Tuplahumala", style: style1
b2.beers.create name: "Huvila Pale Ale", style: style2
b2.beers.create name: "X Porter", style: style4
b3.beers.create name: "Hefeweizen", style: style1
b3.beers.create name: "Helles", style: style1