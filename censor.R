library(rstan)
library(ggplot2)
options(mc.cores = parallel::detectCores())
# simulate a censored process
# ULQ: 3

ulq <- 1
n <- 100
y <- rnorm(n, mean = 0, sd = 1)
cens_idx <- which(y > 1)
y_cens <- y[y > 1]
y_obs <- y[-cens_idx]

data <- list(N_obs = length(y_obs), N_cens = length(y_cens), y_obs = y_obs, U = ulq)

# mu and sigma estimates with integrated out censor points
m1 <- stan_model(file = "censor.stan") 
f1 <- sampling(m1, iter = 300, data = data)
mean(y); sd(y)
f1

# mu and sigma plus imputed censor points
m2 <- stan_model(file = "censor_imputed.stan")
f2 <- sampling(m2, iter = 300, data = data)
mean(y_cens)
f2

# mu and sigma plus imputed censor points and esitmate the U (ulq)
m3 <- stan_model(file = "censor_imputed_1.stan")
f3 <- sampling(m3, iter = 300, data = data)
mean(y); sd(y); mean(y_cens)
f3
