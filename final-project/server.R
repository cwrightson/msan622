library(maps)
library(ggplot2)
library(rjson)
library(shiny)

state_data <- read.csv('statepop_1960-2010.txt', sep = '\t')
classes <- c('character', 'character', 'numeric', 'numeric')
city_data <- read.csv('2010_city_pops.txt', sep = '\t', colClasses = classes)


# classes <- c(rep('character',2), rep('character',7), rep('numeric',4),
#              rep('character',1), rep('numeric',2),rep('character',2), 
#              rep('numeric',3), rep('character',20), rep('numeric',32))
# 
# data <- read.csv('with_teams_latlong.csv', colClasses = classes)
# data <- data[,3:73]
# 
# lil_df <- data[,c(1,8:11,13,14,40:71)]
# line_df <- data.frame('Player' = '', 'Lat' = 0, 'Long' = 0, 'Type' = '')
# for(i in 1:length(lil_df$Player)){
#   for(j in 1:19){
#     temp <- data.frame('Player' = lil_df$Player[i], 'Lat' = 0, 'Long' = 0, 'Type' = '')
#     temp$Lat <- lil_df[i,j*2]
#     temp$Long <- lil_df[i,j*2+1]
#     if(j == 1){
#       temp$Type <- 'Birth'
#     }
#     else if(j == 2){
#       temp$Type <- 'High School'
#     }
#     else if(j == 3){
#       temp$Type <- 'College'
#     }
#     else{
#       temp$Type <- 'NBA'
#     }
#     line_df <- rbind(line_df,temp)
#   }
# }
# line_df2 <- line_df[which(is.na(line_df$Lat) == F),]
# 
# write.csv(line_df2, file = 'line_df.csv')



line_df <- read.csv('line_df.csv')

classes <- c(rep('character',7), rep('numeric',4),
             rep('character',1), rep('numeric',2),rep('character',2), 
             rep('numeric',3), rep('character',20), rep('numeric',32), rep('character',2))

data <- read.csv('all_data_best.csv', colClasses = classes)

#nbas <- fromJSON(file = 'team_dict.json')
# nba_cities <- names(nbas)
# NBACount <- rep(0,length(nba_cities))
# for(i in 1:length(nba_cities)){
#   NBACount[i] <- nbas[[nba_cities[i]]]
# }
# nba_city_df <- data.frame('City' = nba_cities, 'BirthCount' = rep(NA,length(nba_cities)), 
#                           'HSCount' = rep(NA,length(nba_cities)), 'CollegeCount' = rep(NA,length(nba_cities)),
#                           'NBACount' = NBACount)
# # b_cities <- cbind(data$BirthCity, data$CityCount)
# # h_cities <- cbind(data$HighSchoolCity, daa$HighSchoolCount)
# # b_cites <- b_cities[which()]
# # 
# # cities <- cbind(b_cities, h_cities)
# 
# t1 <- data.frame(table(data$birthCityState))
# t2 <- data.frame(table(data$hsCityState))
# t3 <- data.frame(table(data$CollegeNameGood))
# m1 <- merge(t1,t2, by='Var1', all=T)
# m2 <- merge(m1,t3, by='Var1', all=T)
# names(m2) <- c('City', 'BirthCount', 'HSCount', 'CollegeCount')
# m2['NBACount'] <- NA
# dot_df <- rbind(m2,nba_city_df)
# 
# for(i in 1:length(dot_df[,1])){
#   for(j in 2:5){
#     if(is.na(dot_df[i,j])){
#       dot_df[i,j] <- 0
#     }
#   }
# }
# 
# type <- rep('',length(dot_df[,1]))
# d_size <- rep(0,length(dot_df[,1]))
# for(i in 1:length(type)){
#   b = dot_df[i,2]
#   h = dot_df[i,3]
#   c = dot_df[i,4]
#   n = dot_df[i,5]
#   if(max(b,h,c,n) == h){
#     type[i] <- 'High School'
#     d_size[i] <- h
#   }
#   if(max(b,h,c,n) == b){
#     type[i] <- 'Birth'
#     d_size[i] <- b
#   }
#   if(max(b,h,c,n) == c){
#     type[i] <- 'College'
#     d_size[i] <- c
#   }
#   if(max(b,h,c,n) == n){
#     type[i] <- 'NBA'
#     d_size[i] <- n
#   }
# }
# dot_df['Type'] = type
# dot_df['Num'] <- d_size
# 
# lat <- rep(0,length(dot_df[,1]))
# long <- rep(0,length(dot_df[,1]))
# for(i in 1:length(dot_df[,1])){
#   if(dot_df$Type[i] == 'Birth'){
#     lat[i] <- data$BirthLat[which(data$birthCityState == dot_df$City[i])][1]
#     long[i] <- data$BirthLong[which(data$birthCityState == dot_df$City[i])][1]
#   }
#   if(dot_df$Type[i] == 'HighSchool'){
#     lat[i] <- data$HSLat[which(data$hsCityState == dot_df$City[i])][1]
#     long[i] <- data$HSLong[which(data$hsCityState == dot_df$City[i])][1]
#   }
#   if(dot_df$Type[i] == 'College'){
#     lat[i] <- data$CollegeLat[which(data$CollegeNameGood == dot_df$City[i])][1]
#     long[i] <- data$CollegeLong[which(data$CollegeNameGood == dot_df$City[i])][1]
#   }
#   if(dot_df$Type[i] == 'NBA'){
#     lat[i] <- data$Team1_Lat[which(data$Team1 == dot_df$City[i])][1]
#     long[i] <- data$Team1_Long[which(data$Team1 == dot_df$City[i])][1]
#   }
# }
# dot_df['Lat'] <- lat
# dot_df['Long'] <- long
# dot_df$Type <- as.factor(dot_df$Type)
# 
# states <- rep('',length(dot_df$City))
# for(i in 1:length(dot_df[,1])){
#   states[i] <- data$BirthState[which(data$birthCityState == as.character(dot_df$City[i]))][1]
# }
# dot_df['State'] <- states



