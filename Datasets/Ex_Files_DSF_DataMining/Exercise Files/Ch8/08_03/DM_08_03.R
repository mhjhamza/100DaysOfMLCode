# DM_08_03.R

# INSTALL AND LOAD PACKAGES ################################

pacman::p_load(pacman, depmixS4) 

# LOAD & EXAMINE DATA ######################################

# We'll use the sample dataset "speed" from depmixS4
data(speed)
str(speed)

# Plot the data
plot(ts(speed[, 1:3]), main = "speed data")

# MODEL DATA ###############################################

# Compare models with different numbers of hidden states.

# Model 1: Joint Gaussian-binomial response with 1 state 
model1 <- depmix(list(rt ~ 1, corr ~ 1), 
            data = speed, 
            nstates = 1,
            family = list(gaussian(), 
              multinomial("identity")))
fm1 <- fit(model1, verbose = FALSE)

# Model 2: HMM with 2 states and Pacc as covariate
model2 <- depmix(list(rt ~ 1, corr ~ 1), 
            data = speed, 
            nstates = 2,
            family = list(gaussian(), 
              multinomial("identity")), 
            transition = ~ scale(Pacc),
              ntimes=c(168, 134, 137))
fm2 <- fit(model2, verbose = FALSE)

# Model 3: HMM with 3 states and Pacc as covariate 
model3 <- depmix(list(rt ~ 1,corr ~ 1), 
            data = speed, 
            nstates = 3,
            family = list(gaussian(), 
              multinomial("identity")), 
            transition = ~ scale(Pacc),
              ntimes=c(168, 134, 137))
fm3 <- fit(model3, verbose = FALSE)

# COMPARE MODELS ###########################################

# Want lowest BIC (Bayesian Information Criterion)
plot(1:3, c(BIC(fm1), BIC(fm2), BIC(fm3)),
  ty = "b", xlab = "Model", ylab = "BIC")

# CLEAN UP #################################################

# Clear workspace
rm(list = ls()) 

# Clear packages
p_unload(all)  # For add-ons

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L
