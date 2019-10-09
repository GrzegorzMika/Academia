path <- '/home/grzegorz/Pulpit/Doktorat/Słuchane/MNRRRZ'
source(paste0(path,'/Utils.R'))

RHS <- "x - (1 + t)^(-2) - (1 + t)^(-1)"
True <- "exp(t) + 1 / (1 + t)"
LowerLimit <- 0
UpperLimit <- 1
x0 <- 2

Solution(RHS = RHS, Lower = LowerLimit, Upper = UpperLimit, x0 = x0, True = True)
