# DM_05_03.R

# INSTALL AND LOAD PACKAGES ################################

pacman::p_load(ggplot2, grid, gridExtra, robustbase) 

# DATA #####################################################

# Import the data
data = read.csv("~/Desktop/AnomalyData.csv")

# Structure of the data
str(data)

# Transform variables to factors
data$PsychRegions = as.factor(data$PsychRegions)
data$region = as.factor(data$region)
data$division = as.factor(data$division)

# UNIVARIATE OUTLIERS ######################################

# Using boxplots for each variable separately

# data.science
u01 <- qplot(data = data, y = data.science, x = 1, 
         geom = "boxplot", outlier.colour = "#E38942",
         xlim = c(0, 2), xlab=NULL, ylab = NULL, 
         main="data.science") +
       geom_text(aes(label = ifelse(data.science %in% 
         boxplot.stats(data.science)$out,
         as.character(state_code), "")), hjust = 1.5)
u01

# cluster.analysis
u02 <- qplot(data = data,y = cluster.analysis, x = 1, 
         geom = "boxplot", outlier.colour = "#E38942",
         xlim = c(0, 2), xlab = NULL, ylab = NULL,
         main = "cluster.analysis") +
       geom_text(aes(label = ifelse(cluster.analysis %in% 
         boxplot.stats(cluster.analysis)$out,
         as.character(state_code), "")), hjust = 1.5)
u02

# college
u03 <- qplot(data = data, y = college, x = 1, 
         geom = "boxplot", outlier.colour = "#E38942",
         xlim = c(0, 2), xlab = NULL, ylab = NULL, 
         main="college") +
       geom_text(aes(label = ifelse(college %in% 
         boxplot.stats(college)$out,
         as.character(state_code), "")), hjust = 1.5)
u03

# startup
u04 <- qplot(data = data, y = startup, x = 1, 
         geom = "boxplot", outlier.colour = "#E38942",
         xlim = c(0, 2), xlab = NULL, ylab = NULL, 
         main="startup") +
       geom_text(aes(label = ifelse(startup %in% 
         boxplot.stats(startup)$out,
         as.character(state_code), "")), hjust = 1.5)
u04

# entrepreneur
u05 <- qplot(data = data, y = entrepreneur, x = 1, 
         geom = "boxplot", outlier.colour = "#E38942",
         xlim = c(0, 2), xlab = NULL, ylab = NULL, 
         main="entrepreneur") +
       geom_text(aes(label = ifelse(entrepreneur %in% 
         boxplot.stats(entrepreneur)$out,
         as.character(state_code), "")), hjust = 1.5)
u05

# ceo
u06 <- qplot(data = data, y = ceo, x = 1, 
         geom = "boxplot", outlier.colour = "#E38942",
         xlim = c(0, 2), xlab = NULL, ylab = NULL, 
         main="ceo") +
       geom_text(aes(label = ifelse(ceo %in% 
         boxplot.stats(ceo)$out,
         as.character(state_code), "")), hjust = 1.5)
u06

# mortgage
u07 <- qplot(data = data, y = mortgage, x = 1, 
         geom = "boxplot", outlier.colour = "#E38942",
         xlim = c(0, 2), xlab = NULL, ylab = NULL, 
         main="mortgage") +
       geom_text(aes(label = ifelse(mortgage %in% 
         boxplot.stats(mortgage)$out,
         as.character(state_code), "")), hjust = 1.5)
u07

# nba
u08 <- qplot(data = data, y = nba, x = 1, 
         geom = "boxplot", outlier.colour = "#E38942",
         xlim = c(0, 2), xlab = NULL, ylab = NULL, 
         main="nba") +
       geom_text(aes(label = ifelse(nba %in% 
         boxplot.stats(nba)$out,
         as.character(state_code), "")), hjust = 1.5)
u08

# royal.family
u09 <- qplot(data = data, y = royal.family, x = 1, 
         geom = "boxplot", outlier.colour = "#E38942",
         xlim = c(0, 2), xlab = NULL, ylab = NULL, 
         main="royal.family") +
       geom_text(aes(label = ifelse(royal.family %in% 
         boxplot.stats(royal.family)$out,
         as.character(state_code), "")), hjust = 1.5)
