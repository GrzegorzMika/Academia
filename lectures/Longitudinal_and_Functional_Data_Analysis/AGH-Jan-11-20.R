## Jan 11 2020
## held by prof. Hernando Ombao
## set working directory


##########################################################
###### Outline ###########################################
## (1.) Motivational plots
## (2.) Overview of inference, power analysis, sample size
## (3.) Modeling and estimation for a single curve
###########################################################

###########################################################
###########################################################
##### Part (1.)
##### Motivational Plots for Longitudinal Data Analysis/Functional Data Analysis
##### Loading required library
library(fda)

########################################
##### 2. Display Functional Data #######
########################################

##### 2.1 Heigts of the 10 girls
# A list containing the heights of 39 boys and 54 girls from age 1 to 18 and the ages at which they
# were collected
# hgtm a 31 by 39 numeric matrix giving the heights in centimeters of 39 boys at 31 ages.
# hgtf a 31 by 54 numeric matrix giving the heights in centimeters of 54 girls at 31 ages.
# age a numeric vector of length 31 giving the ages at which the heights were measured.

# Curve for one subject, i.e. subject 1
subject = 1
plot(growth$age, growth$hgtf[,subject],xlab="Age",ylab="Height",type="o",col="blue",ylim=c(60,200),main=" The height of a girl")

# Plot for ten subjects, i.e. the first 10 female.
subject = c(1:10)
plot(growth$age, growth$hgtf[,subject[1]],xlab="Age",ylab="Height",type="o",col="blue",ylim=c(60,200),main=" The heights of the first 10 girls")
for(i in subject[2:10]){
  lines(growth$age, growth$hgtf[,i],type="o",col=i)
}

#========================================================================================

##### 2.2 Non-durable goods index
# Here we transform to log_10
nondurables.log =log10(nondurables)
plot(nondurables.log, log="y",ylab="Nondurables")

#LOWESS: Locally weighted scatterplot smoother
#f: The smoother span. This gives the proportion of points in the plot which
#   influence the smooth at each value. Larger values give more smoothness.
mean.nondurables=lowess(nondurables.log, f = .2)
plot(nondurables.log,ylab="Nondurables")
lines(mean.nondurables, col = "blue")

#Plot residuals
residual = nondurables.log - mean.nondurables$y
plot(residual)

#Plot ACF of residuals
plot(acf(residual),main="")

#========================================================================================

##### 2.3 Monthly Temperture Data
# Canadian average annual weather cycle. Daily temperature and precipitation at
# 35 different locations  in Canada averaged over 1960 to 1994.
# CanadianWeather$monthlyTemp: 12 x 35, 12 months, 35 locations

# Time series of Two stations for 365 days, not average each month.
stations <- c("Pr. Rupert", "Montreal")
plot(CanadianWeather$dailyAv[,stations[1],"Temperature.C"],xlab="Day",
     ylab="Temperature (deg C)",type="l",ylim=c(-15,25))
lines(CanadianWeather$dailyAv[,stations[2],"Temperature.C"],col="blue")
legend('topright', legend=stations,col=c("black","blue"),lty=c(1,1))

# Reproduce the plot in Figure 1.6 from the book.
stations <- c("Pr. Rupert", "Montreal", "Edmonton", "Resolute")
matplot(seq(1,12,1), CanadianWeather$monthlyTemp[,stations],col=c("red","green","blue","black"),
        type="o",pch=c(1),ylim=c(-40,30) ,xlab="Months", ylab="Temperature (deg C)", axes=FALSE)
axis(2, seq(-40,20,10))
axis(1, seq(1,12,1), labels=FALSE)
axis(1, seq(1,12,1),c("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D" ), tick=FALSE)
legend('topright', legend=stations,col=c("red","green","blue","black"),pch=1)

########  Conduct the analysis Y_n(t) = mu_n(t) + epsilon_n(t) ########
## Residual of the polynomial component Y_n(t) - periodic components = beta_0 + beta_1*t + beta_2*t
stations <- c("Pr. Rupert", "Montreal", "Edmonton", "Resolute")
Y = CanadianWeather$monthlyTemp[,stations[1]]
t= seq(1,12,1)
plot(t,Y,xlab="Month",ylab="Temperature (deg C)")
t.square = t^2
lines(predict(lm(Y~ t + t.square)))

R1 = Y - predict(lm(Y~ t + t.square))
plot(R1,type="l",xlab="Month",ylab="Residuals R1")

## Estimate Residual of the periodic component Y_n(t) - polynomial components = alpha1*cos(2*pi*\omega*(t -\tau)) + alpha2*sin(2*pi*\omega*(t -\tau))
omega = 1/12

##I try different values of tau does not change the estimated residuals R2.
tau=c(-3,-1,0,1,3)/12
R2 = matrix(0,length(tau),length(t))

for(i in 1:length(tau)){
  t.cos = cos(2*pi*omega*(t-tau[i]))
  t.sin = sin(2*pi*omega*(t-tau[i]))
  R2[i,] = R1 - predict(lm(R1 ~ 0 +t.cos + t.sin))
}

