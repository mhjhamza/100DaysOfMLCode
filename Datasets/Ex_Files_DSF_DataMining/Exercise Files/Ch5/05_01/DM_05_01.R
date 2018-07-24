# DM_05_01_GoalsOfAnomalyDetection

library("ggplot2")

# ======================================================================
# Figure 02.02. A Better Bar Chart
# ======================================================================

data1 <- read.table(
  header = TRUE, # First row is header
  # No comments within data
  text = '
     Level  Percent
     "No High School"    11
     "Some High School"  14
     "High School Grad"  30
     "Some College"      19
     "Associates Degree"  6
     "Bachelors Degree"  13
     "Grad Degree"        6
     "PhD"                2
  ')
data1$Level <- factor(data1$Level,
                      levels = c("No High School",
                                 "Some High School",
                                 "High School Grad",
                                 "Some College",
                                 "Associates Degree",
                                 "Bachelors Degree",
                                 "Grad Degree",
                                 "PhD"))
data1  # check data

ggplot(data = data1, aes(x = Level, y = Percent)) + 
  geom_bar(stat = "identity", fill = "#1D76B5") +
  coord_flip() +
  ylab("Percent of US Adults") +
  theme(axis.title.y = element_blank()) +  # No title on X axis
  theme(text = element_text(size = 24)) +
  theme(legend.position = "none")

ggsave("Figure 02.02. A Better Bar Chart.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.09. Boxplot.png
# ======================================================================

# As a note, save graphics as 1165 x 500, as that is the proportion
# for the images in the PowerPoint template I'm using
# For saving, using width = 13.5, height = 6, dpi = 200
# Byut for book use 12 x 6 @ 300

# Color palette:
# - Red:   firebrick3 (#136)
# - White: white      (#1)
# - Black: black      (#24)
# - Tan:   wheat      (#646)


# This is a basic boxplot for normal data
x1 <- rnorm(500)     # Normal
x2 <- rchisq(100, 2) # Skewed
# The default R version
boxplot(x1, horizontal = TRUE)

# The ggplot2 boxplot for one variable
ggplot(NULL, aes(x = 1, y = x2)) +
  geom_boxplot(fill = "firebrick3", outlier.colour = "firebrick3",
               size = 1, outlier.size = 5) +
  coord_flip() +
  theme(axis.title.x = element_blank()) +  # No title on X axis
  theme(axis.title.y = element_blank()) +  # No title on Y axis
  theme(axis.text.x = element_blank()) +   # No ticks/labels on X axis
  theme(axis.text.y = element_blank())     # No ticks/labels on Y axis

# Same with titles: Use this one
ggplot(NULL, aes(x = 1, y = x2)) +
  geom_boxplot(fill = "firebrick3", outlier.colour = "firebrick3",
               size = 1, outlier.size = 5) +
  coord_flip() +
  theme(axis.title.y = element_blank()) +  # No title on X axis
  theme(axis.text.y = element_blank()) +   # No ticks/labels on X axis
  ylab("Scores on Outcome Variable") +  # Title on Y axis
  theme(text = element_text(size = 24))

# This command saves as PNG at 300 DPI
ggsave("Figure 02.09. Boxplot.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.10. Boxplot Anatomy.png
# ======================================================================

x2 <- rchisq(100, 2) # Skewed data

# Same with titles: Use this one
ggplot(NULL, aes(x = 1, y = x2)) +
  geom_boxplot(fill = "#E38942",
               outlier.colour = "#E38942",
               size = 1,
               outlier.size = 5) +
  coord_flip() +
  theme(axis.title.y = element_blank()) +  # No title on X axis
  theme(axis.text.y = element_blank()) +   # No ticks/labels on X axis
  ylab("Scores on Outcome Variable") +  # Title on Y axis
  theme(text = element_text(size = 24))

# This command saves as PNG at 300 DPI
ggsave("Figure 02.09. Boxplot.png", width = 12, height = 6, dpi = 300)

# Old version that doesn't use ggplot2
# This generates skewed data using a chi-squared distribution and
# adds a jittered dotplot over the boxplot
# See http://rss.acs.unt.edu/Rdoc/library/stats/html/Chisquare.html
x2 <- rchisq(100, 2) # Easier to use chisq: n, df, ncp
boxplot(x2, horizontal = TRUE)
stripchart(x2, add = TRUE, method = "jitter", col = "#E38942", pch = 20)

# ======================================================================
# Figure 02.11. Side-by-Side Boxplots.png
# ======================================================================

# Multiple boxplots
mbdf <- data.frame(group = rep(c(1:5), each = 200), value = rnorm(1000))
str(mbdf)
ggplot(mbdf, aes(factor(group), value)) +
  geom_boxplot(fill = "firebrick3", outlier.colour = "firebrick3",
               size = 1, outlier.size = 3) +
  coord_flip() +
  theme(axis.title.y = element_blank()) +  # No title on X axis
  theme(axis.text.y = element_blank()) +   # No ticks/labels on X axis
  ylab("Scores on Outcome Variable") +  # Title on Y axis
  theme(text = element_text(size = 24))

# This command saves as PNG at 300 DPI
ggsave("Figure 02.11. Side-by-Side Boxplots.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.12. Bell Curve.png
# ======================================================================

# SHAPE
# Draw standard normal distribution using ggplot2 (just the line)
p <- ggplot(data.frame(x = c(-3, 3)), aes(x = x))
p + stat_function(fun = dnorm, size = 3, colour = "firebrick3") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Relative Frequency") +
  theme(text = element_text(size = 24))

ggsave("Figure 02.12. Bell Curve.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.13. Histogram of Normal Distribution.png
# ======================================================================

# Draw standard normal distribution using ggplot2 (a histogram)
xnorm <- rnorm(10000)
ggplot(NULL, aes(x = xnorm)) + 
  geom_histogram(binwidth = 0.5, fill = "firebrick3", colour = "white") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Frequency") +
  theme(text = element_text(size = 24))

ggsave("Figure 02.13. Histogram of Normal Distribution.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# Or draw a normal distribution using standard methods
x <- seq(-4, 4, length=200)
# y <- 1/sqrt(2*pi)*exp(-x^2/2) # Manual method
y1 <- dnorm(x) # Built-in function using defaults
# Or specify values but check range on chart
# y1 <- dnorm(x, mean=100, sd=15) Can specify M & SD
# Use lwd = 2 for small chart, lwd = 5 for large
plot(x, y1, type="l", lwd=5, col="red")
plot(x, y1, type="l", lwd=5, col="red", axes = F,
     xlab = NULL, ylab = NULL, frame.plot = F)

# ======================================================================
# Figure 02.14. Uniform Distribution.png
# ======================================================================

# Uniform distribution
x2 <- runif(10000, min = -4, max = 4)
ggplot(NULL, aes(x = x2)) + 
  geom_histogram(binwidth = 0.5,
                 fill = "firebrick3",
                 colour = "white") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Frequency") +
  theme(text = element_text(size = 24))
ggsave("Figure 02.14. Uniform Distribution.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.15. U-Shaped Distribution.png
# ======================================================================

# U-shaped distribution
# Can use a beta distribution with alpha = beta = 0.5
# See http://en.wikipedia.org/wiki/Beta_distribution
x3 <- rbeta(5000, 0.5, 0.5)

# Histogram for U-shaped distribution using ggplot2 proper
# Use NULL because I'm not using a data frame but just a vector
ggplot(NULL, aes(x = x3)) + 
  geom_histogram(binwidth = 0.05,
                 fill = "firebrick3",
                 colour = "white") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Frequency") +
  theme(text = element_text(size = 24))
ggsave("Figure 02.15. U-Shaped Distribution.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# MODES
# Unimodal Distributions

# ======================================================================
# Figure 02.16. Unimodal Distribution.png
# ======================================================================

# This is just a repeat of Figure 02.13.
# Draw standard normal distribution using ggplot2 (a histogram)
xnorm <- rnorm(10000)
ggplot(NULL, aes(x = xnorm)) + 
  geom_histogram(binwidth = 0.5,
                 fill = "firebrick3",
                 colour = "white") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Frequency") +
  theme(text = element_text(size = 24))

ggsave("Figure 02.16. Unimodal Distribution.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.17. Bimodal Distribution.png
# ======================================================================

library("reshape2")
# - Individual distributions
nd1 <- c(rnorm(1000, mean = 100, sd = 10), 150, 150, 150, 150, 145, 160, 149)
nd2 <- 

# - Combining into dataframes two at a time
# 1 & 2
df1   <- data.frame(nd1)
# melt12 <- melt(df12)
hist(df1)
ggplot(df1, aes(x = value)) + 
  geom_histogram(binwidth = 5, fill = "firebrick3", colour = "white") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Frequency") +
  theme(text = element_text(size = 24))

ggsave("Figure 02.17. Bimodal Distribution.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.18. Bimodal Distributions as Separate Distributions.png
# ======================================================================

# 1 & 3 with overlaid curves for each distribution
ggplot(melt12, aes(x = value)) + 
  geom_histogram(aes(y = ..density.. * 2),
                 binwidth = 5,
                 fill = "gray",
                 colour = "white") +
  stat_function(fun = dnorm,
                colour = "firebrick3",
                size = 1.5,
                arg = list(mean = 100, sd = 10)) +
  stat_function(fun = dnorm,
                colour = "blue",
                size = 1.5,
                arg = list(mean = 150, sd = 15)) +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Relative Frequency") +
  theme(text = element_text(size = 24))

ggsave(paste("Figure 02.18. Bimodal Distributions as ",
             "Separate Distributions.png"),
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.19. Multimodal Distribution.png
# ======================================================================

# - Combining all three
df123   <- data.frame(nd1, nd2, nd3)
melt123 <- melt(df123)
hist(melt123$value)
ggplot(melt123, aes(x = value)) + 
  geom_histogram(binwidth = 5, fill = "firebrick3", colour = "white") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Relative Frequency") +
  theme(text = element_text(size = 24))

ggsave("Figure 02.19. Multimodal Distribution.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.20. Multimodal Distributions as Combined Distributions.png
# ======================================================================

# All 3 with overlaid curves for each distribution
ggplot(melt123, aes(x = value)) + 
  geom_histogram(aes(y = ..density.. * 3),
                 binwidth = 5, fill = "gray",
                 colour = "white") +
  stat_function(fun = dnorm,
                colour = "firebrick3",
                size = 1.5,
                arg = list(mean = 100, sd = 10)) +
  stat_function(fun = dnorm,
                colour = "blue",
                size = 1.5,
                arg = list(mean = 150, sd = 15)) +
  stat_function(fun = dnorm, 
                colour = "green4", 
                size = 1.5, 
                arg = list(mean = 250, sd = 30)) +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Relative Frequency") +
  theme(text = element_text(size = 24))

ggsave(paste("Figure 02.20. Multimodal Distributions as ",
             "Combined Distributions.png"),
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.21. Positively Skewed Distribution.png
# ======================================================================

# SKEWNESS
# Generate skewed data with Beta distributions
# Skewed to the right
skewright <- rbeta(10000, 1.5, 8)

ggplot(NULL, aes(x = skewright)) + 
  geom_histogram(binwidth = 0.025,
                 fill = "#1D76B5",
                 colour = "white") +
  # geom_point(aes(x = .8, y = 0), size = 10, color = "#E38942") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Frequency") +
  theme(text = element_text(size = 24))

ggsave("Figure 02.21. Positively Skewed Distribution.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

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
             color="#1D76B5", 
             fill="#1D76B5", 
             shape=21) +
  # Options
  xlab("Searches for \"modern dance\"") +
  ylab("Searches for \"NBA\"") +
  theme(text = element_text(size = 24))

# ======================================================================
# Figure 02.22. Negatively Skewed Distribution.png
# ======================================================================

# Skewed to the left
skewleft <- rbeta(10000, 8, 1.5)
ggplot(NULL, aes(x = skewleft)) + 
  geom_histogram(binwidth = 0.025,
                 fill = "firebrick3",
                 colour = "white") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Frequency") +
  theme(text = element_text(size = 24))

ggsave("Figure 02.22. Negatively Skewed Distribution.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.23. Platykurtic Distribution.png
# ======================================================================

# Figure 02.23. Mesokurtic Distribution is a 
# copy of the normal distribution.
library("psych")
library("reshape2")

# Platykurtic
# - Individual distributions
pk1 <- rnorm(10000, mean = 0, sd = 1)
pk2 <- rnorm(10000, mean = 2, sd = 1)
pk3 <- rnorm(10000, mean = 4, sd = 1)
pk4 <- rnorm(10000, mean = 6, sd = 1)
pk5 <- rnorm(10000, mean = 8, sd = 1)
# - Combining into dataframes two at a time
pkdf   <- data.frame(pk1, pk2, pk3, pk4, pk5)
meltpk <- melt(pkdf)

ggplot(meltpk, aes(x = value)) + 
  geom_histogram(binwidth = 1, fill = "firebrick3", colour = "white") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Frequency") +
  theme(text = element_text(size = 24))

ggsave("Figure 02.23. Platykurtic Distribution.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)

# ======================================================================
# Figure 02.25. Leptokurtic Distribution.png
# ======================================================================

# Leptokurtic
# - Individual distributions
k1 <- rnorm(10000, mean = 0, sd = 1)
k2 <- rnorm(10000, mean = 0, sd = 10)
# - Combining into dataframes two at a time
kdf1   <- data.frame(k1, k2)
meltk1 <- melt(kdf1)

ggplot(meltk1, aes(x = value)) + 
  geom_histogram(binwidth = 2, fill = "firebrick3", colour = "white") +
  xlab("Scores on Outcome Variable") +  # Title on Y axis
  ylab("Frequency") +
  theme(text = element_text(size = 24))

ggsave("Figure 02.25. Leptokurtic Distribution.png",
#        width = 12, height = 6, dpi = 300)
       width = 13.5, height = 6, dpi = 200)


# Side by Side bell curves for Chapter 03
p <- ggplot(data.frame(x = c(-4, 4)), aes(x = x))
p + stat_function(fun = dnorm, colour = "firebrick3",
size = 1.5, arg = list(mean = -1, sd = 1)) +
  stat_function(fun = dnorm, colour = "blue", size = 1.5,
arg = list(mean = 1, sd = 1)) +
  theme(axis.title.x = element_blank()) +  # No title on X axis
  theme(axis.title.y = element_blank()) +  # No title on Y axis
  theme(axis.text.x = element_blank()) +   # No ticks or labels X axis
  theme(axis.text.y = element_blank())     # No ticks or labels Y axis
ggsave("twoBellCurves.png", width = 13.5, height = 6, dpi = 200)
