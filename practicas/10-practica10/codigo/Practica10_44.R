# Paquetes requeridos para las graficas
# install.packages("scatterplot3d")
library("scatterplot3d") 

#1.-----------------------------------------------------------------------------
n <- 1000
X <-rnorm(n, 0, 1)
Y <-rnorm(n, 0, 1)
# Vemos una nube puntos, porque no estan relacionadas
plot(X, Y)

Z <- X-Y
W <- X+Y
plot(Z, W)

# 2.----------------------------------------------------------------------------
#' Generar una variables aleatorias multinomiales de tres resultados posibles
#' por las probabilidades dada por p1,p2,p3
#'
#' @param n - numero de ensayos
#' @param p1 - probabilidad de éxito para x1
#' @param p2 - probabilidad de éxito para x2
#' @param p3 - probabilidad de éxito para x3
#'
#' @return un vector multinomial
multinomial <- function(n, p1, p2, p3) {
  Xn = c(0, 0, 0);
  for (i in 1:n) {
    u = runif(1);
    if (u <= p1) {
      Xn[1] <- Xn[1]+1;
    } else if (u <= p1+p2) {
      Xn[2] <- Xn[2]+1;
    } else {
      Xn[3] <- Xn[3]+1;
    }
  }
  return(Xn)
}
X = multinomial(20, 0.3, 0.4, 0.1)
print(X)
#----------------------- Grafica 3D---------------------------------------------
# Cada punto representa una vector multinomial
x = c()
y = c()
z = c()

for (i in 1:150) {
  Xn = multinomial(i,0.3, 0.4, 0.1)
  x[i] = Xn[1]
  y[i] = Xn[2]
  z[i] = Xn[3]
}
scatterplot3d(x, y, z, pch=16, color='salmon')

# 3.----------------------------------------------------------------------------
# Ahora vamos graficar proyecciones
x = c()
y = c()
z = c()

for (i in 1:1000) {
  Xn = multinomial(i,0.3, 0.4, 0.1)
  x[i] = Xn[1]
  y[i] = Xn[2]
  z[i] = Xn[3]
}
plot(x, y)




