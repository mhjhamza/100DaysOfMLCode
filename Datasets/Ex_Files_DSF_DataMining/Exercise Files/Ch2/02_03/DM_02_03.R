# DM_02_03.R

# INSTALL AND LOAD PACKAGES ################################

# Check if pacman is installed; if not, install it
if (!require("pacman")) install.packages("pacman")
p_load(psych)        # Load psych package
p_depends(psych)     # Check dependencies for psych
p_load(GPArotation)  # Install dependency

# LOAD DATA ################################################

# Read big5.csv from desktop
b5 <- read.csv("~/Desktop/b5.csv", header = T) 
colnames(b5)  # Get column names
boxplot(b5)   # Boxplots for all Big 5 variables

# PRINCIPAL COMPONENT ANALYSIS #############################

# Can use "prcomp" or "princomp" but I prefer to do PCA
# with the "principal" function from the "psych" package.

# First PCA with no rotation, specify 5 factors
pc0 <- principal(b5, nfactors = 5)
pc0  # Check results

# Second PCA with oblimin (oblique) rotation
pc1 <- principal(b5, nfactors = 5, rotate = "oblimin")
pc1  # Check results

# INSPECT RESULTS ##########################################

# Plot position of variables on components
plot(pc1)

# CLEAN UP #################################################

# Clear workspace
rm(list = ls()) 

# Clear packages
p_unload(psych, GPArotation)

# Clear plots
dev.off() 

# Clear console
cat("\014")  # ctrl+L
