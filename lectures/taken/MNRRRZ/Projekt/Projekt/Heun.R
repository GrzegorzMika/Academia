# Schemat Heuna

f <- function(t, x){ -x*tan(t)+1/cos(t)}
LowerLimit <- 0
UpperLimit <- 5
method <- 'Heun'
NumberOfSteps <- 10000
h <- (UpperLimit - LowerLimit)/NumberOfSteps
x0 <- 0
Grid <- seq(LowerLimit, UpperLimit, h)
True <- function(t){ sin(t)}


SolveEq <- function(NumberOfSteps, LowerLimit, UpperLimit, f, x0, True, method = 'Heun', LocalError = FALSE){

  #print('Only simple Euler method is admissible')

  h <- (UpperLimit - LowerLimit)/NumberOfSteps
  Fun <- rep(x0, NumberOfSteps + 1)
  Real <- rep(x0, NumberOfSteps + 1)
  Grid <- seq(LowerLimit, UpperLimit, h)
  print(paste('Step =',h))
  print(paste('Starting point =', x0))

  for(i in 1:NumberOfSteps + 1){
    Fun[i] <- ifelse(i == 1, x0, Fun[i - 1] + h/2 *
                       (f(Grid[i-1], Fun[i-1]) + f(Grid[i], Fun[i-1] + h * f(Grid[i-1], Fun[i-1]))))
    Real[i] <- True(Grid[i])
  }
  Solution <- data.frame(Fun = Fun, Grid = Grid)
  plot(Solution$Grid, Solution$Fun, type = 'l', main = paste('Solution for', NumberOfSteps, 'steps'),
       xlab = 'Grid', ylab = 'Solution', las = 1)
  lines(Solution$Grid, Real, col = 'red')
  if(LocalError){
    print(paste("Local error:", LocalError(True, Grid, h, 1, f, NumberOfSteps)))
  }
  return(Solution)
}

Sol <- SolveEq(NumberOfSteps, LowerLimit, UpperLimit, f, x0, True)
