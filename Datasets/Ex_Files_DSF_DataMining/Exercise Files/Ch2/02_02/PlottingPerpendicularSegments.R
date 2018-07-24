# File:    PlottingPerpendicularSegments.R
# Course:  
# Chapter: 
# Section: 
# Author:  Barton Poulson, datalab.cc, @bartonpoulson
# Date:    2016-05-06

# Source: http://j.mp/1Oh11e1
# Residuals part: http://j.mp/1XcHAdC

# DEFINE FUNCTION FOR PERPENDICULAR SEGMENTS ###############

# Function for perpendicual segments
# Source: http://j.mp/1Oh1fSi

perp.segment.coord <- function(x0, y0, lm.mod){
  #finds endpoint for a perpendicular segment from the point
  #(x0,y0) to the line defined by lm.mod as y=a+b*x
  a <- coef(lm.mod)[1]  #intercept
  b <- coef(lm.mod)[2]  #slope
  x1 <- (x0+b*y0-a*b)/(1+b^2)
  y1 <- a + b*x1
  list(x0=x0, y0=y0, x1=x1, y1=y1)
}

# GENERATE DATA ############################################

set.seed(1846)
x <- runif(25, 0, 100)
y <- x + rnorm(25, 0, 7)

# PLOT DATA WITH TREND #####################################

mod1 <- lm(y ~ x)
plot(x, y, 
     # xlim = c(min(x) - 5, max(x) + 5), 
     # ylim = c(min(y) - 10, max(y) + 10),
     xlim = c(0, 100), 
     ylim = c(0, 100),
     pch = 19, cex = 1.5)
abline(mod1, lwd = 2)

## Add Perpendicular Lines #################################

ss <- perp.segment.coord(x, y, mod1)
segments(x0 = ss$x0, x1 = ss$x1,
         y0 = ss$y0, y1 = ss$y1, 
         col = "red", lwd = 2)
# Can also do:
# do.call(segments, ss)
# but can't modify colors, etc.
points(x, y, pch = 19, cex = 1.5)  # Plot points again

# PLOT DETRENDED DATA ######################################

# Get residuals
y.res <- resid(mod1)

# Regression with residuals
# mod2 <- lm(y.res ~ x)
plot(x, y.res, 
     # xlim = c(min(x) - 5, max(x) + 5), 
     # ylim = c(min(y) - 10, max(y) + 10),
     xlim = c(0, 100), 
     ylim = c(-50, 50),
     pch = 19, cex = 1.5)
# abline(mod2, lwd = 2)
abline(h = 0, lwd = 2)

# calculate residuals and predicted values
# res <- signif(residuals(mod1), 5)
# pre <- predict(mod2)

# plot distances between points and the regression line
segments(x, y.res, 
         x, 0, 
         col = "red", lwd = 2)
points(x, y.res, pch = 19, cex = 1.5)

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
