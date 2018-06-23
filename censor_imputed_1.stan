data {
  int<lower = 0> N_obs;
  int<lower = 0> N_cens;
  real y_obs[N_obs];
}
parameters {
  real<lower = max(y_obs)> U;
  real<lower = U> y_cens[N_cens];
  real mu;
  real<lower = 0> sigma;
} 
model {
  mu ~ normal(0, 5);
  sigma ~ normal(0, 5);
  U ~ normal(0, 3);
  y_obs ~ normal(mu, sigma);
  y_cens ~ normal(mu, sigma);
}