plot1a <- function(data,line_df, map, lines, locations, seasons1){
  
  lines = ''
  lower <- as.character(seasons1[1]-1)
  upper <- as.character(seasons1[2])
  
  data <- data[which(data$LastYear > lower),]
  data <- data[which(data$FirstYear < upper),]
  
  t1 <- data.frame(table(data$birthCityState))
  t2 <- data.frame(table(data$hsCityState))
  t3 <- data.frame(table(data$CollegeNameGood))
  t4 = data.frame('Var1' = unique(data$Team1), 'Freq' = rep(0,length(unique(data$Team1))))
  for(i in 1:length(data$Player)){
    for(j in 24:39){
      city <- data[i,j]
      t4$Freq[which(t4$Var1 == city)] <- t4$Freq[which(t4$Var1 == city)] +1
    }
  }
  
  dot_b <- t1
  names(dot_b) <- c('City', 'Num')
  dot_b['Type'] <- 'Birth'
  dot_h <- t2
  names(dot_h) <- c('City', 'Num')
  dot_h['Type'] <- 'High School'
  dot_c <- t3
  names(dot_c) <- c('City', 'Num')
  dot_c['Type'] <- 'College'
  dot_n <- t4
  names(dot_n) <- c('City', 'Num')
  dot_n['Type'] <- 'NBA'
  
  dot_df2 <- rbind(dot_b,dot_h,dot_c,dot_n)
  
  lat <- rep(0,length(dot_df2[,1]))
  long <- rep(0,length(dot_df2[,1]))
  for(i in 1:length(dot_df2[,1])){
    if(dot_df2$Type[i] == 'Birth'){
      lat[i] <- data$BirthLat[which(data$birthCityState == dot_df2$City[i])][1]
      long[i] <- data$BirthLong[which(data$birthCityState == dot_df2$City[i])][1]
    }
    if(dot_df2$Type[i] == 'High School'){
      lat[i] <- data$HSLat[which(data$hsCityState == dot_df2$City[i])][1]
      long[i] <- data$HSLong[which(data$hsCityState == dot_df2$City[i])][1]
    }
    if(dot_df2$Type[i] == 'College'){
      lat[i] <- data$CollegeLat[which(data$CollegeNameGood == dot_df2$City[i])][1]
      long[i] <- data$CollegeLong[which(data$CollegeNameGood == dot_df2$City[i])][1]
    }
    if(dot_df2$Type[i] == 'NBA'){
      lat[i] <- data$Team1_Lat[which(data$Team1 == dot_df2$City[i])][1]
      long[i] <- data$Team1_Long[which(data$Team1 == dot_df2$City[i])][1]
    }
  }
  dot_df2['Lat'] <- lat
  dot_df2['Long'] <- long
  dot_df2$Type <- as.factor(dot_df2$Type)
  
  states <- rep('',length(dot_df2$City))
  for(i in 1:length(dot_df2[,1])){
    if(dot_df2$Type[i] == 'Birth'){
      states[i] <- data$BirthState[which(data$birthCityState == as.character(dot_df2$City[i]))][1]
    }
    if(dot_df2$Type[i] == 'High School'){
      states[i] <- data$BirthState[which(data$hsCityState == as.character(dot_df2$City[i]))][1]
    }
  }
  dot_df2['State'] <- states
  dot_df2 <- dot_df2[which(dot_df2$City != 'none none'),]
  
  
  
  print(seasons1)
  dot_df <- dot_df2
  #dot_df <- isolate(get_dot_df)
  max_num <- max(dot_df$Num)
  #print(dot_df$Num)
  print(max_num)
# if(line_range[0] != 'Birth'){
#   line_df <- line_df[which(line_df$Type != 'Birth'),]
#   if(line_range[0] != 'High School'){
#     line_df <- line_df[which(line_df$Type != 'HighSchool'),]
#     if(line_range[0] != 'College'){
#       line_df <- line_df[which(line_df$Type != 'College'),]
#     }
#   }
# }
# 
# if(line_range[1] != 'NBA'){
#   line_df <- line_df[which(line_df$Type != 'NBA'),]
#   if(line_range[1] != 'College'){
#     line_df <- line_df[which(line_df$Type != 'College'),]
#     if(line_range[1] != 'High School'){
#       line_df <- line_df[which(line_df$Type != 'High School'),]
#     }
#   }
# }
  print(locations)
if(length(locations > 0)){
line_df <- line_df[which(line_df$Type %in% locations),]
dot_df <- dot_df[which(dot_df$Type %in% locations),]
}
#print(tail(dot_df))

if(map == 'World'){
worldmap <- map_data('world')

#cCount <- 'CityCount'
#cLong <- 'BirthLong'
#cLat <- 'BirthLat'

dot_df_s <- dot_df[order(dot_df$Num, decreasing = T),]

p <- ggplot(data = worldmap, aes(long, lat))
p <- p + geom_polygon(data=worldmap, aes(long, lat, group=group), fill="#d9d9d9")
p <- p + geom_point(data=dot_df_s, aes(x=Long, y=Lat,
                                       size = Num, 
                                       color = Type, 
                                       alpha = Num^(1/4)))
if(lines == 'Show Migration'){
  p <- p + geom_line(data=line_df, aes(x=Long, y = Lat, group = Player),alpha = .1)
}
p <- p+ scale_x_continuous(expand = c(0,0), limits = c(-180,192))
p <- p + scale_y_continuous(expand = c(0,0), limits = c(-60,85))
#p <- p + coord_map(xlim=c(-180, 185), ylim=c(-60,85))
#p <- p + scale_size_area(min_size = 2, max_size = 8, guide = 'none')
p <- p + scale_size_area(max_size = 15/(684/max(dot_df_s$Num)), guide = 'none')
p <- p + scale_alpha(guide= 'none', range = c(0.5, 1))
p <- p + theme(axis.title = element_blank())
p <- p + theme(axis.ticks = element_blank())
p <- p + theme(axis.text = element_blank())
p <- p + theme(panel.grid = element_blank())
p <- p + theme(panel.background = element_rect(fill= 'white'))
p <- p + scale_size(guide= 'none')
#p <- p + scale_color_manual(values = palette)
#p <- p + scale_color_gradient(low="#fef0d9", high = '#b30000', guide = guide_colorbar(direction = "vertical"))
p <- p + theme(
  legend.text = element_text(size = 10, colour = "black"),  
  legend.title = element_blank(),
  legend.background = element_blank(),
  legend.direction = "vertical", 
  legend.position = c(0, .0),
  legend.justification = c(0, 0))

palette <- c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3')
palette <- palette[which(c('Birth', 'High School', 'College', 'NBA') %in% locations)]
p <- p + scale_color_manual(values = palette, labels = locations)
#p
}

if(map == 'United States'){

usamap <- map_data('usa')

states_list <- levels(read.csv('statenames.txt', header =F)$V1)

states48 <- c(states_list, 'District of Columbia')[c(1,3:10,12:51)]
#dot_df_usa <- dot_df[which(as.character(dot_df$Type) == 'College'),]
dot_df_usa <- dot_df[which(dot_df$State %in% states48 | 
                             as.character(dot_df$Type) == 'College' |
                             as.character(dot_df$Type) == 'NBA'),]
dot_df_usa_s <- dot_df_usa[order(dot_df_usa$Num, decreasing = T),]
#dot_df_usa_s$Num <- dot_df_usa_s$Num*(684/max(dot_df_usa_s$Num))

test <- line_df[7:8,]

p <- ggplot() + geom_polygon(data=usamap, aes(long, lat, group=group), fill="#d9d9d9")
p <- p + geom_point(data=dot_df_usa_s, aes(x=Long, y=Lat,
                                           #size = (Num)^(.5), 
                                           size = Num,
                                           color = Type, 
                                           alpha = 1/Num^.5))
if(lines == 'Show Migration'){
  p <- p + geom_line(data=line_df, aes(x=Long, y = Lat, group = Player),alpha = .1)
}
p <- p+ scale_x_continuous(expand = c(0,0), limits = c(-130,-65))
p <- p + scale_y_continuous(expand = c(0,0), limits = c(22,52))
#p <- p + coord_map(xlim=c(-180, 185), ylim=c(-60,85))
#p <- p + scale_size_area(max_size = 20, guide = 'none')
print(max(dot_df_usa_s$Num))
#p <- p + scale_size_area(max_size = 50/(662/max(dot_df_usa_s$Num)), guide = 'none')
#p <- p + scale_size_area(max_size = 50/(662/max_num), guide = 'none')
p <- p + scale_size_area(max_size = 50/(max_num/max(dot_df_usa_s$Num)), guide = 'none')
p <- p + scale_alpha(guide= 'none', range = c(0.4, .8))
p <- p + theme(axis.title = element_blank())
p <- p + theme(axis.ticks = element_blank())
p <- p + theme(axis.text = element_blank())
p <- p + theme(panel.grid = element_blank())
p <- p + theme(panel.background = element_rect(fill= 'white'))
#p <- p + scale_color_manual(values = palette)
#p <- p + scale_color_gradient(low="#fef0d9", high = '#b30000', guide = guide_colorbar(direction = "vertical"))
p <- p + theme(
  legend.text = element_text(size = 10, colour = "black"),  
  legend.title = element_blank(),
  legend.background = element_blank(),
  legend.direction = "vertical", 
  legend.position = c(0, .0),
  legend.justification = c(0, 0))
palette <- c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3')
palette <- palette[which(c('Birth', 'High School', 'College', 'NBA') %in% locations)]
p <- p + scale_color_manual(values = palette, labels = locations)
#p
}
return(p)
}

