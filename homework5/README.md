Homework 5: Time Series Visualization
==============================

| **Name**  | Cole Wrightson  |
|----------:|:-------------|
| **Email** | cwrightson@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `ggplot2`
- `shiny`
- `GGally`
- `reshape`
- `scales`
- `plyr`

To run this code, please enter the following commands in R:

```
library(shiny)
shiny::runGitHub('msan622', 'cwrightson', subdir = "homework5")
```

This will start the `shiny` app. See below for details on how to interact with the visualization.

## Discussion ##

The UK Road Casualties data set contains monthly data on deaths and injuries that occurred on UK highways during the years 1969-1984 in addition to a few other statistics about travelling in the UK.
I choose to focus on the deaths and serious injuries that occurred each month as well as the location of the killed/injured within the car. 
  
My shiny application attempts to see how these injuries trend over time, investigate the cyclical nature of highway death countries and compare the number of injures based on the person's location within the vehicle. 

My application has two interactive plots that are delimited by tabs.
The first tab, "Injuries and Deaths over Time", shows a multi-line plot.

![Plot1](Plot1.png

The plot initially displays the five columns of data that are used in the visualization and compares their relative levels over time by plotting them all on the same x/y axis. The user is able to subset the data to plot the columns of data that they are most interested in.  The plot initially shows the entire 16 years for which there data set spans, however, the user can select any of the months as the starting or ending point in the plot. This changes the scale of the x-axis, but the user is able to know where the plot is relative to the whole time series by the small overview plot that is just below the main visual.  Other customization that I did for this visual included, moving the legend and ensuring that the colors of each data time series were consistent no matter when subset of them were chosen to be plotted. I also automatically scale the x and y axes to the size of the data to be plotted and reformat the tick break points accordingly. 

The lie factor for this plot is one or very near one. There is no distortion of the data and I have ensured that the zero-intercept is always plotted. The data-ink ratio relatively high as the gridlines and annotations are minimal for conveying the information.  The legend is small and out of the way and the axis labels removed.  The data-ink ratio is not too high as the plot in general has fairly low data density.  Data density is the quality that is most controlled by the user as they decide how much time to plot at once as well as how many series to plot at once.  Plotting more time and more time series increases the data density and therefore the data-ink ratio.  The overview plot underneath is useful for communicating the relative location of the time period plotted, but is does add an amount of redundancy to the visual and reduces a little the data-ink ratio.

The second tab. "Comparing the Yearly Trends", does not focus on the general time series trends or allow for comparison between whose was injured in the highway accidents. This graphic is about study the yearly changes in a given time series and compare the cyclical trends.

![Plot2](Plot2.png)

The plot initially displays the total monthly counts vehicle drivers that were seriously injured or killed where each year is broken apart and plotted on the same axis.  The user is able to decide which of the five time series they want to analyze.  The user is also able to subset the data to plot only the years in which they are interested by using a slider to remove or add years.  Brushing is effectively mandated in this visual by giving the user two highlighting colors to identify particular years of interest.  I have initialized the plot to highlight the years 1982 and 1983 because those are the years directly before and after a mandatory seatbelt law was enacted in the United Kingdom. The user is able to choose any combination of two year to highlight for comparison both against one another and against the gray time series that show the general yearly pattern of injuries and deaths. Additional customization for this plot includes creating a minimal theme, faint gridlines, and a clear and subtle legend that is automatically colored according the users highlighting choices.  The same auto-adjusting x and y axes limits is employed as before. 

The lie factor for this plot is again one as there should be no distortion in the information shown in the plot.  Line plots in general are very good at avoiding misleading the viewer.  The data-ink ratio is similar to that of the first plot in that all extraneous information has been removed.  There is slightly more non-data ink that many plots because the gridlines need to identify the level and month of the year and all of the yearly series must be identified.  I feel that if some of the months were skipped the plot would feel a little unbalanced even though the user could be expected to interpolate the unlabeled months. The data density for this plot is higher than the first visual as more series are plotted and the relative densities of the series provide additional information.  The user can quickly tell while the highlighted years closely follow the general cyclic trend of for that variable or whether there is a deviation.  Additionally the higher density identifies series that have relatively high or low variance for a given month. 

If I were to continue improving this visualization app, I would further investigate the data set and create additional graphics that would add to the understanding of the change in casualties over time. If I were to focus on the enacting of the seatbelt law then I might add a marker in the first plot to show the before and after time periods.  This could even be an interactive option where the user decides whether or not to include the line. 




