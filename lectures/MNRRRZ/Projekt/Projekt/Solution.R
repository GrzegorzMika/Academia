
source('Utils.R')

RHS <- "-x * tan(t) + 1 / cos(t)"
True <- "sin(t)"
LowerLimit <- 0
UpperLimit <- 5
x0 <- 0


Solution(RHS = RHS, Lower = LowerLimit, Upper = UpperLimit, x0 = x0, True = True, method = 'ModifiedEuler')
