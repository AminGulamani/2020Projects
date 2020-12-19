library(tidyverse)
library(ggplot2)
library(modelr)
library(sjPlot)
library(sjmisc)
library(sjlabelled)
library(factoextra)
library(wesanderson)

setwd("C:/Users/Amin Gulamani/Desktop/FEH PowerCreep")
funits <- read.csv("funits.csv", header=TRUE, row.names="Name")

#Sword unit archetyping
speedRME <- filter(funits, MT == "Infantry", WT == "Melee", Colour == "Red")
speedRME <- speedRME %>% select(Hihp,Hiatk,Hispd,Hidef,Hires,Hibst,DSR)
#Scale
set.seed(123)
speedRME1 <- scale(speedRME)
#optimal number of clusters and clust
fviz_nbclust(speedRME1, kmeans, method = "wss")
km.res <- kmeans(speedRME1, 3, nstart = 25)
#visualize clusters
p1 <- fviz_cluster(km.res, geom = "point", data = speedRME1) + ggtitle("k = 2")
p1
#plotting fun!
plot <- ggplot(speedRME, aes(color =km.res$cluster, x = DSR, y = Hibst))+geom_point()
plot

#Infantry unit archetyping
speedRME <- filter(funits, MT == "Infantry", WT == "Melee")
speedRME <- speedRME %>% select(Hihp,Hiatk,Hispd,Hidef,Hires,Hibst,DSR,Dance,Legendary,Mythic,Ratings)
#Scale
set.seed(123)
speedRME1 <- scale(speedRME)
#optimal number of clusters and clust
fviz_nbclust(speedRME1, kmeans, method = "wss")
set.seed(313)
km.res <- kmeans(speedRME1, 4, nstart = 25)
#visualize clusters
p1 <- fviz_cluster(km.res, geom = "point", data = speedRME1) + ggtitle("k = 2")
p1
#plotting fun!
plot <- ggplot(speedRME, aes(color =km.res$cluster, x = Hiatk, y = Hispd))+geom_point()+
      scale_color_gradientn(colours = rainbow(4))
plot
plot <- ggplot(speedRME, aes(color =km.res$cluster, x = DSR, y = Hibst))+geom_point()+scale_color_gradientn(colours = rainbow(4))
plot
#centers of the groups
km.res$centers
dend <- speedRME %>%  scale %>% 
  dist %>% hclust %>% as.dendrogram
dend %>% plot

#Infantry unit archetyping
speedRME <- filter(funits, MT == "Infantry", WT == "Melee")
speedRME <- speedRME %>% select(Hibst,DSR)
#Scale
set.seed(123)
speedRME1 <- scale(speedRME)
#optimal number of clusters and clust
fviz_nbclust(speedRME1, kmeans, method = "wss")
set.seed(313)
km.res <- kmeans(speedRME1, 6, nstart = 25)
#visualize clusters
p1 <- fviz_cluster(km.res, geom = "point", data = speedRME1) + ggtitle("k = 2")
p1
#plotting fun!

plot <- ggplot(speedRME, aes(color =km.res$cluster, x = DSR, y = Hibst))+geom_point()+scale_color_gradientn(colours = rainbow(4))
plot




#Global unit archetyping
speedRME <-funits
speedRME <- speedRME %>% select(MA,WR,Hibst,DSR,Dance)
#Scale
set.seed(123)
speedRME1 <- scale(speedRME)
#optimal number of clusters and clust
fviz_nbclust(speedRME1, kmeans, method = "wss")

km.res <- kmeans(speedRME1, 5, nstart = 25)
#visualize clusters
p1 <- fviz_cluster(km.res, geom = "point", data = speedRME1) + ggtitle("k = 2")
p1
#plotting fun!
plot <- ggplot(speedRME, aes(color = km.res$cluster, x = MA, y = Hibst))+geom_point()+scale_color_gradientn(colours = rainbow(4))
plot
plot <- ggplot(speedRME, aes(color = km.res$cluster, x = DSR, y = Hibst))+geom_point()+scale_color_gradientn(colours = rainbow(4))
plot
#centers of the groups
km.res$centers







plot <- ggplot(speedRME) + geom_point(aes(x = DSR, y = Hispd))
plot


funits <-
  funits %>%
  mutate(DSR2 = DSR * DSR)

model <- lm(Hibst ~ DSR, family = binomial, data = funits)
modelA <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Armored"))
modelC <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Cavalry"))
modelF <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Flying"))
modelI <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Infantry"))
summary(modelIR2)
tab_model(modelIR2)
tab_model(modelC)
tab_model(modelF)
tab_model(modelI)

plot <- ggplot(funits, aes(x = DSR, y = Hibst, colour = MT)) + geom_point()
plot <- plot + stat_smooth(data = funits, method="lm", se=TRUE,
                           formula= y ~ poly(x, 1, raw=TRUE),colour="purple")
plot


plot <- ggplot(filter(funits, MT == "Infantry"))  + geom_point(aes(x = DSR, y = Hibst))
plot <- plot + geom_abline(intercept = 1.464e+02, slope = 1.407e-02)
plot <- plot + geom_abline(intercept = 1.570e+02, slope = 1.352e-02)
plot

