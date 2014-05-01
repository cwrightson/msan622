library(maps)
library(ggplot2)
library(rjson)
library(shiny)

classes <- c('character','character','character','character','character','character','character',
             'numeric','numeric','numeric','numeric','character','numeric','numeric')

all_data <- read.csv('with_college_latlong.csv', colClasses = classes)

states_list <- levels(read.csv('GeoLiteCity_20140401\\statenames.txt', header =F)$V1)

all_data$BirthCity[which(all_data$BirthCity == 'none')] <- ''
all_data$BirthState[which(all_data$BirthState == 'none')] <- ''
all_data$HighSchoolCity[which(all_data$HighSchoolCity == 'none')] <- ''
all_data$HighSchoolState[which(all_data$HighSchoolState == 'none')] <- ''
all_data$College <- all_data$CollegeNameGood
all_data <- all_data[,c(1:11,13:14)]

cityCounts <- fromJSON(file = 'cityCounts.json')
hsCounts <- fromJSON(file = 'hsCounts.json')
collegeCounts <- fromJSON(file = 'collegeCounts.json')

cities <- names(cityCounts)
hss <- names(hsCounts)
colleges <- names(collegeCounts)

all_data$birthCityState <- paste(all_data$BirthCity,all_data$BirthState)
all_data$hsCityState <- paste(all_data$HighSchoolCity,all_data$HighSchoolState)

all_data$CityCount <- 0
all_data$HighSchoolCount <- 0
all_data$CollegeCount <- 0

for(i in 1:length(all_data$Player)){
  #print(i)
  if(length(cityCounts[[all_data$birthCityState[i]]]) > 0){
    all_data$CityCount[i] <- cityCounts[[all_data$birthCityState[i]]]
  }
  if(length(hsCounts[[all_data$hsCityState[i]]]) > 0){
    all_data$HighSchoolCount[i] <- hsCounts[[all_data$hsCityState[i]]]
  }
  if(length(collegeCounts[[all_data$College[i]]]) > 0){
    all_data$CollegeCount[i] <- collegeCounts[[all_data$College[i]]]
  }
}



