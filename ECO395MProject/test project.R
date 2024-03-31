library(dplyr)


vgchart = read.csv("vgchartz.csv")
vgchartfilt = vgchart %>% filter(!is.na(total_sales) & total_sales != "") %>% filter(!is.na(critic_score) & critic_score != "")
vgchartfilt
write.csv(vgchartfilt, "filt.csv")

data1 = read.csv("video_games.csv")
data2 = read.csv("2013_Video_Games_Dataset.csv")

merged_data = merge(data1, data2, by = c("Title", "Console"))

write.csv(merged_data, "big_vg.csv")

big_vg$zone = factor(capmetro$zone)
