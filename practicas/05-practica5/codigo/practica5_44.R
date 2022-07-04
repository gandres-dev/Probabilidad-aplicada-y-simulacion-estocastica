library("SciViews")

#' Función de densidad weibul
#'
#' @param x - valor de la variable aleatoria
#' @param lamda - parámetro de forma.
#' @param k - parámetro de escala.
#'
#' @return - probabilidad del valor v.a
densidad_weibul <- function(x, lamda, k) {
  return((k/lamda) * (x/lamda)^(k-1) * exp(-(x/lamda)^k))
}

#' Función inversa de la distribución weibul.
#'
#' @param u - probabilidad acumulada.
#' @param lamda - parámetro de forma.
#' @param k - parámetro de escala.
#'
#' @return variable aleatoria correspondiente.
inversa_distribucion_weibul <- function(u, lamda, k) {
  return(lamda * (-ln(1-u))^(1/k))
}

#' Generador de variables aleatorias weibul.
#'
#' @param n - numero de variables.
#' @param lamda - parámetro de forma.
#' @param k - parámetro de escala.
#'
#' @return vector de variables aleatorias.
generacion_va_weibul <- function(n, lamda, k) {
  va = c()
  for (i in 1:n) {
    u = runif(1)
    va[i] = inversa_distribucion_weibul(u, lamda, k)
  }
  return(va)
}

# Histograma 1 para v.a weibul
va_weibul = generacion_va_weibul(100, 1, 5)
hist(va_weibul, probability = TRUE, main = 'Weibul n = 100', xlab = '', col = 'salmon2')
par(new=TRUE)
plot(va_weibul, densidad_weibul(va_weibul, 1 ,5), pch = 20, cex = 0.8, col = 'blue')

# Histograma 2 para v.a weibul 
va_weibul = generacion_va_weibul(1000, 1, 5)
hist(va_weibul, probability = TRUE, main = 'Weibul n = 1000', xlab = '', col = 'salmon2')
par(new=TRUE)
plot(va_weibul, densidad_weibul(va_weibul, 1 ,5), pch = 20, cex = 0.3, col = 'blue')

# Histograma 3 para v.a weibul
va_weibul = generacion_va_weibul(100000, 1, 5)
hist(va_weibul, probability = TRUE, main = 'Weibul n = 100000', xlab = '', col = 'salmon2')
par(new=TRUE)
plot(va_weibul, densidad_weibul(va_weibul, 1 ,5), pch = 20, cex = 0.3, col = 'blue')


#' Función de densidad pareto.
#'
#' @param x - valor de la variable aleatorio.
#' @param a - es el límite inferior de los datos.
#' @param b - es el parámetro de forma.
#'
#' @return - probabilidad que suceda el valor de la v.a
densidad_pareto <- function(x, a, b) {
  return((a * b^a)/(b+x)^(a+1))
}

#' Función inversa de la distribución pareto
#'
#' @param u - probabilidad acumulada.
#' @param a - es el límite inferior de los datos
#' @param b - es el parámetro de forma
#'
#' @return variable aleatorio correspondiente.
inversa_distribucion_pareto <- function(u, a, b) {
  return((b/(1-u)^(1/a))-b) 
}



#' Generador de variables aleatorias pareto
#'
#' @param n - numero de variables aleatorias
#' @param a - es el límite inferior de los datos
#' @param b - es el parámetro de forma
#'
#' @return vector de variables aleatorias.
generacion_va_pareto <- function(n, a, b) {
  va = c()
  for (i in 1:n) {
    u = runif(1)
    va[i] = inversa_distribucion_pareto(u, a, b )
  }
  return(va)
}

# Histograma 1 para v.a pareto 
va_pareto = generacion_va_pareto(100, 10, 3)
hist(va_pareto, probability = TRUE, main = 'Pareto n = 100', xlab = '', col = 'pink')
par(new=TRUE)
plot(va_pareto, densidad_pareto(va_pareto, 10 ,3), pch = 20, cex = 0.8, col = 'blue')

# Histograma 2 para v.a pareto 
va_pareto = generacion_va_pareto(1000, 10, 3)
hist(va_pareto, probability = TRUE, main = 'Pareto n = 1000', xlab = '', col = 'pink')
par(new=TRUE)
plot(va_pareto, densidad_pareto(va_pareto, 10 ,3), pch = 20, cex = 0.3, col = 'blue')

# Histograma 3 para v.a pareto 
va_pareto = generacion_va_pareto(100000, 10, 3)
hist(va_pareto, probability = TRUE, main = 'Pareto n = 100000', xlab = '', col = 'pink')
par(new=TRUE)
plot(va_pareto, densidad_pareto(va_pareto, 10 ,3), pch = 20, cex = 0.3, col = 'blue')
