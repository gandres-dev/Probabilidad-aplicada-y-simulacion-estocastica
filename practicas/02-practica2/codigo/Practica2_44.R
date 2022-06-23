# Practica2
# Obtención de números aleatorios con sample, devuelve entero
sample(1:8, 2, replace = TRUE)

# Con runif() devuelve un racional
runif(1, -1, 1)

#' Cuenta las gotas que están dentro del circulo.
#'
#' @param n numero de gotas del experimento.
#'
#' @return Devuelve el numero de gotas del dentro del circulo.
gotas_dentro <- function(n){
  x <- runif(n, -1, 1)
  y <- runif(n, -1, 1)
  gotas <- 0
  for(i in 1:n){
    if(x[i]^2+y[i]^2 <= 1){
      gotas = gotas + 1   
    }
  }
  return(gotas)
}

#' Simula el experimento de gotas de lluvia para aproximar \pi
#'
#' @param num_gotas es el numero total de gotas del experimento. 
#' @param graficar un boolean que indica si desea graficar el experimento
#' 
#' @return un vector que contiene todas la aproximaciones de \pi
simulacion_lluvia <- function(num_gotas, graficar = TRUE) {
  x <- 1:num_gotas
  aprox_pi <- c()
  for(i in 1:num_gotas){
    aprox_pi[i]= (4*gotas_dentro(i))/i
  }
  if (graficar) graficar_simulacion(x, aprox_pi)
  return(aprox_pi)
}

#' Genera una grafica que representa la simulación
#'
#' @param x es un vector con un numero de gotas
#' @param y es un vector con todas la aproximaciones de pi
graficar_simulacion <- function (x, y) {
  plot(x , y,
       main = "Calculando pi con gotas de lluvia",       
       ylab = expression(pi),
       xlab = "Numero de gotas",
       pch=16, cex=.3, col="red")
  abline(0,0,pi,0)
}


aproximaciones_pi <- simulacion_lluvia(2000, graficar = TRUE)
# simulacion_lluvia(2000)




