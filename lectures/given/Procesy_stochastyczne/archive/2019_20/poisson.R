library(tidyverse)
library(foreach)

lambda <- 0.2
tMax <- 50
n_sim <- 10


simulate_path <- function(lambda, tMax = 100, simulation_nr = NA) {
  n <- qpois(1 - 1e-8, lambda = lambda * tMax)
  X <- rexp(n = n, rate = lambda)
  S <- c(0, cumsum(X))
  return(data.frame(simulation = rep(simulation_nr, length(S)), values = 0:(length(S) - 1), time = S))
}

# simulate_path(lambda = lambda, tMax = tMax, simulation_nr = 1) %>%
#   ggplot(aes(x = time, y = values, col = as.factor(simulation))) +
#   geom_step(size = 1) +
#   theme(legend.position = "none") +
#   labs(title = str_c("Poisson process with intensity ", lambda))

data <- foreach(n = 1:n_sim, .combine = rbind) %do% {
  simulate_path(lambda = lambda, tMax = tMax, simulation_nr = n)
}

data %>%
  ggplot(aes(x = time, y = values, col = as.factor(simulation))) +
  geom_step(size = 1) +
  theme(legend.position = "none") +
  labs(title = str_c("Poisson process with intensity ", lambda))
