# Utilizamos el package 'actuar' para las función rpareto y 'Rlab' para rbern.
# Se debe instalar para que reconozca la función.
# install.packages('actuar')
# install.packages('Rlab')

library('actuar')
library('Rlab')

#------------------- Ley débil de los grandes números---------------------------
# Versión débil
a=1.98
b=6
parciales1= c()
parciales2=c()
n=1000
VariablesDebil=function(n){
  for(i in  1:n){
    va2=rbern(i,0.5)
    va1=rpareto(i,a,b)
    suma1=0
    suma2=0
    for( j in va1){
      suma1=suma1+j
    }
    for( k in va2){
      suma2=suma2+k
    }
    parciales1[i]=suma1/i
    parciales2[i]=suma2/i
  }
  return(c(parciales1,parciales2))
}
#Para n=100
n=100
plot(seq(1,n, by=1),tail(VariablesDebil(n),n), type="l",xlab="Número de variables aleatorias",ylab="Promedio", main="Versión débil convergencia Bernoulli(0.5)")
abline(0.5,0,col="red", lwd=3)
text(n-n/10, 0.5+0.1, "Valor Esperado", family = "serif", col="red", cex=1)
plot(seq(1,n, by=1),head(VariablesDebil(n),n), type="l",xlab="Número de variables aleatorias",ylab="Promedio", main="Versión débil convergencia Pareto(1.98.6)")
abline(b/(a-1),0,col="red",lwd=3)
text(n-n/10, b/(a-1)+3, "Valor Esperado", family = "serif", col="red", cex=1)
#Para n=1000
n=1000
plot(seq(1,n, by=1),tail(VariablesDebil(n),n), type="l",xlab="Número de variables aleatorias",ylab="Promedio", main="Versión débil convergencia Bernoulli(0.5)")
abline(0.5,0,col="red", lwd=3)
text(n-n/10, 0.5+0.1, "Valor Esperado", family = "serif", col="red", cex=1)
plot(seq(1,n, by=1),head(VariablesDebil(n),n), type="l",xlab="Número de variables aleatorias",ylab="Promedio", main="Versión débil convergencia Pareto(1.98.6)")
abline(b/(a-1),0,col="red",lwd=3)
text(n-n/10, b/(a-1)+3, "Valor Esperado", family = "serif", col="red", cex=1)

#------------------- Ley fuerte de los grandes números---------------------------
# Versión fuerte 

VarFuerte=function(n){
  parciales1=c()
  parciales2=c()
  promedio1=0
  promedio2=0
  for(i in 1:n){
    promedio1=(promedio1*(i-1)+rpareto(1,a,b))/i
    parciales1[i]=promedio1
    promedio2=(promedio2*(i-1)+rbern(1,0.5))/i
    parciales2[i]=promedio2
    
  }
  return(c(parciales1,parciales2))
}


#----------------------Bernolli-------------------------------------------------
n=100
plot(seq(1,n, by=1),tail(VarFuerte(n),n), type="l", main="Versión fuerte convergencia Bernoulli(0.5) n=100",xlab="Número de variables aleatorias",ylab="Promedio")
abline(0.5,0,col="red")
text(n-n/10, 0.5+0.1, "Valor Esperado", family = "serif", col="red", cex=1)

n=1000
plot(seq(1,n, by=1),tail(VarFuerte(n),n), type="l", main="Versión fuerte convergencia Bernoulli(0.5) n=1000",xlab="Número de variables aleatorias",ylab="Promedio")
abline(0.5,0,col="red")
text(n-n/10, 0.5+0.1, "Valor Esperado", family = "serif", col="red", cex=1)


#-----------------------Pareto--------------------------------------------------
n=100
plot(seq(1,n, by=1),head(VarFuerte(n),n), type="l",xlab="Número de variables aleatorias",ylab="Promedio", main="Versión fuerte convergencia Pareto(1.98,6) n=100")
abline(b/(a-1),0,col="red")
text(n-n/10, b/(a-1)+0.5, "Valor Esperado", family = "serif", col="red", cex=1)

n=1000
plot(seq(1,n, by=1),head(VarFuerte(n),n), type="l",xlab="Número de variables aleatorias",ylab="Promedio", main="Versión fuerte convergencia Pareto(1.98,6) n=1000")
abline(b/(a-1),0,col="red")
text(n-n/10, b/(a-1)+0.5, "Valor Esperado", family = "serif", col="red", cex=1)

#-------------------------------------------------------------------------------
#Trabajaremos sobre la versión fuerte
#Calculando el error absoluto
n=100000
#------------------------Error para Bernoulli-----------------------------------
error=c()
aux=tail(VarFuerte(n),n)
for(i in 1:n){
  error[i]=abs((1/2-aux[i]))
}
plot(seq(1,n,by=1), error, type="l", main="Error absoluto Bernoulli", xlab="Variables", ylab="Error",ylim=c(0,0.01),xlim=c(0,n))
abline(0.001,0, col="blue", lwd=2)


#--------------------------Error para Pareto------------------------------------
error=c()
aux=head(VarFuerte(n),n)
for(i in 1:n){
  error[i]=abs((b/(a-1)-aux[i]))
}
plot(seq(1,n,by=1), error, type="l", main="Error absoluto Pareto", xlab="Variables", ylab="Error",ylim=c(0,0.05),xlim=c(0,n))
abline(0.001,0, col="blue", lwd=2)