# plot1 <- function(dataset, map, location){
# 
#   states48 <- c(states_list, 'District of Columbia')[c(1,3:10,12:51)]
#   if(location == 'Place of Birth'){
#     dataset <- dataset[,c(3,8,9,16,4)]
#     names(dataset) <- c('Label', 'cLat', 'cLong', 'cCount', 'cState')
#     all_data_usa <- dataset[which(dataset$cState %in% states48),]
#   }
#   if(location == 'High School'){
#     dataset <- dataset[,c(5,10,11,17,6)]
#     names(dataset) <- c('Label', 'cLat', 'cLong', 'cCount', 'cState')
#     all_data_usa <- dataset[which(dataset$cState %in% states48),]
#   }
#   if(location == 'College'){
#     dataset <- dataset[,c(7,12,13,18)]
#     names(dataset) <- c('Label', 'cLat', 'cLong', 'cCount')
#     all_data_usa <- dataset
#   }
#   if(location == 'All'){
#     dataset <- dataset[,c(8:13,16:18)]
#   }
#   
# 
#   
#   palette <- c('#f7f4f9','#e7e1ef','#d4b9da','#c994c7','#df65b0','#e7298a','#ce1256','#980043','#67001f')
#   
#   #long_upper <- long_range[2]
#   #long_lower <- long_range[1]
#   #lat_upper <- lat_range[2]
#   #lat_lower <- lat_range[1]
#   
#   if(map == 'World'){
#     worldmap <- map_data('world')
#           
#     all_data_city_count <- dataset[order(dataset$cCount, decreasing = T),]
# 
#     p <- ggplot(data = worldmap, aes(long, lat))
#     p <- p + geom_polygon(data=worldmap, aes(long, lat, group=group), fill="#d9d9d9")
#     p <- p + geom_point(data=all_data_city_count, aes(x=cLong, y=cLat,
#                                                       size = (2*cCount)^(.75), 
#                                                       color = cCount^(1/4), 
#                                                       alpha = cCount^(1/4)))
#     p <- p+ scale_x_continuous(expand = c(0,0), limits = c(-180,192))
#     p <- p + scale_y_continuous(expand = c(0,0), limits = c(-60,85))
#     #p <- p + coord_map(xlim=c(-180, 185), ylim=c(-60,85))
#     p <- p + scale_size_area(max_size = 20, guide = 'none')
#     p <- p + scale_alpha(guide= 'none', range = c(0.5, 1))
#     p <- p + theme(axis.title = element_blank())
#     p <- p + theme(axis.ticks = element_blank())
#     p <- p + theme(axis.text = element_blank())
#     p <- p + theme(panel.grid = element_blank())
#     p <- p + theme(panel.background = element_rect(fill= 'white'))
#     #p <- p + scale_color_manual(values = palette)
#     p <- p + scale_color_gradient(low="#fef0d9", high = '#b30000', guide = guide_colorbar(direction = "vertical"))
#     p <- p + theme(
#       legend.text = element_text(size = 10, colour = "white"),  
#       legend.title = element_blank(),
#       legend.background = element_blank(),
#       legend.direction = "vertical", 
#       legend.position = c(0, .0),
#       legend.justification = c(0, 0))
#   }
#   if(map == 'United States'){
#     usamap <- map_data('usa')
#     all_data_usa_city_count <- all_data_usa[order(all_data_usa$cCount, decreasing = T),]
#     
#     p <- ggplot() + geom_polygon(data=usamap, aes(long, lat, group=group), fill="#d9d9d9")
#     p <- p + geom_point(data=all_data_usa_city_count, aes(x=cLong, y=cLat, 
#                                                                       #size = (2*cCount)^(.75), 
#                                                                       size = cCount,
#                                                                       alpha = cCount^(1/4), 
#                                                                       color = cCount^(1/4)))
#     #p <- p + geom_text(data = all_data_usa_city_count, aes(label = Label))
#     p <- p + scale_x_continuous(expand = c(0,0), limits = c(-128, -65))
#     p <- p + scale_y_continuous(expand = c(0,0), limits = c(24,50))
#     #p <- p + coord_map(xlim=c(-130, -60), ylim=c(23,50))
#     #p <- p + scale_size_area(max_size = 20, guide = 'none')
#     p <- p + scale_alpha(guide= 'none', range = c(0.5, 1))
#     p <- p + theme(axis.title = element_blank())
#     p <- p + theme(axis.ticks = element_blank())
#     p <- p + theme(axis.text = element_blank())
#     p <- p + theme(panel.grid = element_blank())
#     p <- p + theme(panel.background = element_rect(fill= 'white'))
#     #p <- p + scale_color_manual(values = palette)
#     p <- p + scale_color_gradient(low="#fef0d9", high = '#b30000', guide = guide_colorbar(direction = "vertical"))
#     p <- p + theme(
#       legend.text = element_text(size = 10, colour = "white"),  
#       legend.title = element_blank(),
#       legend.background = element_blank(),
#       legend.direction = "vertical", 
#       legend.position = c(0, .0),
#       legend.justification = c(0, 0))
#   }
# #   if(map == 'User Defined'){
# #     worldmap <- map_data('world')
# #     
# #     all_data_city_count <- dataset[order(dataset$cCount, decreasing = T),]
# #     
# #     p <- ggplot(data = worldmap, aes(long, lat))
# #     p <- p + geom_polygon(data=worldmap, aes(long, lat, group=group), fill="white")
# #     p <- p + geom_point(data=all_data_city_count, aes(x=cLong, y=cLat,
# #                                                       size = (2*cCount)^(.75), 
# #                                                       color = cCount^(1/4), 
# #                                                       alpha = cCount^(1/4)))
# #     p <- p+ scale_x_continuous(expand = c(0,0))
# #     p <- p + scale_y_continuous(expand = c(0,0))
# #     p <- p + coord_map(xlim=c(long_lower, long_upper), ylim=c(lat_lower,lat_upper))
# #     p <- p + scale_size_area(max_size = 20, guide = 'none')
# #     p <- p + scale_alpha(guide= 'none', range = c(0.2, 1))
# #     p <- p + theme(axis.title = element_blank())
# #     p <- p + theme(axis.ticks = element_blank())
# #     p <- p + theme(axis.text = element_blank())
# #     p <- p + theme(panel.grid = element_blank())
# #     p <- p + theme(panel.background = element_rect(fill= 'black'))
# #     #p <- p + scale_color_manual(values = palette)
# #     p <- p + scale_color_gradient(low="black", high = 'red', guide = guide_colorbar(direction = "vertical"))
# #     p <- p + theme(
# #       legend.text = element_text(size = 10, colour = "white"),  
# #       legend.title = element_blank(),
# #       legend.background = element_blank(),
# #       legend.direction = "vertical", 
# #       legend.position = c(0, .0),
# #       legend.justification = c(0, 0))
# #   }
#     #,
#     #legend.key = element_rect(
#     #   fill = NA,
#     #   colour = "white",
#     #   size = .51))
#     
#   
#   
#   return(p)
# }


