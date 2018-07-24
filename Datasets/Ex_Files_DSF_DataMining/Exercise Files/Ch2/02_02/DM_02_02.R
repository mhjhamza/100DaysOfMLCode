# DM_02_02_AlgorithmsForDataReduction

# LOAD PACKAGES ############################################

pacman::p_load(pcaMethods)
library(datasets)

# CREATE DATA ##############################################

idata <- iris[, 1:4]
nlpca(idata)

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
pacman::p_unload(pcaMethods)
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L
