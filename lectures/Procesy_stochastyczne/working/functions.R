#' Generate one observaition of a sum of random variables
#'
#' @param n number of observations from given distribution to be summed
#' @param distribution base distribution to draw the values for summation from (default uniform)
#'
#' @return sum of given number of observations generated from given distribution
Observation <- function(n, distribution = runif, ...) {
  sum(distribution(n, ...))
}

#' Draw a sample of a given size of sums using sapply function
#'
#' @param No Number of values to be summed
#' @param times Sample size
#' @param seed random number generator seed for replicability
#'
#' @return Numerical vector of observations of sums
Observations_app_seq <- function(No, times, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  sapply(rep(No, times), Observation)
}

#' Draw a sample of a given size of sums using purrr::map function
#'
#' @param No Number of values to be summed
#' @param times Sample size
#' @param seed random number generator seed for replicability
#'
#' @return Numerical vector of observations of sums
Observations_map_seq <- function(No, times, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  map_dbl(rep(No, times), Observation)
}

#' Draw a sample of a given size of sums using parSapply function
#'
#' @param No Number of values to be summed
#' @param times Sample size
#' @param cluster cluster of workers to evaluate on (default cl)
#' @param seed random number generator seed for replicability
#'
#' @return Numerical vector of observations of sums
Observations_app_par <- function(No, times, cluster = cl, seed = NULL) {
  if (!is.null(seed)) clusterSetRNGStream(cluster, seed); mc.reset.stream()
  parSapply(cluster, rep(No, times), Observation)
}


#' Draw a sample of a given size of sums using furrr::future_map function
#'
#' @param No Number of values to be summed
#' @param times Sample size
#' @param seed random number generator seed for replicability
#'
#' @return Numerical vector of observations of sums
Observations_map_par <- function(No, times, seed = NULL) {
  if (!is.null(seed)) future_options(seed = seed)
  future_map_dbl(rep(No, times), Observation)
}
