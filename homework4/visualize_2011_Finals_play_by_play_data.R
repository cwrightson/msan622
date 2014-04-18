#text visualization for data vis HW4

library(ggplot2)
library(wordcloud)
library(tm)
library(reshape)
setwd('C:\\Users\\Cole\\Desktop\\NBA_R-code')


data <- read.csv('2011playoffs_plays.txt', sep = ',', colClasses = 'character', header= F)

finals <- data[33013:35525,]

finals_text <- finals[,2]
finals_time <- finals[,1]

corpus <- Corpus(VectorSource(finals_text))

summary(corpus)
tdm <- TermDocumentMatrix(corpus)
findFreqTerms(tdm, 20)
termFrequency <- rowSums(as.matrix(tdm))
termFrequency <- subset(termFrequency, termFrequency>=10)
# Convert TermDocumentMatrix to a matrix
m <- as.matrix(tdm)
# Construct a denser matrix with just the most frequent terms
m.sub <- subset(m, rowSums(m)>=3)
# calculate the frequency of words and sort it descending by frequency
wordFreq <- sort(rowSums(m.sub), decreasing=TRUE)


dtm <- DocumentTermMatrix(corpus)
findAssocs(dtm, "nowitzki", 0.05)

words <- findFreqTerms(tdm,1)

#make four word clouds to compare bigrams in each quarter
require(wordcloud)
bg_by_q <- read.csv('finals_bigrams_by_quarter.csv')
names(bg_by_q)[1] <- 'Bigrams'

png("C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\HW4\\clouds1.png", width=20, height=20, units="cm", res=800)
layout(matrix(c(1,2,3,4,5,6,7,8), nrow=4), 
       heights=c(lcm(.75), lcm(8), lcm(.75), lcm(8)), 
       widths = c(lcm(8),lcm(8)))
par(mar=rep(0, 4))
plot.new()
text(x=0.5, y=0.5, "First Quarter", par(1))
wordcloud(
  bg_by_q$Bigrams,
  bg_by_q$First,
  scale = c(1, 1.5),      # size of words
  min.freq = 5,          # drop infrequent
  max.words = 25,         # max words in plot
  random.order = T,   # plot by frequency
  rot.per = 0.0,          # percent rotated
  # set colors
  colors = brewer.pal(5, "PRGn"),
  #colors = T,
  # color random or by frequency
  random.color = F,
  # use r or c++ layout
  use.r.layout = FALSE)
plot.new()
text(x=0.5, y=0.5, "Second Quarter", par(1))
wordcloud(
  bg_by_q$Bigrams,
  bg_by_q$Second,
  scale = c(1, 1.5),      # size of words
  min.freq = 5,          # drop infrequent
  max.words = 25,         # max words in plot
  random.order = T,   # plot by frequency
  rot.per = 0.0,          # percent rotated
  # set colors
  colors = brewer.pal(5, "BrBG"),
  #colors = T,
  # color random or by frequency
  random.color = F,
  # use r or c++ layout
  use.r.layout = FALSE)
plot.new()
text(x=0.5, y=0.5, "Third Quarter", par(1))
wordcloud(
  bg_by_q$Bigrams,
  bg_by_q$Third,
  scale = c(1, 1.5),      # size of words
  min.freq = 5,          # drop infrequent
  max.words = 25,         # max words in plot
  random.order = T,   # plot by frequency
  rot.per = 0.0,          # percent rotated
  # set colors
  colors = brewer.pal(5, "PuOr"),
  #colors = T,
  # color random or by frequency
  random.color = F,
  # use r or c++ layout
  use.r.layout = FALSE)
plot.new()
text(x=0.5, y=0.5, "Fourth Quarter", par(1))
wordcloud(
  bg_by_q$Bigrams,
  bg_by_q$Fourth,
  scale = c(1, 1.5),      # size of words
  min.freq = 5,          # drop infrequent
  max.words = 25,         # max words in plot
  random.order = T,   # plot by frequency
  rot.per = 0.0,          # percent rotated
  # set colors
  colors = brewer.pal(5, "RdGy"),
  #colors = T,
  # color random or by frequency
  random.color = F,
  # use r or c++ layout
  use.r.layout = FALSE)

dev.off()


#barplot of bigram frequencies
bg_by_q <- bg_by_q[with(bg_by_q, order(Bigrams)), ]
#bg_by_q$Bigrams <- as.factor(bg_by_q$Bigrams)
#bg_by_q$Bigrams <- factor(bg_by_q$Bigrams, levels = sort(levels(bg_by_q$Bigrams)))
rs <- rep(0,length(bg_by_q))
for(i in 1:length(bg_by_q$Bigrams)){
  rs[i] <- sum(bg_by_q[i,2:5])
}
bg_by_q['Total'] <- rs
sub <- bg_by_q[which(rs > 100),]
#sub$Bigrams <- factor(sub$Bigrams, levels = sort(levels(sub$Bigrams)))


melted <- melt(sub, id = 'Bigrams')



palette <- c('#a6cee3','#1f78b4','#b2df8a','#33a02c',
'#fb9a99','#e31a1c',' #fdbf6f','#ff7f00','#cab2d6','#6a3d9a','#ffff99')

p <- ggplot(melted, aes(x = variable, , y = value, fill = Bigrams)) 
p <- p +  geom_bar(stat= 'identity', position = "stack")
p <- p + ggtitle("Bigrams of the 2011 NBA Finals by Quarter")
p <- p + xlab("Quarter")
p <- p + ylab("Total Frequency of Bigrams in Series")
p <- p + theme_minimal()
p <- p + scale_x_discrete(expand = c(0, 0))
p <- p + scale_y_continuous(limits= c(0,780), expand = c(0, 0))
p <- p + theme(panel.grid = element_blank())
p <- p + theme(axis.ticks = element_blank())
#p <- p + scale_fill_discrete(guide = guide_legend(reversed =T))

p
ggsave(filename = 'C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\HW4\\hw4_stacked_bar.png', plot = p, 
       scale = 1, width = par("din")[1], height = par("din")[2], units = 'in', dpi = 600)



#Make a bar plot for total bigram frequncies
sub <- bg_by_q[which(rs > 50),]
sub <- sub[with(sub, order(Total)), ]
#sub$Bigrams <- factor(sub$Bigrams, levels = sort(levels(sub$Bigrams)))

melted <- melt(sub, id = 'Bigrams')
melted$Bigrams <- factor(melted$Bigrams, levels = sort(levels(melted$Bigrams)))

p <- ggplot(melted, aes(x = Bigrams, y = value)) 
p <- p +  geom_bar(stat= 'identity')
p <- p + ggtitle(" Most Frequent Bigrams of the 2011 NBA Finals")
p <- p + xlab("Bigram")
p <- p + ylab("Total Frequency of Bigrams in Series")
p <- p + theme_minimal()
p <- p + scale_x_discrete(expand = c(0, 0))
p <- p + scale_y_continuous(limits= c(0,780), expand = c(0, 0))
p <- p + theme(panel.grid = element_blank())
p <- p + theme(axis.ticks = element_blank())
p <- p + theme(axis.text.x = element_text(angle = 90, vjust = .6, hjust = 1))


p

ggsave(filename = 'C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\HW4\\hw4_bigram_freq.png', plot = p, 
       scale = 1, width = par("din")[1], height = par("din")[2], units = 'in', dpi = 600)
