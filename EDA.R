library(dplyr)
library(ggplot2)
library(here)
library(plotly)
library(ggpubr)
library(moments)

distances_stats_f <- function(data,t){
  # print(t)
  # View(data)
  temp <- filter(data,time==t)
  # View(temp)
  temp1 <- mean(sqrt(temp$x^2+temp$y^2+temp$z^2))
  temp2 <- median(sqrt(temp$x^2+temp$y^2+temp$z^2))
  temp3 <- nrow(temp)
  
  temp4 <- mean(sqrt(temp$vx^2+temp$vy^2+temp$vz^2))
  temp5 <- median(sqrt(temp$vx^2+temp$vy^2+temp$vz^2))
  
  temp6 <- c(mean(temp$x),mean(temp$y),mean(temp$z))
  
  temp6[1] <- mean(temp$x)
  temp6[2] <- mean(temp$y)
  temp6[3] <- mean(temp$z)
  
  ret <- list(temp1,temp2,temp3,temp4,temp5,temp6)
  return (ret)
  
}




setwd(here("Dataset"));
# getwd()

data0 <- read.csv("c_0000.csv")
data1 <- read.csv("c_0100.csv")
data2 <- read.csv("c_0200.csv")
data3 <- read.csv("c_0300.csv")
data4 <- read.csv("c_0400.csv")
data5 <- read.csv("c_0500.csv")
data6 <- read.csv("c_0600.csv")
data7 <- read.csv("c_0700.csv")
data8 <- read.csv("c_0800.csv")
data9 <- read.csv("c_0900.csv")
data10 <- read.csv("c_1000.csv")
data11 <- read.csv("c_1100.csv")
data12 <- read.csv("c_1200.csv")
data13 <- read.csv("c_1300.csv")
data14 <- read.csv("c_1400.csv")
data15 <- read.csv("c_1500.csv")
data16 <- read.csv("c_1600.csv")
data17 <- read.csv("c_1700.csv")
data18 <- read.csv("c_1800.csv")



data0$time <- 0
data1$time <- 1
data2$time <- 2
data3$time <- 3
data4$time <- 4
data5$time <- 5
data6$time <- 6
data7$time <- 7
data8$time <- 8
data9$time <- 9
data10$time <- 10
data11$time <- 11
data12$time <- 12
data13$time <- 13
data14$time <- 14
data15$time <- 15
data16$time <- 16
data17$time <- 17
data18$time <- 18

data_all <- rbind(data0,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,
                  data13,data14,data15,data16,data17,data18)


time <- c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
df_stats <- data.frame(time)
df_stats$mean_d <- 0
df_stats$median_d <- 0
df_stats$number <- 0
df_stats$mean_v <- 0
df_stats$median_v <- 0


# View(df_stats)

com <- data.frame(time)
com$x<-0
com$y<-0
com$z<-0


i<-1
while(i<=19){
  
  temp <- distances_stats_f(data_all,i-1)
  
  temp
  temp[[6]][1]
  df_stats[i,2] <- temp[[1]]
  df_stats[i,3] <- temp[[2]]
  
  df_stats[i,4] <- temp[[3]]
  
  df_stats[i,5] <- temp[[4]]
  df_stats[i,6] <- temp[[5]]
  
  com[i,2] <- temp[[6]][1]
  com[i,3] <- temp[[6]][2]
  com[i,4] <- temp[[6]][3]

  i<-i+1
}


# temp <- distances_stats_f(data_all,0)
# df_stats[1,2] <- temp[[1]]
# 
# typeof(df_stats[1,2])
# temp_1 <- distances_stats_f(data_all,0)
# typeof(temp[1][1])
# typeof(temp[[1]])
# 
# df_stats$mean<-as.numeric(levels(df_stats$mean))[df_stats$mean]
# 
# typeof(df_stats$mean)
# typeof(df_stats$time)

ggplot(data=df_stats, aes(x=time, y=mean_d, group=1)) + 
  labs(title="Time vs Mean Distance",x="Time",y="Mean distance of all the stars") +
  geom_line() +
  geom_point()