plot1 <- function(dataset, map, location, lat_range, long_range){

  states48 <- c(states_list, 'District of Columbia')[c(1,3:10,12:51)]
  if(location == 'Place of Birth'){
    dataset <- dataset[,c(8,9,16,4)]
    names(dataset) <- c('cLat', 'cLong', 'cCount', 'cState')
    all_data_usa <- dataset[which(dataset$cState %in% states48),]
  }
  if(location == 'High School'){
    dataset <- dataset[,c(10,11,17,6)]
    names(dataset) <- c('cLat', 'cLong', 'cCount', 'cState')
    all_data_usa <- dataset[which(dataset$cState %in% states48),]
  }
  if(location == 'College'){
    dataset <- dataset[,c(12,13,18)]
    names(dataset) <- c('cLat', 'cLong', 'cCount')
    all_data_usa <- dataset
  }
  if(location == 'All'){
    dataset <- dataset[,c(8:13,16:18)]
  }
  

  
  palette <- c('#f7f4f9','#e7e1ef','#d4b9da','#c994c7','#df65b0','#e7298a','#ce1256','#980043','#67001f')
  
  long_upper <- long_range[2]
  long_lower <- long_range[1]
  lat_upper <- lat_range[2]
  lat_lower <- lat_range[1]
  
  if(map == 'World'){
    worldmap <- map_data('world')
          
    all_data_city_count <- dataset[order(dataset$cCount, decreasing = T),]

    p <- ggplot(data = worldmap, aes(long, lat))
    p <- p + geom_polygon(data=worldmap, aes(long, lat, group=group), fill="white")
    p <- p + geom_point(data=all_data_city_count, aes(x=cLong, y=cLat,
                                                      size = (2*cCount)^(.75), 
                                                      color = cCount^(1/4), 
                                                      alpha = cCount^(1/4)))
    p <- p+ scale_x_continuous(expand = c(0,0), limits = c(-180,192))
    p <- p + scale_y_continuous(expand = c(0,0), limits = c(-60,85))
    #p <- p + coord_map(xlim=c(-180, 185), ylim=c(-60,85))
    p <- p + scale_size_area(max_size = 20, guide = 'none')
    p <- p + scale_alpha(guide= 'none', range = c(0.2, 1))
    p <- p + theme(axis.title = element_blank())
    p <- p + theme(axis.ticks = element_blank())
    p <- p + theme(axis.text = element_blank())
    p <- p + theme(panel.grid = element_blank())
    p <- p + theme(panel.background = element_rect(fill= 'black'))
    #p <- p + scale_color_manual(values = palette)
    p <- p + scale_color_gradient(low="black", high = 'red', guide = guide_colorbar(direction = "vertical"))
    p <- p + theme(
      legend.text = element_text(size = 10, colour = "white"),  
      legend.title = element_blank(),
      legend.background = element_blank(),
      legend.direction = "vertical", 
      legend.position = c(0, .0),
      legend.justification = c(0, 0))
  }
  if(map == 'United States'){
    usamap <- map_data('usa')
    all_data_usa_city_count <- all_data_usa[order(all_data_usa$cCount, decreasing = T),]
    
    p <- ggplot() + geom_polygon(data=usamap, aes(long, lat, group=group), fill="white")
    p <- p + geom_point(data=all_data_usa_city_count, aes(x=cLong, y=cLat, 
                                                                      size = (2*cCount)^(.75), 
                                                                      alpha = cCount^(1/4), 
                                                                      color = cCount^(1/4)))
    p <- p + scale_x_continuous(expand = c(0,0), limits = c(-128, -65))
    p <- p + scale_y_continuous(expand = c(0,0), limits = c(24,50))
    #p <- p + coord_map(xlim=c(-130, -60), ylim=c(23,50))
    p <- p + scale_size_area(max_size = 20, guide = 'none')
    p <- p + scale_alpha(guide= 'none', range = c(0.2, 1))
    p <- p + theme(axis.title = element_blank())
    p <- p + theme(axis.ticks = element_blank())
    p <- p + theme(axis.text = element_blank())
    p <- p + theme(panel.grid = element_blank())
    p <- p + theme(panel.background = element_rect(fill= 'black'))
    #p <- p + scale_color_manual(values = palette)
    p <- p + scale_color_gradient(low="black", high = 'red', guide = guide_colorbar(direction = "vertical"))
    p <- p + theme(
      legend.text = element_text(size = 10, colour = "white"),  
      legend.title = element_blank(),
      legend.background = element_blank(),
      legend.direction = "vertical", 
      legend.position = c(0, .0),
      legend.justification = c(0, 0))
  }
#   if(map == 'User Defined'){
#     worldmap <- map_data('world')
#     
#     all_data_city_count <- dataset[order(dataset$cCount, decreasing = T),]
#     
#     p <- ggplot(data = worldmap, aes(long, lat))
#     p <- p + geom_polygon(data=worldmap, aes(long, lat, group=group), fill="white")
#     p <- p + geom_point(data=all_data_city_count, aes(x=cLong, y=cLat,
#                                                       size = (2*cCount)^(.75), 
#                                                       color = cCount^(1/4), 
#                                                       alpha = cCount^(1/4)))
#     p <- p+ scale_x_continuous(expand = c(0,0))
#     p <- p + scale_y_continuous(expand = c(0,0))
#     p <- p + coord_map(xlim=c(long_lower, long_upper), ylim=c(lat_lower,lat_upper))
#     p <- p + scale_size_area(max_size = 20, guide = 'none')
#     p <- p + scale_alpha(guide= 'none', range = c(0.2, 1))
#     p <- p + theme(axis.title = element_blank())
#     p <- p + theme(axis.ticks = element_blank())
#     p <- p + theme(axis.text = element_blank())
#     p <- p + theme(panel.grid = element_blank())
#     p <- p + theme(panel.background = element_rect(fill= 'black'))
#     #p <- p + scale_color_manual(values = palette)
#     p <- p + scale_color_gradient(low="black", high = 'red', guide = guide_colorbar(direction = "vertical"))
#     p <- p + theme(
#       legend.text = element_text(size = 10, colour = "white"),  
#       legend.title = element_blank(),
#       legend.background = element_blank(),
#       legend.direction = "vertical", 
#       legend.position = c(0, .0),
#       legend.justification = c(0, 0))
#   }
    #,
    #legend.key = element_rect(
    #   fill = NA,
    #   colour = "white",
    #   size = .51))
    
  
  
  return(p)
}


plot2 <- function(dataset){
  
  p <- ggplot()
  
  
  return(p)
}



plot3 <- function(dataset){
  
  p <- ggplot()
  
  
  return(p)
}


plot4 <- function(dataset){
  
  p <- ggplot()
  
  
  return(p)
}


shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")

  
  output$plot1 <- renderPlot(
{
  print(plot1(all_data, input$map, input$location, input$lat_range, input$long_range))
}, 
width = 800,
height = 500)
  
  output$plot2 <- renderPlot({
    print(plot2())
}, 
width = 950,
height = 420)
  
  output$plot3 <- renderPlot({
    print(plot3())
}, 
width = 950,
height = 420)
  
  output$plot4 <- renderPlot({
    print(plot4())
}, 
width = 950,
height = 420)
  

  
})
