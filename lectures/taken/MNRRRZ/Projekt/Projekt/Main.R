f <- function(t, x){ 2 * (x + 1) / (t + 1)}
LowerLimit <- 0
UpperLimit <- 10
method <- 'Euler'
NumberOfSteps <- 10000
h <- (UpperLimit - LowerLimit)/NumberOfSteps
x0 <- 1
Grid <- seq(LowerLimit, UpperLimit, h)
True <- function(t){ 2 * t^2 + 4*t  + 1}

Sol <- SolveEq(NumberOfSteps = NumberOfSteps, LowerLimit = LowerLimit, 
               UpperLimit = UpperLimit, f = f, x0 = x0, True = True)

MethodRate(True, Grid, h)

Steps(LowerLimit = LowerLimit, 
      UpperLimit = UpperLimit, f = f, x0 = x0, True = True)

