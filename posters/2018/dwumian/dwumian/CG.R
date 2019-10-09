library(corpcor)

kernel<-function(x){1/(sqrt(2*pi*0.1^2))*exp(-x^2/(2*0.1^2))} # j¹dro konwolucji
n<-50 #gêstoœc siatki
grid<-1:n/n #siatka
f<-rep(0,n) #prawdziwa funckja
for (i in 1:n){
  if(grid[i]<0.4 || grid[i]>0.6){f[i]<-0}
  else {f[i]<-1}
}

A<-toeplitz(kernel(grid))/n #macierz zdyskretyzowanej konwolucji
noiselevel<-max(A%*%f) #maksimum wejœcia
error.g<-A%*%f+rnorm(n,0,0.05*noiselevel) #zaburzony odczyt konwolucji
plot(grid,f,type = "l",xlab="",ylab="",las=1,col="blue",ylim=c(-0.5,1.2))
#Conjugent gradient

x<-matrix(rep(0,n*n),nrow = n)
x[,1]<-error.g
r<-error.g-A%*%x[,1]
s<-r
for(i in 2:4){
  a<-as.vector(norm(r,type = "F")^2/(t(s)%*%A%*%s))
  x[,i]<-x[,i-1]+a*s
  b<-norm(r-a*(A%*%s),type = "F")^2/norm(r,type = "F")^2
  r<-r-a*(A%*%s)
  s<-r+b*s
  lines(grid,x[,i-1],col=i)
  Sys.sleep(1)
}

