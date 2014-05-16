Final Project
==============================

| **Name**  | Cole Wrightson  |
|----------:|:-------------|
| **Email** | cwrightson@dons.usfca.edu |

## Discussion ################

Below is a detailing of my visualization on the geography of the NBA.
The shiny app used for this project has four tabs with interactive plots: 
"NBA Player Map"
"Basketball Hotbeds"
"NBA Geographics over Time"
"Talented Populations"

The following packages must be installed prior to running the app:

- `ggplot2`
- `shiny`
- `maps`

To run this code, please enter the following commands in R:

```
library(shiny)
shiny::runGitHub('msan622', 'cwrightson', subdir = "final-project")
```

## Data ##

The data for my visualization I procured myself by scraping the website basketball-reference.com.  
I used Python and the BeautifulSoup package to collect the biographies and yearly statistics of all 4217 and players known to have played in at least one game in the National Basketball Association (NBA), the American Basketball Association (ABA) or the Basketball Association of America (BAA) since the end of World War II. The raw(with BBR errors) .json file, `BBR_data_2014_04_15.json`, can be found in this repository as well. All of current NBA franchises have their foundational roots in one of these three leagues, which are considered the top professional leagues to have existed in North America since 1946.  

With a data set that has far too many dimensions, variables and cross-sections, I decided to focus on visualizations where basketball players in the NBA come from.  This portion of the data makes statitical measures some what trival, but allow me to experiment visualizing data with maps and produce results that are immediately interpretable and relatable even to the non-basketball enthusiast. 

Additonal population data from the 2010 US Census was need.
Geocoding was processed via a combination of the geopy package for Python to call the GeoNames API as well as a public MaxMind GeoLiteCity file and the Google Geocoding API. Also, basketball-reference.com is not without errors and some 200+ city locations were corrected by hand as municipalites change names or are annexed over time or simply mispelled. 

## Techniques ##

###NBA Player Map###
The most important visualization of the quartet is the map which plots the location of all 4217 players during various known points in their lifetime. For many of the players it is known in what city they were born, the city in which they attend high school, the college they went to if any, and the location of all of the NBA, ABA, and BAA teams they played for. For this graphic, individual municipalities were mapped as points using their latitude and logitude.  This points were plotted of the stock `{maps}` shapefiles for the world and for the United States.  The color of the point is encoded to the time period during which the player was in a location; 'Place of Birth', 'High School', 'College', 'NBA'.  The points were sized based on the number of players that were from the location represented by the point at a given time period.  Therefore, a given municipality may has as many as four points if all of the locations are plotted at once. 

The data density for this plot is fairly high as all of the plot is showing information.  On a map, even the locations that do not have points is information as it lets us know that no player has come from that location.  The density of the data itself is also import because it conveys the relative density where NBA player were or are. 

The data-to-ink ratio is also high, as would be expected for a map.  The context of the map makes the context of the data clear to anybody.  A small legend is necessary to explain the use of color, but location and size are self-explanatory. 

For this map the lie factor is relatively minimal.  However I can identify four things that make consuming the data a little fuzzier. First, the number of player in a particular location is encoded by the area of a circle and humans can struggle at time to compare the relative areas of circles.  However, the meaning of the circle size is inuitive and other shapes would not be as familiar or show the population density as well. Secondly, there is fair bit of over plotting tht occurs because of the dot size and the fact that many cities, i.e. suburbs are located close to one another. I opted to avoid jittering and to deal with over plotted, by carefully ordering the points and adjusting the alpha value so that the maximum number of points could be seen and denisty could be clearly and accurately ascessed. The third area of inaccuracy comes from the fact that all 2-D map projects of the ellipsoidal Earth are in accurate.  It would appear that while the geographic shapefile uses a standard map projection, ggplot is using the latitude and longitude coordinates provided and mapping them either unprojected or only approximately projected.  This results in some of the points being located away from their "true" position on the map and is most noticable at the higher latitudes. The last minor data lie is this visualization is that the size of the dots is not consistent as the map is adjusted to include/exclude locations and years.  By default, ggplot scales the dot size according to the maximum dot size, so that when a new location is included with a larger population all of the dots are rescaled from the previous rendering of the plot.  This can make it difficult to compare, for example, the number of players currently in the number from San Francisco to the total number of of player from San Francisco since 1947.

The trends in this data are pretty clear.  Most NBA players are American and more populous places tend to produce more people that make it to the NBA. Over time, the NBA has become more international as the vast majority of the players from out side of the US and Canada are from the most recent years. The distribution of players between their place of birth and high school is relatively uniform, but many players did not attend high school in their city of birth.  The location that players attend college is very different than the others. Regions such as Kansas and North Carolina have a disproportionately high concentration of players. Most notably, the distrubtion of dot sizes for colleges is very different as players seem to congregate at a couple dozen locations with a more unifrom distribution than the birthplace and high school locations which have a more expontential distribution where lots of the cities have a player or two and a handful have dozens or hundreds of players.  This trend of fewer cities, but larger number of players continues as expected as the level of competition and quality of play increase to the professional level. Even at the professional level, there is a trend from smaller cities to larger cities supporting professional basketball as the demographics of America shift over time and the popularity of basketball increases. The cities with professional teams are also the cities with the largest populations for place of birth and high school. 

This visualization is all about density, comparision and their evolution of time. 

###Basketball Hotbeds###


###NBA Geographics over Time###


###Talented Populations###



For each visualization, discuss the following:

- How you encoded the data (i.e. mapping between columns and preattentive attributes)

- An evaluation of its lie factor, data density, and data to ink ratio

- What you think the visualization excels at (e.g. showing an overview of the dataset, identifying outliers, identifying patterns or trends, identifying clusters, comparison, etc.)

- What _you_ learned about the dataset from the visualization

This discussion should be approximately 2 to 5 paragraphs for each visualization, and this will heavily influence your score for this visualization.

## Interactivity ##

Please include an "Interactivity" section where you discuss the interactivity implemented in your project. Please discuss the following:

- The type(s) of interactivity you implemented

- How the interactivity enhances your visualization(s)

For example, interactivity can help provide focus or context, help overcome overplotting issues, decrease or increase data density, and so on. This discussion should be approximately 2 to 5 paragraphs, depending on the amount of interactivity you implemented.

## Prototype Feedback ##

Please include a "Prototype Feedback" section where you discuss the prototype exercise. Please discuss the following: 

- Describe the original prototype you demonstrated

- The changes did you make based on the feedback

- The feedback that you found particularly helpful, and why
 
- The feedback that you did not agree with, and why

This section should range from 1 to 3 paragraphs of text.

## Challenges ##

Please include a "Challenges" section where you discuss the challenges you encountered during this project. Describe how you addressed the challenge, or why you did not address the challenge. Please also discuss what you would have liked to implement if you had more time.
