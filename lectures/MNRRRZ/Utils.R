library(tictoc)

SolveEq <- function(NumberOfSteps, LowerLimit, UpperLimit, f, x0, True, method = 'Euler', LocalError = FALSE){
  
  #print('Only simple Euler method is admissible')
  
  h <- (UpperLimit - LowerLimit)/NumberOfSteps
  Fun <- rep(x0, NumberOfSteps + 1)
  Real <- rep(x0, NumberOfSteps + 1)
  Grid <- seq(LowerLimit, UpperLimit, h)
  print(paste('Step =',h))
  print(paste('Starting point =', x0))
  if(method == 'Euler'){
    for(i in 1:NumberOfSteps + 1){
      Fun[i] <- ifelse(i == 1, x0, 
                                Fun[i - 1] + h * f(Grid[i - 1], Fun[i - 1]))
      Real[i] <- True(Grid[i])
    }
  }
  if(method == 'Heun'){
    for(i in 1:NumberOfSteps + 1){
      Fun[i] <- ifelse(i == 1, x0, Fun[i - 1] + h/2 * 
                         (f(Grid[i-1], Fun[i-1]) + f(Grid[i], Fun[i-1] + h * f(Grid[i-1], Fun[i-1]))))
      Real[i] <- True(Grid[i])
    }
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

LocalError <- function(True, Grid, h, freq, f, NumberOfSteps){
  
  Error = rep(0, NumberOfSteps + 1)
  Grid <- Grid/freq
  for(i in 1:NumberOfSteps - 1){
    
    Error[i] = True(Grid[i + 1]) - True(Grid[i]) - h * f(Grid[i], True(Grid[i]))
    
  }  
  
  return(max(Error, na.rm = T))
  
}

GlobalError <- function(NumberOfSteps, LowerLimit, UpperLimit, f, x0, True){
  
  Sol <- SolveEq(NumberOfSteps = NumberOfSteps, LowerLimit = LowerLimit, 
                 UpperLimit = UpperLimit, f = f, x0 = x0, True = True)
  h <- (UpperLimit - LowerLimit)/NumberOfSteps
  Grid <- seq(LowerLimit, UpperLimit, h)
  Real <- True(Grid)
  
  return(max(abs(Real - Sol$Fun)))
  
}

MethodRate <- function(True, Grid, h, f, NumberOfSteps){
  
  rate <- double()
  rate[1] <- LocalError(True, Grid, h, 1, f, NumberOfSteps)
  rate[2] <- LocalError(True, Grid, h/2, 2, f, NumberOfSteps)
  rate[3] <- LocalError(True, Grid, h/4, 4, f, NumberOfSteps)
  rate[4] <- LocalError(True, Grid, h/8, 8, f, NumberOfSteps)
  
  x1 <- sqrt(rate[1] / rate[2]) - 1
  x2 <- sqrt(rate[2] / rate[3]) - 1
  x3 <- sqrt(rate[3] / rate[4]) - 1
  
  return(mean(x1, x2, x3))
  
}

Steps <- function(LowerLimit, UpperLimit, f, x0, True, method = 'Euler'){
  
  par(mfrow = c(2,3))
  for(i in 1:6){
    Sol <- SolveEq(NumberOfSteps = 10^i, LowerLimit = LowerLimit, 
                   UpperLimit = UpperLimit, f = f, x0 = x0, True = True, LocalError = TRUE)
    h <- (UpperLimit - LowerLimit)/(10^i)
    Grid <- seq(LowerLimit, UpperLimit, h)
    Real <- True(Grid)
    print(paste("Global error for", 10^i, "steps:", max(abs(Real - Sol$Fun))))
  }
  par(mfrow = c(1,1))
  
}


Solution <- function(RHS, Lower, Upper, x0, True, NumberOfSteps = 1000){
  
  eval(parse(text = paste('f <- function(t ,x) { return(' , RHS , ')}', sep=''))) 
  eval(parse(text = paste('True <- function(t, x) { return(' , True , ')}', sep='')))
  LowerLimit <- Lower
  UpperLimit <- Upper
  NumberOfSteps <- NumberOfSteps
  h <- (UpperLimit - LowerLimit)/NumberOfSteps
  x0 <-x0
  Grid <- seq(LowerLimit, UpperLimit, h)
  
  Steps(LowerLimit = LowerLimit, 
        UpperLimit = UpperLimit, f = f, x0 = x0, True = True)
  
  print(paste("Numerical approximation of method rate:", round(MethodRate(True, Grid, h, f, NumberOfSteps))))
  
}
