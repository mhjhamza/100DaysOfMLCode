# .R

# INSTALL AND LOAD PACKAGES ################################

# Check if pacman is installed; if not, install it
if (!require("pacman")) install.packages("pacman")
p_load(psych)        # Load psych package
p_depends(psych)     # Check dependencies for psych
p_load(GPArotation)  # Install dependency
library(datasets)    # Load built-in datasets package

# LOAD DATA ################################################

# Read big5.csv from desktop
big5 <- read.csv("~/Desktop/big5.csv", header = T) 
colnames(big5)         # Get column names
boxplot(big5[, 9:58])  # Boxplots for all Big 5 variables
b5 <- big5[, 9:58]     # Save just Big 5 variables

# PRINCIPAL COMPONENT ANALYSIS #############################

# Conduct PCA using "principal" function from "psych"
# First PCA with no rotation, specify 5 factors
pc0 <- principal(b5, nfactors = 5)
# Check results
pc0

# Second PCA with oblimin (oblique) rotation
pc1 <- principal(b5, nfactors = 5, rotate = "oblimin")
# Check results
pc1

# INSPECT RESULTS ##########################################

# Plot position of variables on components
plot(pc1)

# CLEAN UP #################################################

# Clear workspace
rm(list = ls()) 

# Clear packages
pacman::p_unload(psych, GPArotation)
detach("package:datasets", unload = TRUE)

# Clear plots
dev.off() 

# Clear console
cat("\014")  # ctrl+L