plot2 <- function(dataset, geo, when, us_int, seasons){
  
  lower <- as.character(seasons[1]-1)
  upper <- as.character(seasons[2])
  
  dataset <- dataset[which(data$LastYear > lower),]
  dataset <- dataset[which(data$FirstYear < upper),]
  #column_name = 'BirthState'
  #column_count = 'BirthStateCount'
  #dataset <- isolate(get_data2)
  print(dim(dataset))
  
  if(when == 'Place of Birth'){
    if(geo == 'City'){
      column_name = 'birthCityState'
      column_count = 'CityCount'
    }
    if(geo == 'State'){
      column_name = 'BirthState'
      column_count = 'BirthStateCount'
    }
    if(geo == 'Country'){
      column_name = 'BirthCountry'
      column_count = 'BirthCountryCount'
    }
    if(geo == 'Continent'){
      column_name = 'BirthContinent'
      column_count = 'BirthContinentCount'
    }
  }
  if(when == 'High School'){
    if(geo == 'City'){
      column_name = 'hsCityState'
      column_count = 'HighSchoolCount'
    }
    if(geo == 'State'){
      column_name = 'HighSchoolState'
      column_count = 'HighSchoolStateCount'
    }
    if(geo == 'Country'){
      column_name = 'HighSchoolCountry'
      column_count = 'HighSchoolCountryCount'
    }
    if(geo == 'Continent'){
      column_name = 'HighSchoolContinent'
      column_count = 'HighSchoolContinentCount'
    }
  }
  if(when == 'College'){
    column_name = 'College'
    column_count = 'CollegeCount'
  }
  if(us_int == 'US-Born Players Only'){
    dataset <- dataset[which(dataset$BirthCountry == 'United States of America'),]
  }
  if(us_int == 'Foreign-Born Players Only'){
    dataset <- dataset[which(dataset$BirthCountry != 'United States of America'),]
  }
  print(column_name)
  print(column_count)
  
  df <- data.frame(table(dataset[[column_name]]))
  df <- df[which(df$Var1 != 'none' & df$Var1 != 'none none'),]
  tail(df[order(df$Freq),], 10)
  #df <- df[which(df$Var1 != 'none' & df$Var1 != 'none none' & df$Var1 != ' '),]
  df <- df[which(df$Var1 != 'none' & df$Var1 != 'none none' & df$Var1 != ' ' & df$Var1 != ''),]
  df <- df[which(!is.na(df$Var1)),]
  df$Var1 <- factor(df$Var1, levels=df$Var1[order(df$Freq, decreasing=F)])
  df_s <- df[order(df$Freq, decreasing = T),]
  head(df_s)
  df_st <- df_s[1:10,]
  df_st <- df_st[which(!is.na(df_st$Var1)),]
  
  
  #print(df_st$Var1)
#   palette <- c('#e41a1c','#ea4749')
#   if(when == 'College'){
#     palette <- c('#4daf4a','#6ec16b')
#   }
#   if(when == 'High School'){
#     palette <- c('#377eb8','#5697cc')
#   }
#   print(palette)
  print(when)
  p <- ggplot(df_st, aes(x = Var1, y = Freq, fill = Freq))
  p <- p + geom_bar()
  p <- p + scale_fill_gradient(low = '#525252', high = '#252525', guide = "none")
  p <- p + theme(axis.ticks.x = element_blank())
  p <- p + scale_x_discrete(expand = 0))
  p <- p + scale_y_discrete(expand = 0))
  p <- p + coord_flip()
  
  return(p)
}


