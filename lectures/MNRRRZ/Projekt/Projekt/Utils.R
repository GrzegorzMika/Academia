SolveEq <- function(NumberOfSteps, LowerLimit, UpperLimit, f, x0, True, method = "Euler", LocalError = FALSE) {
  h <- (UpperLimit - LowerLimit) / NumberOfSteps
  Fun <- rep(x0, NumberOfSteps + 1)
  Real <- rep(x0, NumberOfSteps + 1)
  Grid <- seq(LowerLimit, UpperLimit, h)
  if (!LocalError) {
    print(paste("Step =", h))
    print(paste("Starting point =", x0))
    print(paste("Used method:", method))
  }
  if (method == "Euler") {
    for (i in 1:NumberOfSteps + 1) {
      Fun[i] <- ifelse(i == 1, x0,
        Fun[i - 1] + h * f(Grid[i - 1], Fun[i - 1])
      )
      Real[i] <- True(Grid[i])
    }
  }
  if (method == "ModifiedEuler") {
    for (i in 1:NumberOfSteps + 1) {
      fi <- f(Grid[i - 1], Fun[i - 1])
      Fun[i] <- ifelse(i == 1, x0,
        Fun[i - 1] + h * f(Grid[i - 1] + h / 2, Fun[i - 1] + h / 2 * fi)
      )
      Real[i] <- True(Grid[i])
    }
  }
  if (method == "Heun") {
    for (i in 1:NumberOfSteps + 1) {
      Fun[i] <- ifelse(i == 1, x0, Fun[i - 1] + h / 2 *
        (f(Grid[i - 1], Fun[i - 1]) + f(Grid[i], Fun[i - 1] + h * f(Grid[i - 1], Fun[i - 1]))))
      Real[i] <- True(Grid[i])
    }
  }
  if (method == "Taylor") {
    fx <- Deriv(f, "x")
    ft <- Deriv(f, "t")
    for (i in 1:NumberOfSteps + 1) {
      fk <- f(Grid[i - 1], Fun[i - 1])
      Fun[i] <- ifelse(i == 1, x0, Fun[i - 1] + h * fk +
        h^2 / 2 * (ft(Grid[i - 1], Fun[i - 1]) + fk * fx(Grid[i - 1], Fun[i - 1])))
      Real[i] <- True(Grid[i])
    }
  }
  if (method == "MidPoint") {
    NumberOfSteps_temp <- 10^6
    h_temp <- (UpperLimit - LowerLimit) / NumberOfSteps_temp
    Grid_temp <- seq(LowerLimit, Grid[2], h_temp)
    Fun_temp <- rep(x0, length(Grid_temp))
    for (i in 1:length(Grid_temp) + 1) {
      Fun_temp[i] <- ifelse(i == 1, x0,
        Fun_temp[i - 1] + h_temp * f(Grid_temp[i - 1], Fun_temp[i - 1])
      )
    }
    x1 <- Fun_temp[Grid_temp == Grid[2]]
    for (i in 1:NumberOfSteps + 1) {
      Fun[i] <- ifelse(i == 1, x0, ifelse(i == 2, x1,
        Fun[i - 2] + 2 * h * f(Grid[i - 1], Fun[i - 1])
      ))
      Real[i] <- True(Grid[i])
    }
  }
  Solution <- data.frame(Fun = Fun, Grid = Grid)

  if (LocalError) {
    print(paste("Step =", h))
    print(paste("Starting point =", x0))
    print(paste("Used method:", method))
    print(paste("Local error:", LocalError(True, UpperLimit, LowerLimit, 1, f, NumberOfSteps, method)))
  }
  plot(Solution$Grid, Solution$Fun,
    type = "l", main = paste("Solution for
", NumberOfSteps, "steps"),
    xlab = "Grid", ylab = "Solution", las = 1
  )
  lines(Solution$Grid, Real, col = "red")
  return(Solution)
}

LocalError <- function(True, UpperLimit, LowerLimit, freq, f, NumberOfSteps, method) {
  h <- (UpperLimit - LowerLimit) / (freq * NumberOfSteps)
  Grid <- seq(LowerLimit, UpperLimit, h)
  Error <- rep(0, freq * NumberOfSteps + 1)
  steps <- freq * NumberOfSteps
  if (method == "Euler") {
    for (i in 1:(steps - 1)) {
      Error[i] <- True(Grid[i + 1]) - True(Grid[i]) - h * f(Grid[i], True(Grid[i]))
    }
  }
  if (method == "Heun") {
    for (i in 1:(steps - 1)) {
      fi <- f(Grid[i], True(Grid[i]))
      Error[i] <- True(Grid[i + 1]) - True(Grid[i]) -
        h / 2 * (fi + f(Grid[i + 1], True(Grid[i]) + h * fi))
    }
  }
  if (method == "Taylor") {
    fx <- Deriv(f, "x")
    ft <- Deriv(f, "t")
    for (i in 1:(steps - 1)) {
      Error[i] <- True(Grid[i + 1]) - True(Grid[i]) - h * f(Grid[i], True(Grid[i])) -
        h^2 / 2 * (ft(Grid[i], True(Grid[i])) + fx(Grid[i], True(Grid[i])) * f(Grid[i], True(Grid[i])))
    }
  }
  if (method == "ModifiedEuler") {
    for (i in 1:(steps - 1)) {
      fi <- f(Grid[i], True(Grid[i]))
      Error[i] <- True(Grid[i + 1]) - True(Grid[i]) - h * f(
        Grid[i] + h / 2,
        True(Grid[i]) + h / 2 * fi
      )
    }
  }
  if (method == "MidPoint") {
    for (i in 1:(steps - 2)) {
      Error[i] <- True(Grid[i + 2]) - True(Grid[i]) - 2 * h * f(Grid[i + 1], True(Grid[i + 1]))
    }
  }

  n <- length(Error)
  return(max(abs(Error[seq(1, n, freq)]), na.rm = T))
}

GlobalError <- function(NumberOfSteps, LowerLimit, UpperLimit, f, x0, True) {
  Sol <- SolveEq(
    NumberOfSteps = NumberOfSteps, LowerLimit = LowerLimit,
    UpperLimit = UpperLimit, f = f, x0 = x0, True = True
  )
  h <- (UpperLimit - LowerLimit) / NumberOfSteps
  Grid <- seq(LowerLimit, UpperLimit, h)
  Real <- True(Grid)

  return(max(abs(Real - Sol$Fun)))
}

MethodRate <- function(True, UpperLimit, LowerLimit, f, NumberOfSteps, method) {
  rate <- double()
  rate[1] <- LocalError(True, UpperLimit, LowerLimit, 1, f, NumberOfSteps, method)
  rate[2] <- LocalError(True, UpperLimit, LowerLimit, 2, f, NumberOfSteps, method)
  rate[3] <- LocalError(True, UpperLimit, LowerLimit, 4, f, NumberOfSteps, method)
  rate[4] <- LocalError(True, UpperLimit, LowerLimit, 8, f, NumberOfSteps, method)

  # rate[1] / rate[2]
  # rate[2] / rate[3]
  # rate[3] / rate[4]

  x1 <- log(rate[1] / rate[2], 2) - 1
  x2 <- log(rate[2] / rate[3], 2) - 1
  x3 <- log(rate[3] / rate[4], 2) - 1


  return(mean(c(x1, x2, x3)))
}

Steps <- function(LowerLimit, UpperLimit, f, x0, True, method = "Euler") {
  par(mfrow = c(2, 3))
  for (i in 1:6) {
    Sol <- SolveEq(
      NumberOfSteps = 10^i, LowerLimit = LowerLimit,
      UpperLimit = UpperLimit, f = f, x0 = x0, True = True, LocalError = TRUE, method
    )
    # h <- (UpperLimit - LowerLimit)/(10^i)
    # Grid <- seq(LowerLimit, UpperLimit, h)
    # Real <- True(Grid)
    # print(paste("Global error for", 10^i, "steps:", max(abs(Real - Sol$Fun))))
  }
  par(mfrow = c(1, 1))
}


Solution <- function(RHS, Lower, Upper, x0, True, method = "Euler", NumberOfSteps = 1e4) {
  eval(parse(text = paste("f <- function(t ,x) { ", RHS, "}", sep = "")))
  eval(parse(text = paste("True <- function(t) { ", True, "}", sep = "")))
  LowerLimit <- Lower
  UpperLimit <- Upper
  # NumberOfSteps <- NumberOfSteps
  # h <- (UpperLimit - LowerLimit)/NumberOfSteps
  x0 <- x0
  # Grid <- seq(LowerLimit, UpperLimit, h)

  Steps(
    LowerLimit = LowerLimit,
    UpperLimit = UpperLimit, f = f, x0 = x0, True = True, method = method
  )

  print(paste("Numerical approximation of method rate:", round(MethodRate(
    True, UpperLimit, LowerLimit, f,
    NumberOfSteps, method
  ))))
}
