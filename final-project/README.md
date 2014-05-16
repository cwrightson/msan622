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

### Data ###

The data for my visualization I procured myself by scraping the website basketball-reference.com.  
I used Python and the BeautifulSoup package to collect the biographies and yearly statistics of all 4217 and players known to have played in at least one game in the National Basketball Association (NBA), the American Basketball Association (ABA) or the Basketball Association of America (BAA) since the end of World War II. All of current NBA franchises have their foundational roots in one of these three leagues, which are considered the top professional leagues to have existed in North America since 1946.  

With a data set that has far too many dimensions, variables and cross-sections, I decided to focus on visualizations where basketball players in the NBA come from.  This portion of the data makes statitical measures some what trival, but allow me to experiment visualizing data with maps and produce results that are immediately interpretable and relatable evento the non-basketball enthusiast. 

### Techniques ###

"NBA Player Map"


"Basketball Hotbeds"


"NBA Geographics over Time"


"Talented Populations"



For each visualization, discuss the following:

- How you encoded the data (i.e. mapping between columns and preattentive attributes)

- An evaluation of its lie factor, data density, and data to ink ratio

- What you think the visualization excels at (e.g. showing an overview of the dataset, identifying outliers, identifying patterns or trends, identifying clusters, comparison, etc.)

- What _you_ learned about the dataset from the visualization

This discussion should be approximately 2 to 5 paragraphs for each visualization, and this will heavily influence your score for this visualization.

### Interactivity ###

Please include an "Interactivity" section where you discuss the interactivity implemented in your project. Please discuss the following:

- The type(s) of interactivity you implemented

- How the interactivity enhances your visualization(s)

For example, interactivity can help provide focus or context, help overcome overplotting issues, decrease or increase data density, and so on. This discussion should be approximately 2 to 5 paragraphs, depending on the amount of interactivity you implemented.

### Prototype Feedback ###

Please include a "Prototype Feedback" section where you discuss the prototype exercise. Please discuss the following: 

- Describe the original prototype you demonstrated

- The changes did you make based on the feedback

- The feedback that you found particularly helpful, and why
 
- The feedback that you did not agree with, and why

This section should range from 1 to 3 paragraphs of text.

### Challenges ###

Please include a "Challenges" section where you discuss the challenges you encountered during this project. Describe how you addressed the challenge, or why you did not address the challenge. Please also discuss what you would have liked to implement if you had more time.

## Grading ###################

The point breakdown will be 20 points per visualization and 20 points for interactivity. Meeting the bare minimum requirements will earn you a C letter grade. To earn a higher letter grade, you must go above and beyond the stated requirements. 

Each visualization will be evaluated on its lie factor, data density, and data-ink ratio. Any non-trivial issues identified with the lie factor, data density, and data-ink ratio will result in a point deduction. For example, the following issues could result in point deductions:

- Poor placement of legend, decreasing data-density by unnecessarily increasing plot size.

- Illegible tick labels, decreasing data-ink ratio without providing context.

- No use of color when color could have provided additional context.

_Reasonable tradeoffs are expected._ For example, it is okay to add annotations that decrease data-ink ratio but increase context. Or, it is reasonable to jitter point positions in a scatterplot with overplotting issues, which increases the lie factor but increases data density.

