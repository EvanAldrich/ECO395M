library(tidyverse)
library(ggplot2)
library(modelr)
library(mosaic)
library(foreach)
library(dplyr)
library(rpart)
library(rpart.plot)
library(rsample) 
library(randomForest)
library(lubridate)
library(modelr)
library(gbm)
library(pdp)
library(ggmap)
library(osmdata)
library(tidyr)
library(caret)

###vgchatz Data set
vgchart = read.csv("vgchartz.csv")
vgchart = na.omit(vgchart)
vgchartfilt = vgchart %>% filter(!is.na(total_sales) & total_sales != "") %>% filter(!is.na(critic_score) & critic_score != "")
vgchartfilt
write.csv(vgchart, "chartvg.csv")
view(vgchart)
ggplot(vgchart) + geom_point(aes(x=jp_sales, y=na_sales, color = console))




vg_2020 = read.csv("vg_2020.csv")

vg_2020 = na.omit(vg_2020)
view(vg_2020)
write.csv(vg_2020, "vg2_2020.csv")
ggplot(vg_2020) + geom_point(aes(x=jp_sales, y=na_sales, color = console))


#7018 observations 2016 
vg_2016 = read.csv("vgsales2016.csv")
vg_2016 = na.omit(vg_2016)
view(vg_2016)
write.csv(vg_2016, "vg3_2016.csv")



vg_2016 = read.csv("vg2_2016.csv")
vg_2016 = vg_2016 %>% filter(NA_Sales < 25)
vg_2016$NA_Sales = log(vg_2016$NA_Sales)
vg_2016$EU_Sales = log(vg_2016$EU_Sales)
vg_2016$JP_Sales = log(vg_2016$JP_Sales)
vg_2016 = na.omit(vg_2016)
#vg_2016$Name = factor(vg_2016$Name)
vg_2016$Platform = factor(vg_2016$Platform)
vg_2016$Year = factor(vg_2016$Year)
vg_2016$Genre = factor(vg_2016$Genre)
vg_2016$Publisher = factor(vg_2016$Publisher)
vg_2016$Developer = factor(vg_2016$Developer)
vg_2016$Rating = factor(vg_2016$Rating)

vg2016_split = initial_split(vg_2016, prop=0.8)
vg2016_train = training(vg2016_split)
vg2016_test = testing(vg2016_split)

str(vg2016_train)

tree_cart_big=rpart(NA_Sales ~ . - Name, data=vg2016_train, method = "anova") 
rpart.plot(tree_cart_big, digits=-5, type=4, extra=1)
a= rmse(tree_cart_big, vg2016_test)

lm_model <- lm(NA_Sales ~ . - Name - Developer - Publisher, data = vg2016_train)
predictions_lm <- predict(lm_model, newdata = vg2016_test)

ggplot(vg_2016) + geom_point(aes(x=EU_Sales, y=NA_Sales, color = Genre))
ggplot(vg_2016) + geom_point(aes(x=JP_Sales, y=NA_Sales, color = Genre))
ggplot(vg_2016) + geom_point(aes(x=JP_Sales, y=EU_Sales, color = Genre))

#time to beat data 
data1 = read.csv("video_games.csv")
data2 = read.csv("2013_Video_Games_Dataset.csv")
data1 = na.omit(data1)
data2 = na.omit(data2)

merged_data = merge(data1, data2, by = c("Title", "Console"))
merged_data = na.omit(merged_data)

merged_data = filter(merged_data, Length.Completionists.Rushed > 0)

merged_data = filter(merged_data, Length.Main...Extras.Polled > 0)
merged_data$console = factor(merged_data$console)
merged_data$Max_Players = factor(merged_data$Max_Players)
merged_data$Genres = factor(merged_data$Genres)
merged_data$Title = factor(merged_data$Title)
write.csv(merged_data, "merged_data.csv")
vgs = merged_data %>% filter(US_Sales < 8)

ggplot(vgs) + geom_point(aes(x=Length.All.PlayStyles.Average, y=US_Sales, color = Release.Rating))
ggplot(vgs) + geom_point(aes(x=Used_Price, y=US_Sales, color = Release.Rating))

ggplot(vgs) + geom_point(aes(x=Review_Score, y=US_Sales, color = Release.Rating))

vgs_split = initial_split(vgs, prop=0.8)
vgs_train = training(vgs_split)
vgs_test = testing(vgs_split)

tree_cart_big=rpart(US_sales ~ . , data=dengue_train, control=rpart.control(cp=0.0015, minsplit=30)) 
rpart.plot(tree_cart_big, digits=-5, type=4, extra=1)
a= rmse(tree_cart_big, dengue_test)

view(merged_data)
write.csv(merged_data, "big_vg.csv")

big_vg$zone = factor(capmetro$zone)




