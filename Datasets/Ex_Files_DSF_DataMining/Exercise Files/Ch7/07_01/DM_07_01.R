# Introduction to Data Analysis, Ch 11: Correlation and Regression

# For PowerPoint, save graphics as 1165 x 500, using
# width = 13.5, height = 6, dpi = 200.
# But for book use 12 x 6 @ 300

# Color palette:
# - Red:   firebrick3 (#136)
# - White: white      (#1)
# - Black: black      (#24)
# - Tan:   wheat      (#646)

# Use ggplot2 as much as possible
library("ggplot2")

# ======================================================================
# Figure 11.01 Scatterplot from Google Correlate.png
# ======================================================================

google <- read.csv("~/Desktop/google.csv", header = T)

ggplot(google, aes(modern.dance, nba)) + 
  # Regression line
  geom_smooth(method="lm",
              color = "gray70",
              size = 2,
              fill=NA,
              fullrange=TRUE) + 
  # Points
  geom_point(size=5, 
             color="firebrick3", 
             fill="firebrick3", 
             shape=21) +
  # Options
  annotate("text", x = 4.922, y = 2.15, label = "Utah",
           color = "black", size = 8) +
  xlab("Searches for \"modern dance\"") +
  ylab("Searches for \"NBA\"") +
  theme(text = element_text(size = 24))

