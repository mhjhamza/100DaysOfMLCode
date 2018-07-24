# DM_04_03.R

# LOAD PACKAGES ############################################

pacman::p_load("class")  # class has knn function

# LOAD DATA ################################################

# Read CSV
df <- read.csv("~/Desktop/ccdefault.csv", header = T)
colnames(df)
head(df)  # Show first six cases

# NORMALIZE DATA ###########################################

# If ranges for variables are very different, then it's a
# good idea to normalize the variables, which puts them in
# similar ranges. Use custom function for now.

# Define function for normalizing data
normalize <- function(x) {
  norm <- ((x - min(x))/(max(x) - min(x)))
  return (norm)
}

# Apply function to data frame (but not index or outcome)
dfn <- as.data.frame(lapply(df[, 2:24], normalize))
head(dfn)

# Put outcome variable back on and rename
dfn <- cbind(dfn, df[, 25])
names(dfn)[24] <- "DEFAULT"

# Check data
colnames(dfn)
head(dfn)

# SPLIT DATA ###############################################

# Split data into training set (2/3) and testing set (1/3)
set.seed(2786)  # Random seed
dfn.split <- sample(2, nrow(dfn), 
                     replace = TRUE,
                     prob = c(2/3, 1/3))

# Create training and testing datasets without outcome
# labels. Use just the first 23 variables.
dfn.train <- dfn[dfn.split == 1, 1:23]
dfn.test  <- dfn[dfn.split == 2, 1:23]

# Create outcome labels
dfn.train.labels <- dfn[dfn.split == 1, 24]
dfn.test.labels  <- dfn[dfn.split == 2, 24]

# BUILD AND TEST CLASSIFIER ################################

# Build classifier for test data.
# k = number of neighbors to compare; odd n avoids ties.
# Try with several values of k and check accuracy on
# following table.
dfn.pred <- knn(train = dfn.train,
                test = dfn.test, 
                cl = dfn.train.labels,  # true class
                k = 9)                  # n neighbors

# Compare predicted outcome to observed outcome
table(dfn.pred, dfn.test.labels)

# CLEAN UP #################################################

# Clear workspace
rm(list = ls()) 

# Unload packages
pacman::p_unload(class)

# Clear console
cat("\014")  # ctrl+L
