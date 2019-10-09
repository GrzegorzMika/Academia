kernel<-function(x){1/(sqrt(2*pi*0.05^2))*exp(-x^2/(2*0.05^2))} # j¹dro konwolucji
#kernel<-function(x){5*exp(-5*x)}
n<-50 #gêstoœc siatki
grid<-1:n/n #siatka
f<-rep(0,n) #prawdziwa funckja
for (i in 1:n){
  if(grid[i]<0.333){f[i]<-(-grid[i])}
  else {f[i]<-2*grid[i]-1}
}
library(corpcor)

A<-toeplitz(kernel(grid))/n #macierz zdyskretyzowanej konwolucji
noiselevel<-max(A%*%f) #maksimum wejœcia
error.g<-A%*%f+rnorm(n,0,0.05*noiselevel) #zaburzony odczyt konwolucji
plot(grid,f,type = "l",xlab="",ylab="",las=1,col="blue")
lines(grid,error.g,col="red")
legend(0,0.8,legend = c("f","Af+e"),lty=c(1,1),col=c("blue","red"),cex=0.85, text.width=1,bty = "n")

D<-fast.svd(A)

ure<-function(N,data,sigma,epsilon){
  -sum((data[1:N])^2)+2*epsilon^2*sum(sigma[1:N]^2)
}

U<-rep(0,n)

for (i in 1:n){
  U[i]<-ure(i,error.g,1/D$d,0.05*noiselevel)
  U1[i]<-ure1(i,error.g,1/D$d,0.05*noiselevel)
}
b<-min(U[2:n])
j=1
while(U[j]!=b){j=j+1}
j
xk<-rep(0,n)
xk<-(D$v[,1:j]%*%diag(1/(D$d[1:j]))%*%t(D$u[,1:j]))%*%error.g



norm(f-xk,type = "F")

plot(grid,f,typ="l",xlab="",ylab = "",las=1,ylim = c(-0.3,1.2))
lines(grid,xk,col="red")
legend(0,0.9,legend = c("f","Cavalier et al.",j,round(norm(f-xk,type = "F"),4)),lty=c(1,1),col=c("black","green"),cex=0.85, text.width=1,bty = "n")