plot3 <- function(dataset, geo, when, us_int, seasons){
  
  lower <- as.character(seasons[1]-1)
  upper <- as.character(seasons[2])
  
  dataset <- dataset[which(data$FirstYear >= lower),]
  dataset <- dataset[which(data$FirstYear <= upper),]
  #column_name = 'BirthState'
  #column_count = 'BirthStateCount'
  #dataset <- isolate(get_data2)
  print(dim(dataset))
  
  if(when == 'Place of Birth'){
    if(geo == 'City'){
      column_name = 'birthCityState'
      column_count = 'CityCount'
    }
    if(geo == 'State'){
      column_name = 'BirthState'
      column_count = 'BirthStateCount'
    }
    if(geo == 'Country'){
      column_name = 'BirthCountry'
      column_count = 'BirthCountryCount'
    }
    if(geo == 'Continent'){
      column_name = 'BirthContinent'
      column_count = 'BirthContinentCount'
    }
  }
  if(when == 'High School'){
    if(geo == 'City'){
      column_name = 'hsCityState'
      column_count = 'HighSchoolCount'
    }
    if(geo == 'State'){
      column_name = 'HighSchoolState'
      column_count = 'HighSchoolStateCount'
    }
    if(geo == 'Country'){
      column_name = 'HighSchoolCountry'
      column_count = 'HighSchoolCountryCount'
    }
    if(geo == 'Continent'){
      column_name = 'HighSchoolContinent'
      column_count = 'HighSchoolContinentCount'
    }
  }
  if(when == 'College'){
    column_name = 'College'
    column_count = 'CollegeCount'
  }
  if(us_int == 'US-Born Players Only'){
    dataset <- dataset[which(dataset$BirthCountry == 'United States of America'),]
  }
  if(us_int == 'Foreign-Born Players Only'){
    dataset <- dataset[which(dataset$BirthCountry != 'United States of America'),]
  }
  print(column_name)
  print(column_count)
  
  dataset <- dataset[which(dataset[[column_name]] != 'none' & dataset[[column_name]] != 'none none' & dataset[[column_name]] != ' ' & dataset[[column_name]] != ''),]
  dataset <- dataset[which(!is.na(dataset[[column_name]])),]
  df <- data.frame(addmargins(table(dataset[[column_name]], dataset$FirstYear)))
  #print('siup')
  
  
  df <- df[which(df$Var1 != 'none' & df$Var1 != 'none none'),]
  #tail(df[order(df$Freq),], 10)
  #df <- df[which(df$Var1 != 'none' & df$Var1 != 'none none' & df$Var1 != ' '),]
  df <- df[which(df$Var1 != 'none' & df$Var1 != 'none none' & df$Var1 != ' ' & df$Var1 != ''),]
  df <- df[which(!is.na(df$Var1)),]
  df <- df[which(df$Var2 != 'Sum'),]
  
  
  df2 <- data.frame(table(dataset[[column_name]]))
  df2 <- df2[which(df2$Var1 != 'none' & df2$Var1 != 'none none'),]

  df2 <- df2[which(df2$Var1 != 'none' & df2$Var1 != 'none none' & df2$Var1 != ' ' & df2$Var1 != ''),]
  df2 <- df2[which(!is.na(df2$Var1)),]
  df2$Var1 <- factor(df2$Var1, levels=df2$Var1[order(df2$Freq, decreasing=F)])
  df2_s <- df2[order(df2$Freq, decreasing = T),]

  df2_st <- df2_s[1:10,]
  df2_st <- df2_st[which(!is.na(df2_st$Var1)),]
  #print(head(df2_st))
  best <- c(as.character(df2_st$Var1),'Sum')
  #print(best)
  
  df <- df[which(df$Var1 %in% best),]
  
  #print(df_st$Var1)
 p <- ggplot(df, aes(x = Var2, y = Freq, group = Var1, fill = Var1))
 p <- p + geom_area()
 
 palette <- c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00','#66c2a4', 
              '#ffff33','#a65628','#f781bf','#999999', '#000000')
 
 p <- p + scale_fill_manual(values = palette)
 p <- p + theme(axis.title.x = element_text('Season'))
 p <- p + theme(axis.title.y = element_text('NBA Population'))
 p <- p + theme(axis.ticks.x = element_blank())
 p <- p + theme(axis.ticks.y = element_blank())
 p <- p + scale_x_discrete(expand = 0))
 p <- p + scale_y_discrete(expand = 0))
  #p
  
  
  return(p)
}