u09

# Neuroticism
u10 <- qplot(data = data, y = Neuroticism, x = 1, 
         geom = "boxplot", outlier.colour = "#E38942",
         xlim = c(0, 2), xlab = NULL, ylab = NULL, 
         main="Neuroticism") +
       geom_text(aes(label = ifelse(Neuroticism %in% 
         boxplot.stats(Neuroticism)$out,
         as.character(state_code), "")), hjust = 1.5)
u10

# Plot all 10 together
grid.arrange(u01, u02, u03, u04, u05,
             u06, u07, u08, u09, u10,
             nrow = 2, 
             top = "Boxplots: Univariate outliers")

# BIVARIATE OUTLIERS #######################################

# data.science vs cluster.analysis
b1 <- qplot(data = data, 
        x = data.science,
        y = cluster.analysis,
        main = "data.science vs cluster.analysis") +
      stat_ellipse(level = .99, color = "#E38942") +
      geom_text(aes(label =
      ifelse((data.science>1.8 | cluster.analysis>1.6),
        as.character(state_code), "")), 
        hjust = 1.5)
b1 

# mortgage vs ceo
b2 <- qplot(data = data,
        x = mortgage,
        y = ceo, 
        main = "mortgage vs ceo") +
      stat_ellipse(level = .99, color = "#E38942") +
      geom_text(aes(label =
        ifelse(ceo > 2,
        as.character(state_code), "")), 
        hjust = 1.5)
b2

# modern.dance vs Openness
b3 <- qplot(data = data,
        x = modern.dance, 
        y = Openness,
        main = "modern.dance vs Openness") +
      stat_ellipse(level = .99,color = "#E38942") +
      geom_text(aes(label =
        ifelse((modern.dance > 2 | Openness < 30),
        as.character(state_code),"")), 
        hjust = 1.5)
b3

# fifa vs nba
b4 <- qplot(data = data,
        x = fifa,
        y = nba, 
        main = "fifa vs nba") +
      stat_ellipse(level = .99, color = "#E38942") +
      geom_text(aes(label =
        ifelse(fifa > 2,
        as.character(state_code), "")), 
        hjust = 1.5)
b4

# subaru vs escalade
b5 <- qplot(data = data,
        x = subaru,
        y = escalade,
        main = "subaru vs escalade") +
      stat_ellipse(level = .99, color = "#E38942") +
      geom_text(aes(label =
        ifelse(subaru > 2.5,
        as.character(state_code), "")), 
        hjust = 1.5)
b5

# unicorn vs obsfucation
b6 <- qplot(data = data,
        x = unicorn,
        y = obfuscation,
        main = "unicorn vs obfuscation") +
      stat_ellipse(level = .99, color = "#E38942") +
      geom_text(aes(label =
        ifelse((unicorn > 2 | obfuscation > 2),
        as.character(state_code), "")), 
        hjust = 1.5)
b6

# Conscientiousness vs Extraversion
b7 <- qplot(data = data,
        x = Conscientiousness,
        y = Extraversion,
        main = "Conscientiousness vs Extraversion") +
      stat_ellipse(level = .99, color = "#E38942") 
b7

# college vs royal.family
b8 <- qplot(data = data,
        x = college,
        y = royal.family,
        main = "college vs royal.family") + 
     stat_ellipse(level = .99, color = "#E38942") 
b8

# Plot all 8 together
grid.arrange(b1, b2, b3, b4, b5, b6, b7, b8,
  nrow = 2, top = "Bivariate outliers")

# MULTIVARIATE OUTLIERS ####################################

# Measure overall distance of case from other using both
# Mahalanobis distance and a robust measures of distance.

# Create dataset with only quantitative variables
mcd = covMcd(data[-c(1, 2, 28, 29, 30)])

par(mfrow = c(1, 2))
# Mahalanobis vs. robust distance
plot(mcd, 
     which = "dd", 
     labels.id = as.character(data$state_code))
# QQ plot for robust distance
plot(mcd,
     which = "qqchi2",
     labels.id = as.character(data$state_code))


# CLEAN UP #################################################

# Clear workspace
rm(list = ls()) 

# Clear packages
pacman::p_unload(ggplot2, grid, gridExtra, robustbase)

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L