plot(t,R2[1,],type="l",xlab="Month",ylab="Residuals R2")
for(i in 2:length(tau)){
  lines(t,R2[i,],type="l",col=i)
}

###########################################################
###########################################################
##### Part (2.)
##### Illustration on a two-independent Gaussian populations
popmean1 = 10;
popvar = 4;
popmean2 = 12;

## Sample sizes
n1 = 1000;
n2 = 1000;

samp1 = rnorm(n1, popmean1, sqrt(popvar));
samp2 = rnorm(n2, popmean2, sqrt(popvar));

samp1mean = mean(samp1);
samp1var = var(samp1);
samp2mean = mean(samp2);
samp2var = var(samp2);
pvar = ((n1-1)/(n1+n2-2))*samp1var + ((n2-1)/(n1+n2-2))*samp2var;

## Sample t test statistic
tstat = (samp1mean - samp2mean)/(sqrt(pvar*(1/n1 + 1/n2)));
tstat

## Distribution of the test statistic under the null
df = n1+n2-2;
t.thresh = qt(0.975, df);
t.thresh
tstat
abs(tstat)

## Sampling behavior of the t test statistic
## The settings
popmean1 = 10;
popvar = 4;
popmean2 = 10;

## Sample sizes
n1 = 10;
n2 = 10;

## number of simulated datasets
B = 100000;

out.test = matrix(ncol=2, nrow=B);
df = n1+n2-2;
t.thresh = qt(0.975, df);

t0 <- Sys.time()
for(b in 1:B){
  samp1 = rnorm(n1, popmean1, sqrt(popvar));
  samp2 = rnorm(n2, popmean2, sqrt(popvar));

  samp1mean = mean(samp1);
  samp1var = var(samp1);
  samp2mean = mean(samp2);
  samp2var = var(samp2);
  pvar = ((n1-1)/(n1+n2-2))*samp1var + ((n2-1)/(n1+n2-2))*samp2var;

  ## Sample t test statistic
  tstat = (samp1mean - samp2mean)/(sqrt(pvar*(1/n1 + 1/n2)));
  out.test[b,1] = tstat;

  ##decision
  rej = 1*(abs(tstat) > t.thresh);
  out.test[b,2] = rej;
}
Sys.time() - t0

out.test
cbind(abs(out.test[,1]), out.test[,2])
hist(out.test[,1])
out.test[,2]
mean(out.test[,2])


###########################################################
###########################################################
##### Part (2.)
##### Illustration on linear regression
##### Model y(t) = beta0 + beta1 t + epsilon(t)

n = 20;
x = runif(n, -4, 4);
x = sort(x);
beta0 = 1;
beta1 = 0;
mu = beta0 + beta1*x;
epsvar = 0.005;
epsilon = rnorm(n, 0, sqrt(epsvar));

y = mu + epsilon;
plot(x, y=y)

out1 = lm(y~x)
out2=summary(out1)

library("broom");
outq = glance(out1);
outqp = outq$p.value;

## Run simulations
B = 1000;
out.all = matrix(nrow=B, ncol=3);

n = 20;
beta0 = 1;
beta1 = 0;
epsvar = 1;
for(b in 1:B){
  x = runif(n, -4, 4);
  x = sort(x);
  mu = beta0 + beta1*x;
  epsilon = rnorm(n, 0, sqrt(epsvar));
  y = mu + epsilon;
  out1 = lm(y~x)
  out2=summary(out1)
  out.all[b,1] = out2$coefficients[2];
  outq = glance(out1);
  outqp = outq$p.value;
  out.all[b,2] = outqp;
  decision = 1*(outqp<0.05);
  out.all[b,3] = decision;
}

## histogram of the estimators of beta1
hist(out.all[,1])
mean(out.all[,1])
biasest = mean(out.all[,1]) - beta1;
varest = var(out.all[,1]);
biasest
varest

## histogram of p-values
hist(out.all[,2])

## proportion of false positives
sum(out.all[,3])/B

## Note: there can also be false negatives when the error variance is
## high (e.g., beta1 not zero ... )


###########################################################
###########################################################
##### Part (3.)
##### Modeling for a single curve
##### Global Temperature
globtemp = ts(scan("./lectures/Longitudinal_and_Functional_Data_Analysis/globtemp.dat"), start=1856)
gtemp = window(globtemp, start=1900)

# use data from 1990
par(mfrow=c(1,1))
plot(gtemp, type="o", ylab="Global Temperature Deviations")
y = gtemp;
T = length(y);
x = c(1:T);
par(mfrow=c(1,1));
plot(x, y, type="l");

####### Fit linear model for the global temp
out = lm(y ~ x);
summary(out);

### Predicted temp dev
ypred = out$coeff[1] + out$coeff[2]*x
plot(x, y);
lines(x,ypred, type="l");

### Extracting the residuals
resid = y - ypred;
plot(resid)