plot <- ggplot(filter(funits, MT == "Infantry", WT == "Melee"))  + geom_point(aes(x = DSR, y = Hibst, color = Dance))
plot

plot <- ggplot(filter(funits, MT == "Infantry", WT == "Melee"))  + geom_point(aes(x = DSR, y = Hibst, color = Ratings, alpha = 0.1))
plot

plot <- ggplot(filter(funits, MT == "Infantry", WT == "Melee"))  + geom_point(aes(x = DSR, y = Hibst, color = Legendary))
plot

plot <- ggplot(filter(funits, MT == "Infantry", WT == "Melee"))  + geom_point(aes(x = DSR, y = Hibst, color = Colour))
plot



#Range/Melee split by movement Type
#Infantry
funitsIR <- filter(funits, MT == "Infantry", WT == "Ranged")
funitsIM <- filter(funits, MT == "Infantry", WT == "Melee")
plot <- ggplot(filter(funits, MT == "Infantry"), aes(x = DSR, y = Hibst, colour = WT)) + geom_point()
plot <- plot + stat_smooth(data = funitsIR, method="lm", se=TRUE,
                           formula= y ~ poly(x, 2, raw=TRUE),colour="purple")+
                stat_smooth(data = funitsIM, method="lm", se=TRUE,
                           formula= y ~ poly(x, 2, raw=TRUE),colour="blue")
plot

funitsCR <- filter(funits, MT == "Cavalry", WT == "Ranged")
funitsCM <- filter(funits, MT == "Cavalry", WT == "Melee")
plot <- ggplot(filter(funits, MT == "Cavalry"), aes(x = DSR, y = Hibst, colour = WT)) + geom_point()
plot <- plot + stat_smooth(data = funitsCR, method="lm", se=TRUE,
                           formula= y ~ poly(x, 2, raw=TRUE),colour="blue")+
  stat_smooth(data = funitsCM, method="lm", se=TRUE,
              formula= y ~ poly(x, 2, raw=TRUE),colour="green")
plot

funitsFR <- filter(funits, MT == "Flying", WT == "Ranged")
funitsFM <- filter(funits, MT == "Flying", WT == "Melee")
plot <- ggplot(filter(funits, MT == "Flying"), aes(x = DSR, y = Hibst, colour = WT)) + geom_point()
plot <- plot + stat_smooth(data = funitsFR, method="lm", se=TRUE,
                           formula= y ~ poly(x, 2, raw=TRUE),colour="purple")+
  stat_smooth(data = funitsFM, method="lm", se=TRUE,
              formula= y ~ poly(x, 2, raw=TRUE),colour="blue")
plot

funitsAR <- filter(funits, MT == "Armored", WT == "Ranged")
funitsAM <- filter(funits, MT == "Armored", WT == "Melee")
plot <- ggplot(filter(funits, MT == "Armored"), aes(x = DSR, y = Hibst, colour = WT)) + geom_point()
plot <- plot + stat_smooth(data = funitsAR, method="lm", se=TRUE,
                           formula= y ~ poly(x, 2, raw=TRUE),colour="purple")+
  stat_smooth(data = funitsAM, method="lm", se=TRUE,
              formula= y ~ poly(x, 2, raw=TRUE),colour="blue")
plot



modelIMS <- lm(Hibst ~ DSR + Dance, family = binomial, data = funits)
tab_model(modelIMS)
clustIM <- 
  filter(funitsIM, Dance == 0) %>%
  select(DSR, Hibst)

set.seed(42)
fviz_nbclust(clustIM, kmeans,
             nstart = 25,
             method = "gap_stat",
             nboot = 500
) + # reduce it for lower computation time (but less precise results)
  labs(subtitle = "Gap statistic method")



hclust(clustIM)

km_res <- kmeans(clustIM, centers = 2, nstart = 20)
fviz_cluster(km_res, clustIM, ellipse.type = "norm")

clustIM <- 
  filter(funitsIM) %>%
  select(DSR, Hibst, Dance, Duo, Legendary, Mythic)
# Euclidean distance
dist <- dist(clustIM , diag=TRUE)
# Hierarchical Clustering with hclust
hc <- hclust(dist)
# Plot the result
plot(hc)


aggregate(clustIM,by=list(fit$cluster),FUN=mean)






modelIM <- lm(Hibst ~ DSR, family = binomial, data = funitsIM)
modelIR <- lm(Hibst ~ DSR, family = binomial, data = funitsIR)
modelIR2 <- lm(Hibst ~ DSR + DSR2, family = binomial, data = filter(funits, MT == "Infantry", Range== "Ranged"))



plot <- ggplot(funits)  + geom_point(aes(x = DSR, y = Hibst, colour = Range))
plot <- plot + geom_abline(intercept = 1.528e+02, slope = 1.158e-02)
plot

plot <- ggplot(funits) + geom_point(aes(x = DSR, y = Lowbst))+ geom_point(aes(x = DSR, y = Hibst, color = 'red'))
plot <- plot + geom_abline(intercept = 1.514e+02, slope = 1.138e-02) + geom_abline(intercept = 1.528e+02, slope = 1.158e-02, color = 'red')
plot


