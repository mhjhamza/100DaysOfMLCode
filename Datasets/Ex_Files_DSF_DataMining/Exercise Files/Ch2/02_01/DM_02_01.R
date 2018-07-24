# DM_02_01_GoalsOfDataReduction

# LOAD PACKAGES ############################################

install.packages("pacman")  # Install pacman if needed

# Load/install rgl for interactive 3D plots using OpenGL; 
# on Mac loads in X11/XQuartz
pacman::p_load(rgl)

# CREATE DATA ##############################################

x <- runif(100, 0, 100)     # 100 points from uniform dist
y <- runif(100, 0, 80)      # Same for y values
z <- y + runif(100, 0, 20)  # Add random values to get z
plot(x, y)
plot(x, z)
plot(y, z)

# Projecting a lower-dimensional shadow
plot3d(x, y, z)

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
pacman::p_unload(rgl)

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L