ggsave("Figure 11.01 Scatterplot from Google Correlate.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 11.02 Correlations for Scatterplots.png
# ======================================================================

require("MASS")

# 1: r = 1.00
sigma1 <- matrix(c(1, 1, 1, 1), 2, 2)
scatter1 <- as.data.frame(mvrnorm(n = 100, mu = rep(0, 2), sigma1))

# 2. r = 0.75
sigma2 <- matrix(c(1, .75, .75, 1), 2, 2)
scatter2 <- as.data.frame(mvrnorm(n = 100, mu = rep(0, 2), sigma2))

# 3. r = 0.50
sigma3 <- matrix(c(1, .5, .5, 1), 2, 2)
scatter3 <- as.data.frame(mvrnorm(n = 100, mu = rep(0, 2), sigma3))

# 4. r = 0.25
sigma4 <- matrix(c(1, .25, .25, 1), 2, 2)
scatter4 <- as.data.frame(mvrnorm(n = 100, mu = rep(0, 2), sigma4))

# 5. r = 0.00
sigma5 <- matrix(c(1, 0, 0, 1), 2, 2)
scatter5 <- as.data.frame(mvrnorm(n = 100, mu = rep(0, 2), sigma5))

# 6. r = -0.25
sigma6 <- matrix(c(1, -.25, -.25, 1), 2, 2)
scatter6 <- as.data.frame(mvrnorm(n = 100, mu = rep(0, 2), sigma6))

# 7. r = -0.50
sigma7 <- matrix(c(1, -.5, -.5, 1), 2, 2)
scatter7 <- as.data.frame(mvrnorm(n = 100, mu = rep(0, 2), sigma7))

# 8. r = -0.75
sigma8 <- matrix(c(1, -.75, -.75, 1), 2, 2)
scatter8 <- as.data.frame(mvrnorm(n = 100, mu = rep(0, 2), sigma8))

# 9. r = -1.00
sigma9 <- matrix(c(1, -1, -1, 1), 2, 2)
scatter9 <- as.data.frame(mvrnorm(n = 100, mu = rep(0, 2), sigma9))

# Now join data frames
# Join data frames with cbind()
sps <- cbind(scatter1, scatter2, scatter3,
             scatter4, scatter5, scatter6,
             scatter7, scatter8, scatter9)

# Empty data frame
sp <- data.frame()  # sp = "scatterplot"


# Fill in sp data frame
rnames <- c("r = +1.00", "r = +0.75", "r = +0.50",
           "r = +0.25", "r = 0.00", "r = -0.25",
           "r = -0.50", "r = -0.75", "r = -1.00")
for(i in 1:9)
  sp <- rbind(sp, 
                data.frame(set = rnames[i], 
                           x = sps[, i * 2 - 1], 
                           y = sps[, i * 2]))

# Plot data
ggplot(sp, aes(x, y)) + 
  # Regression line
  geom_smooth(method="lm",
              color = "gray70",
              size = 2,
              fill = NA,
              fullrange = TRUE) + 
  # Points
  geom_point(size=3, 
             color = "firebrick3", 
             fill = "firebrick3", 
             shape = 21) +
  # Set scale
  theme(text = element_text(size = 18)) +
  # Four panels
  facet_wrap(~set, ncol = 3)

ggsave("Figure 11.02 Correlations for Scatterplots.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 11.03 Anscombes Quartet.png
# ======================================================================

# Based on https://gist.github.com/amoeba/7576126

library(ggplot2)

# Emtpy data frame
anscombe_m <- data.frame()

# Fill in data frame
# ("Anscombe" is a built-in dataset)
setname <- c("Set 1", "Set 2", "Set 3", "Set 4")
for(i in 1:4)
  anscombe_m <- rbind(anscombe_m, 
                      data.frame(set = setname[i], 
                                 x = anscombe[, i], 
                                 y = anscombe[, i + 4]))

# Plot data
ggplot(anscombe_m, aes(x, y)) + 
  # Regression line
  geom_smooth(method = "lm",
              color = "gray70",
              size = 2,
              fill = NA,
              fullrange = TRUE) + 
  # Points
  geom_point(size = 5, 
             color = "firebrick3", 
             fill = "firebrick3", 
             shape = 21) +
  # Set scale
  scale_x_continuous(limits = c(0, 20), 
                     breaks = seq(0, 20, 5)) +
  theme(text = element_text(size = 18)) +
  # Four panels
  facet_wrap(~set, ncol = 2)

ggsave("Figure 11.03 Anscombes Quartet.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 11.04. Scatterplot with Regression Line.png
# ======================================================================

ggplot(cars, aes(speed, dist)) + 
  # Regression line
  geom_smooth(method = "lm",
              color = "gray70",
              size = 2,
              fill = NA,
              fullrange = TRUE) +
  # Points
  geom_point(size = 5, 
             color = "#E38942", 
             fill = "#E38942", 
             shape = 21) +
  # Options
  xlab("Speed of Car [MPH]") +
  ylab("Distance to Stop [Feet]") +
  theme(text = element_text(size = 24))

ggsave("Figure 11.04. Scatterplot with Regression Line.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 11.05. Scatterplot with Residuals.png
# ======================================================================

# Get residuals
carfit <- lm(dist ~ speed, data = cars)

# Save new dataframe
cars2 <- as.data.frame(cbind(carfit$model$speed,
                             carfit$model$dist,
                             carfit$fitted.values))
colnames(cars2) <- c("Speed", "Distance", "Predicted")
cars2


ggplot(cars2, aes(Speed, Distance)) + 
  # Residuals lines
  geom_segment(aes(x = Speed,
                   xend = Speed,
                   y = Predicted,
                   yend = Distance,
                   color = "#E38942", 
                   fill = "#E38942", 
                   size = 1)) +
  # Regression line
  geom_smooth(method="lm",
              color = "gray70",
              size = 2,
              fill = NA,
              fullrange = TRUE) + 
  # Points
  geom_point(size = 5, 
             color = "#E38942", 
             fill = "#E38942", 
             shape = 21) +
  # Options
  xlab("Speed of Car [MPH]") +
  ylab("Distance to Stop [Feet]") +
  theme(text = element_text(size = 24)) +
  theme(legend.position = "none")

ggsave("Figure 11.05. Scatterplot with Residuals.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 11.06. Outliers in Regression.png
# ======================================================================

# Import data
outliers <- read.csv("~/Desktop/outliers.csv", header = T)
# Manually set order of factor to control panel order
outliers$Set <- factor(outliers$Set,
                       levels = c("No Outliers",
                                  "Outlier on X",
                                  "Outlier on Y",
                                  "Bivariate Outlier"))

# Plot data
ggplot(outliers, aes(X, Y)) + 
  # Regression line
  geom_smooth(method = "lm",
              color = "gray70",
              size = 2,
              fill = NA,
              fullrange = TRUE) + 
  # Points
  scale_color_manual(values = c("gray50", "firebrick3")) +  
  scale_fill_manual(values = c("gray50", "firebrick3")) +  
  geom_point(size=5,
             shape=21,
             aes(color = factor(Outlier),
                 fill = factor(Outlier))) + 
  # Set scale
  theme(text = element_text(size = 18)) +
  # Four panels
  facet_wrap(~Set, ncol=2) +
  theme(legend.position = "none")

ggsave("Figure 11.06. Outliers in Regression.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)
