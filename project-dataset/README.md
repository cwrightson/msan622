Project: Dataset
==============================

| **Name**  | Cole Wrightson  |
|----------:|:-------------|
| **Email** | cwrightson@dons.usfca.edu |

## Discussion ##

The data set to be used for the MSAN 622 project is a one that I collected myself by scrapping the website www.basketball-reference.com.   
I used BeautifulSoup and Python to collect the statistics of the over 4200 professional basketball players that played in the NBA or ABA since the 1940s.
The data set includes categorical data such as the year the player entered the league or the round that they were drafted in or country/state of birth or the teams that they played for.
It includes text data such as names of the players, their city of birth and their high school.
However, the majority of the data is numerical dealing with the season-total statistics for each season the player played professionally.
This is public information, but I am not aware of a place where all of the information exists in a single data structure.
I have saved the data set as a JSON object. For visualization a particular plot would most likely focus on a particular portion or table of the statistics for a player, as if the JSON format were flatten into a table with one observation for each of the 4200+ players, there would be >4000 columns of data.
I choose this data set because in basketball and analytics involving the NBA.  
It is a diverse data set that involves geography, time series, and comparison between players.
While I have seen some visualizations involving current players, I have never seen anything that attempts to compare via visualization players that did not play at the same time.
Potential visualization ideas for this data set include: A map of the birthplaces of all NBA players that can be subset but the time there were in the league.  
Multiline time series to compare players over the course of their career.  
Flexible scatterplots that allow the user to choose from multiple players and statistics types.  
Scatterplots that show the correlation/trends between aggregated statistics, i.e. Win Shares vs. Points per Game or PER vs. Minutes Played.  
Barplots comparing the success of players during various decades.  
  
I have included the code for scrapping www.basketball-reference.com as well as the complete JSON file.

