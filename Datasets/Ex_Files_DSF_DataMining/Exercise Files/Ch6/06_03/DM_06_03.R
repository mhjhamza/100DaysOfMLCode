# DM_06_03.R

# INSTALL AND LOAD PACKAGES ################################

pacman::p_load(arules, arulesViz) 

# DATA #####################################################

## Read transactional data from arules package
data("Groceries")   # Load data
?Groceries          # Help on data
str(Groceries)      # Structure of data
summary(Groceries)  # Includes 5 most frequent items

# RULES ####################################################

# Set minimum support (minSup) to .001
# Set minimum confidence (minConf) to .75

rules <- apriori(Groceries, 
           parameter = list(supp = 0.001, conf = 0.75))

options(digits=2)
inspect(rules[1:10])

# PLOTS ####################################################

# Scatterplot of support x confidence (colored by lift)
plot(rules)

# Graph of top 20 rules
plot(rules[1:20], 
  method = "graph", 
  control = list(type = "items"))

# Parallel coordinates plot of top 20 rules
plot(rules[1:20], 
  method = "paracoord", 
  control = list(reorder = TRUE))

# Matrix plot of antecedents and consequents
plot(rules[1:20], 
     method = "matrix", 
     control = list(reorder = TRUE))

# Grouped matrix plot of antecedents and consequents
plot(rules[1:20], method = "grouped")

# CLEAN UP #################################################

# Clear workspace
rm(list = ls()) 

# Clear packages
pacman::p_unload(arules, arulesViz)

# Clear plots
dev.off()

# Clear console
cat("\014")  # ctrl+L