ggplot(data=df_stats, aes(x=time, y=median_d, group=1)) + 
  labs(title="Time vs Median Distance",x="Time",y="Median distance of all the stars") +
  geom_line() +
  geom_point()

ggplot(data=df_stats, aes(x=time, y=number, group=1)) + 
  labs(title="Time vs Number of Stars",x="Time",y="Number of Stars") +
  geom_line() +
  geom_point()




ggplot(data=df_stats, aes(x=time, y=mean_v, group=1)) + 
  labs(title="Time vs Mean Velocity",x="Time",y="Mean velocity of all the stars") +
  geom_line() +
  geom_point()


ggplot(data=df_stats, aes(x=time, y=median_v, group=1)) + 
  labs(title="Time vs Median Velocity",x="Time",y="Median velocity of all the stars") +
  geom_line() +
  geom_point()


star_id <- data_all %>% count(id)

out_of_cluster <- star_id %>% filter(n!=19)


#Stars that are out of clusters
out_of_cluster_data <- data_all %>% filter(id %in% (out_of_cluster$id))

survive_1 <- out_of_cluster_data %>% group_by(id) %>% filter(n() == 1)

ooc_list = split(out_of_cluster_data, f = out_of_cluster_data$id)

#ooc_list[[1]]

#the positions of stars that left the cluster
p1 <- plot_ly(ooc_list[[1]], x = ~ooc_list[[1]]$x,y=~ooc_list[[1]]$y,z=~ooc_list[[1]]$z,color = ~time)
p2 <- plot_ly(ooc_list[[18]], x = ~ooc_list[[18]]$x,y=~ooc_list[[18]]$y,z=~ooc_list[[18]]$z,color = ~time)


#p1
out_of_cluster_data$distance <- sqrt(out_of_cluster_data$x^2+out_of_cluster_data$y^2+out_of_cluster_data$z^2)
out_of_cluster_data$velocity <- sqrt(out_of_cluster_data$vx^2+out_of_cluster_data$vy^2+out_of_cluster_data$vz^2)

data_all_temp <- data_all

data_all_temp$distance <- sqrt(data_all_temp$x^2+data_all_temp$y^2+data_all_temp$z^2)
data_all_temp$velocity <- sqrt(data_all_temp$vx^2+data_all_temp$vy^2+data_all_temp$vz^2)

cor_d_v <- cor(data_all_temp$distance,data_all_temp$velocity)

for_cor <- data_all_temp %>%
  select(x, y, z, vx, vy, vz, distance, velocity)

cor(for_cor, method = c("pearson", "kendall", "spearman"))

hist(for_cor$x,xlab = "Value of x",breaks=1000,xlim = c(-3,3),main = "Histogram for position x")
hist(for_cor$y,xlab = "Value of y",breaks=1000,xlim = c(-3,3),main = "Histogram for position y")

hist(for_cor$z,xlab = "Value of z",breaks=1000,xlim = c(-3,3),main = "Histogram for position z")

hist(for_cor$vx,xlab = "Value of vx",breaks=60,xlim = c(-2,2),main = "Histogram for velocity in x direction")

hist(for_cor$vy,xlab = "Value of vy",breaks=60,xlim = c(-2,2),main = "Histogram for velocity in y direction")

hist(for_cor$vz,xlab = "Value of vz",breaks=60,xlim = c(-2,2),main = "Histogram for velocity in z direction")

#ggqqplot(for_cor$x)

# qqnorm(for_cor$x)

# ggqqplot(for_cor$vx)

# ggqqplot(for_cor$vy)

skewness(for_cor$x)

kurtosis(for_cor$vz)

p1

p2

p_com <- plot_ly(com, x = ~x, y = ~y, z = ~z, type = 'scatter3d', mode = 'lines',
             opacity = 1, line = list(width = 6, color = ~time, reverscale = FALSE)) %>% layout(title = "Centre of mass of cluster")
        
        

p_com