### Plotting lagged residuals
par(mfrow=c(2,2));
## lag 1
hy = resid[2:T]
hx = resid[1:(T-1)];
plot(hx, hy); title(paste("Lag 1")); cor(hy,hx)
## lag 2
hy = resid[3:T]
hx = resid[1:(T-2)];
plot(hx, hy); title(paste("Lag 2")); cor(hy,hx)
## lag 3
hy = resid[4:T]
hx = resid[1:(T-3)];
plot(hx, hy); title(paste("Lag 3")); cor(hy,hx)
## lag 4
hy = resid[5:T]
hx = resid[1:(T-4)];
plot(hx, hy); title(paste("Lag 4")); cor(hy,hx)

### Auto-correlation function
par(mfrow=c(1,1))
acf(resid)


########### Smoothing method to obtain the trend
y = gtemp;
T = length(y);
halfspan = 3;
yext = c(y[(halfspan+1):2], y, y[(T-1):(T-halfspan)]);
ysm = yext
for(k in (1+halfspan):(T+halfspan)){
  ysm[k] = mean(yext[(k - halfspan):(k+halfspan)]);
}
ysm = ysm[(halfspan+1):(T + halfspan)];

par(mfrow=c(1,1));
plot(x,y);
lines(x,ysm, type="l", col=2);

### Residuals
resid = y - ysm;
par(mfrow=c(2,1));
plot(resid, type="l");
acf(resid);


### SIMULATION EXAMPLE
### Generate a simulated time series with linear and
### seasonal structure

## Linear structure
T = 1000;
timeT = 1:T
beta0 = 10;
beta1 = 0.005;
Lt = beta0 + beta1*timeT;

## Seasonal structure
w1 = 2/T;
alpha11 = 3;
alpha12 = 0;
w2 = 5/T;
alpha21 = 0;
alpha22 = 2;

cos1 = cos(2*pi*w1*timeT);
sin1 = sin(2*pi*w1*timeT);
cos2 = cos(2*pi*w2*timeT);
sin2 = sin(2*pi*w2*timeT);

St = alpha11*cos1 + alpha12*sin1 + alpha21*cos2 + alpha22*sin2;

## Mean structure (Lt + St)
Mt = Lt + St;
plot(timeT, Mt, ylim=c(5, 20), type="l")

## Noise structure
## Try different phi1's
phi1 = 0.90;
sd = 1.0;
Nt = sd*arima.sim(T, model=list(ar=c(phi1)))
par(mfrow=c(2,1))
plot(timeT, Nt)
plot(timeT, Nt, type="l")

# Observed data
Y = Mt + Nt;
par(mfrow=c(1,1))
plot(Y)
lines(Mt, col = 'red', lwd = 2)

## Steps in Estimation
## Step 1: estimate the linear/polynomial part
## Step 2: estimate the seasonality part
## Step 3: estimate the auto-correlation/auto-covariance
## Step 4: re-estimate the mean part [update Steps 1 and 2]

X0 = as.vector(rep(1, T));
X1 = c(1:T);
X = cbind(X0, X1);
bhat = solve(t(X)%*%X)%*%(t(X)%*%Y);
bhat
cbind(bhat, c(beta0, beta1))

b0hat = bhat[1]; b1hat= bhat[2];
Mt.est = X0*b0hat + X1*b1hat;
par(mfrow=c(1,1));
plot(timeT, Y, type="l");
lines(timeT, Mt.est, col=2)

resid1 = Y - Mt.est;
par(mfrow=c(1,1));
plot(timeT, resid1)
plot(timeT, resid1, type="l")

## To estimate the frequencies present in the curve
resid1 = resid1 - mean(resid1);
fft1 = fft(resid1); #Fourier coefficients, Fast Fourier transform
period1 = (1/T)*(abs(fft1))^2;
plot(period1)
period1x = period1[2:(T/2+1)];
plot(period1x[1:30]);

## St.est obtained by fitting sines and cosines at the freauencies
## indicated in the periodogram plots
freq1.est = 2/T;
freq2.est = 5/T;


cos1.est = cos(2*pi*freq1.est*timeT);
sin1.est = sin(2*pi*freq1.est*timeT);
cos2.est = cos(2*pi*freq2.est*timeT);
sin2.est = sin(2*pi*freq2.est*timeT);

S.all = cbind(cos1.est, sin1.est, cos2.est, sin2.est);

ahat = solve(t(S.all)%*%S.all)%*%(t(S.all)%*%resid1);
ahat
cbind(ahat, c(alpha11, alpha12, alpha21, alpha22))
a11.hat = ahat[1]; a12.hat = ahat[2]; a21.hat = ahat[3]; a22.hat=ahat[4];

St.est = cos1.est*a11.hat + sin1.est*a12.hat + cos2*a21.hat + sin2*a22.hat;
par(mfrow=c(1,1));
plot(resid1, type="l");
lines(St.est, col=1)

## Trend est (combined Mt.est + St.est)
mu.est = Mt.est + St.est;
par(mfrow=c(1,1));
plot(timeT, Y, type="l");
lines(mu.est, col=2)

## resid
resid = Y - mu.est
