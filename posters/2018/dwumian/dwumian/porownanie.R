library(corpcor)
t1<-Sys.time()
n<-20#gêstoœc siatki
grid<-1:n/n #siatka
f<-rep(0,n)
for (i in 1:n){
  if(grid[i]<0.333){f[i]<-(-grid[i])}
  else {f[i]<-2*grid[i]-1}
}
kernel<-function(x){1/(sqrt(2*pi*0.1^2))*exp(-x^2/(2*0.1^2))} # j¹dro konwolucji
A<-toeplitz(kernel(grid))/n #macierz zdyskretyzowanej konwolucji
noiselevel<-max(A%*%f) #maksimum wejœcia

D<-fast.svd(A)

ure<-function(N,data,sigma,epsilon){
  -sum((data[1:N]/sigma[1:N])^2)+2*epsilon^2*sum(sigma[1:N]^2)
}
U<-rep(0,n)
xm<-rep(0,n)
xk<-matrix(rep(0,n*n),nrow = n)
discr<-rep(0,n) #zasada rozbie¿nosci

M<-1000
w1<-rep(0,n)
w2<-rep(0,n)
w3<-rep(0,n)
for(l in 1:M){
  error.g<-A%*%f+rnorm(n,0,0.05*noiselevel)
  w3[l]<-norm(f-error.g,type = "F")
  for (i in 1:n){
    U[i]<-ure(i,error.g,1/D$d,0.05*noiselevel)
  }
  b<-min(U[1:n])
  j=1
  while(U[j]!=b){j=j+1}
  xm<-(D$v[,1:j]%*%diag(1/(D$d[1:j]))%*%t(D$u[,1:j]))%*%error.g
  w1[l]<-norm(f-xm,type = "F")
  for (k in 2:n){
    xk[,k]<-(D$v[,1:k]%*%diag(1/(D$d[1:k]))%*%t(D$u[,1:k]))%*%error.g
    discr[k]<-norm(error.g-A%*%xk[,k],type = "F")
  }
  delta<-norm(error.g-A%*%f,type = "F")#obliczmy delte do zasady
  i=2#znajdujemy miejsce obciêcia
  while(discr[i]>delta){i=i+1}
  
  w2[l]<-norm(f-t(xk[,i]),type = "F")
}
t2<-Sys.time()

boxplot(w1,w2,w3,names=c("Cavalier et al.","Morozow","nic"),las=1,col="skyblue",ylim=c(0.3,1.1))

plot(grid,f,type = "l",xlab="",ylab="",las=1,col="blue",lwd=2)
lines(grid,error.g,col="red",lwd=2)
legend(0,0.8,legend = c("f","Af+error"),lty=c(1,1),col=c("blue","red"),cex=1.5, text.width=2,bty = "n")

plot(grid,f,typ="l",xlab="",ylab = "",las=1,lwd=2)
lines(grid,xm,col="green",lwd=2)
legend(0,0.8,legend = c("f","Cavalier et al."),lty=c(1,1),col=c("black","green"),cex=1.5, text.width=2,bty = "n")

plot(grid,f,typ="l",xlab="",ylab = "",las=1,lwd=2)
lines(grid,xk[,i],col="green",lwd=2)
legend(0,0.8,legend = c("f","Morozow"),lty=c(1,1),col=c("black","green"),cex=1.5, text.width=2,bty = "n")

t2-t1
mean(w1)
mean(w2)
mean(w3)