plot4 <- function(player_data, city_data, state_data, sc, bh, seasons){
  
  lower <- as.character(seasons[1]-1)
  upper <- as.character(seasons[2])
  
  player_data <- player_data[which(player_data$LastYear > lower),]
  player_data <- player_data[which(player_data$FirstYear < upper),]
  
  state_pop <- state_data[,c(1,7)]
  
  city_pop <- city_data[,c(1,2,4)]
  city_pop['cityState'] <- paste(city_pop$City,city_pop$State)
  
  #all_data <- read.csv('C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\Project\\with_continents.csv')
  usa_players <- player_data[which(player_data$BirthCountry == 'United States of America'),]
  
  m <- merge(data.frame(table(usa_players$BirthState)), state_pop, by.x = 'Var1', by.y = 'Name')
  names(m) <- c('State', 'NBATotalBirth', 'StatePop2010')
  n <- merge(m,data.frame(table(usa_players$HighSchoolState)), by.x = 'State', by.y = 'Var1')
  names(n)[4] <- 'NBATotalHighSchool'
  n['BirthRatio'] <- n$StatePop2010/n$NBATotalBirth
  n['HighSchoolRatio'] <- n$StatePop2010/n$NBATotalHighSchool
  
  o <- merge(data.frame(table(usa_players$birthCityState)), city_pop, by.x = 'Var1', by.y = 'cityState')
  o <- o[,c(1,2,5)]
  names(o) <- c('City', 'NBATotalBirth', 'CityPop2010')
  q <- merge(o,data.frame(table(usa_players$hsCityState)), by.x = 'City', by.y = 'Var1')
  names(q)[4] <- 'NBATotalHighSchool'
  q['BirthRatio'] <- q$CityPop2010/q$NBATotalBirth
  q['HighSchoolRatio'] <- q$CityPop2010/q$NBATotalHighSchool
  #sc = 'City'
  #bh = 'High School'
  
  if(sc == 'State'){
    df <- n
    if(bh == 'Place of Birth'){
      
      sumNBA <- sum(df$NBATotalBirth)
      sumGeneral <- sum(df$BirthStatePop2010)
      
      p <- ggplot(df, aes(y = NBATotalBirth, 
                          x = StatePop2010, 
                          #color = '#31a354', 
                          size = 10, 
                          alpha = .6, 
                          label=State, 
                          color = log(BirthRatio)))
      p <- p + geom_point()
      p <- p + geom_abline(intercept = 0, slope = sumNBA/sumGeneral)
      p <- p + geom_text(color = 'black')
    }
    else{
      sumNBA <- sum(df$NBATotalHighSchool)
      sumGeneral <- sum(df$BirthStatePop2010)
      p <- ggplot(df, aes(y = NBATotalHighSchool, 
                          x = StatePop2010, 
                          #color = '#31a354', 
                          size = 10, 
                          alpha = .6, 
                          label=State, 
                          color = log(HighSchoolRatio)))
      p <- p + geom_point()
      p <- p + geom_abline(intercept = 0, slope = sumNBA/sumGeneral)
      p <- p + geom_text(color = 'black')
    }
  }
  if(sc == 'City'){
    df <- q
    if(bh == 'Place of Birth'){
      
      sumNBA <- sum(df$NBATotalBirth)
      sumGeneral <- sum(df$BirthCityPop2010)
      
      p <- ggplot(df, aes(y = NBATotalBirth, 
                          x = CityPop2010, 
                          #color = '#31a354', 
                          size = 10, 
                          alpha = .6, 
                          label=City, 
                          color = log(BirthRatio)))
      p <- p + geom_point()
      p <- p + geom_abline(intercept = 0, slope = sumNBA/sumGeneral)
      p <- p + geom_text(color = 'black')
    }
    else{
      
      sumNBA <- sum(df$NBATotalHighSchool)
      sumGeneral <- sum(df$BirthCityPop2010)
      
      p <- ggplot(df, aes(y = NBATotalHighSchool, 
                          x = CityPop2010, 
                          #color = '#31a354', 
                          size = 10, 
                          alpha = .6,
                          label=City, 
                          color = log(HighSchoolRatio)))
      p <- p + geom_point()
      p <- p + geom_abline(intercept = 0, slope = sumNBA/sumGeneral)
      p <- p + geom_text(color = 'black')
    }
  }
  #print(zoom.x)
  #p <- p + scale_x_continuous(limit = zoom.x)
  #p <- p + scale_y_continuous(limit = zoom.y)
  print(sumNBA)
  print(sumGeneral)
  #p <- p + geom_abline(intercept = 0-zoom.y[1], slope = sumNBA/sumGeneral)
  p <- p + scale_colour_continuous(low = "#2166ac", high = "#b2182b",guide = "none")
  p <- p + scale_size_continuous(guide = "none")
  p <- p + scale_alpha_continuous(guide = "none")
  p <- p + theme(panel.background = element_rect(fill = NA))
  p <- p + theme(legend.key = element_rect(fill = NA))
  p <- p + theme(panel.grid.major = element_line(color = "grey90"))
  p <- p + theme(panel.grid.minor = element_line(color = "grey90", linetype = 3))
  p <- p + theme(panel.border = element_blank())
  p <- p + theme(axis.title.x = element_text('Total Population'))
  p <- p + theme(axis.title.y = element_text('NBA Population'))
  p <- p + theme(axis.ticks.x = element_blank())
  p <- p + theme(axis.ticks.y = element_blank())
  
  
  return(p)
}





shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")

#   get_dot_df <- reactive(
# {
#   lower <- as.character(input$seasons1[1]-1)
#   upper <- as.character(input$seasons1[2])
#   
#   data <- data[which(data$LastYear > lower),]
#   data <- data[which(data$FirstYear < upper),]
#   
#   t1 <- data.frame(table(data$birthCityState))
#   t2 <- data.frame(table(data$hsCityState))
#   t3 <- data.frame(table(data$CollegeNameGood))
#   t4 = data.frame('Var1' = unique(data$Team1), 'Freq' = rep(0,length(unique(data$Team1))))
#   for(i in 1:length(data$Player)){
#     for(j in 24:39){
#       city <- data[i,j]
#       t4$Freq[which(t4$Var1 == city)] <- t4$Freq[which(t4$Var1 == city)] +1
#     }
#   }
#   
#   dot_b <- t1
#   names(dot_b) <- c('City', 'Num')
#   dot_b['Type'] <- 'Birth'
#   dot_h <- t2
#   names(dot_h) <- c('City', 'Num')
#   dot_h['Type'] <- 'High School'
#   dot_c <- t3
#   names(dot_c) <- c('City', 'Num')
#   dot_c['Type'] <- 'College'
#   dot_n <- t4
#   names(dot_n) <- c('City', 'Num')
#   dot_n['Type'] <- 'NBA'
#   
#   dot_df2 <- rbind(dot_b,dot_h,dot_c,dot_n)
#   
#   lat <- rep(0,length(dot_df2[,1]))
#   long <- rep(0,length(dot_df2[,1]))
#   for(i in 1:length(dot_df2[,1])){
#     if(dot_df2$Type[i] == 'Birth'){
#       lat[i] <- data$BirthLat[which(data$birthCityState == dot_df2$City[i])][1]
#       long[i] <- data$BirthLong[which(data$birthCityState == dot_df2$City[i])][1]
#     }
#     if(dot_df2$Type[i] == 'High School'){
#       lat[i] <- data$HSLat[which(data$hsCityState == dot_df2$City[i])][1]
#       long[i] <- data$HSLong[which(data$hsCityState == dot_df2$City[i])][1]
#     }
#     if(dot_df2$Type[i] == 'College'){
#       lat[i] <- data$CollegeLat[which(data$CollegeNameGood == dot_df2$City[i])][1]
#       long[i] <- data$CollegeLong[which(data$CollegeNameGood == dot_df2$City[i])][1]
#     }
#     if(dot_df2$Type[i] == 'NBA'){
#       lat[i] <- data$Team1_Lat[which(data$Team1 == dot_df2$City[i])][1]
#       long[i] <- data$Team1_Long[which(data$Team1 == dot_df2$City[i])][1]
#     }
#   }
#   dot_df2['Lat'] <- lat
#   dot_df2['Long'] <- long
#   dot_df2$Type <- as.factor(dot_df2$Type)
#   
#   states <- rep('',length(dot_df2$City))
#   for(i in 1:length(dot_df2[,1])){
#     if(dot_df2$Type[i] == 'Birth'){
#     states[i] <- data$BirthState[which(data$birthCityState == as.character(dot_df2$City[i]))][1]
#     }
#     if(dot_df2$Type[i] == 'High School'){
#       states[i] <- data$BirthState[which(data$hsCityState == as.character(dot_df2$City[i]))][1]
#     }
#   }
#   dot_df2['State'] <- states
#   dot_df2 <- dot_df2[which(dot_df2$City != 'none none'),]
#   #print(dot_df[1,])
#   return(dot_df2)
# 
# }
#   )
# get_datatime <- reactive(
# {
#   lower <- as.character(input$seasons2[1]-1)
#   upper <- as.character(input$seasons2[2])
#   
#   data <- data[which(data$LastYear > lower),]
#   data <- data[which(data$FirstYear < upper),]
#   
#   
#   return(data)
#   
# }
# )
  
  output$plot1a <- renderPlot(
{
  #print(plot1(all_data, input$map), input$location))
  print(plot1a(data, line_df, input$map_a, input$lines, input$location_a, input$seasons1_a))
}, 
width = 750,
height = 400)

output$plot1b <- renderPlot(
{
  #print(plot1(all_data, input$map), input$location))
  print(plot1a(data, line_df, input$map_b, input$lines, input$location_b, input$seasons1_b))
}, 
width = 750,
height = 400)
  
  output$plot2 <- renderPlot({
    print(plot2(data, input$geo, input$when, input$us_int, input$seasons2))
}, 
width = 950,
height = 420)
  
  output$plot4 <- renderPlot({
    print(plot4(data, city_data, state_data, input$sc, input$bh, input$seasons3))
}, 
width = 950,
height = 420)
  
  output$plot3 <- renderPlot({
    print(plot3(data, input$geo, input$when, input$us_int, input$seasons2))
}, 
width = 950,
height = 420)
  

  
})
