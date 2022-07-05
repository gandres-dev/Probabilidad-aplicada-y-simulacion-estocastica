

#' Función inversa de la cópula de Cuadras-Augé
#'
#' @param w variable aleatoria uniforme (0,1).
#' @param v variable aleatoria uniforme (0,1).
#' @param theta parámetro para distribución.
#'
#' @return
H <- function(w, v, theta) {
  if (w  < (1-theta) * v^(1-theta)) {
    return((w/(1-theta))*v^theta)
  } else if (w  < v^(1-theta)) {
    return(v)
  } else if (w >= v^(1-theta)){
    return(w^(1-theta))
  }
}


#' Algoritmo para generar pares de variables (U,V) con distribución dada
#' por la cópula de Cuadras-Augé
#'
#' @param n - numero de variables a simular.
#' @param theta - parámetro para la distribución.
#'
#' @return un par de variables (U,V)
simular_cuadras_auge <- function(n, theta) {
  W <- runif(n)
  V <- runif(n)
  U <- c()
  for (i in 1:n) {
    U[i] <- H(W[i], V[i], theta)
  }
  return(list(U, V))
}


#----------------------Para  θ = 0, 0.1, 0.3, 0.85, 0.9:------------------------
#Para  θ = 0 --------------------------------------------------------------------
theta = 0
n = 1000
par_va <- simular_cuadras_auge(n, theta)
names(par_va) <- c("U", "V")
hist(par_va$V, probability = TRUE,  main = paste("Marginal V con n =1000 con theta=",
                                                 theta))
hist(par_va$U, probability = TRUE,  main = paste("Marginal U con n =1000 con theta=",
                                                 theta))
X = -log(par_va$U)
Y = -log(par_va$V)
plot(X, Y, main = paste("Con theta=",theta))

#Para  θ = 0.1------------------------------------------------------------------
theta = 0.1
n = 1000
par_va <- simular_cuadras_auge(n, theta)
names(par_va) <- c("U", "V")
hist(par_va$V, probability = TRUE,  main = paste("Marginal V con n =1000 con theta=",
                                                 theta))
hist(par_va$U, probability = TRUE,  main = paste("Marginal U con n =1000 con theta=",
                                                 theta))

X = -log(par_va$U)
Y = -log(par_va$V)
plot(X, Y, main = paste("Con theta=",theta))


#Para  θ = 0.3------------------------------------------------------------------
theta = 0.3
n = 1000
par_va <- simular_cuadras_auge(n, theta)
names(par_va) <- c("U", "V")
hist(par_va$V, probability = TRUE,  main = paste("Marginal V con n =1000 con theta=",
                                                 theta))
hist(par_va$U, probability = TRUE,  main = paste("Marginal U con n =1000 con theta=",
                                                 theta))

X = -log(par_va$U)
Y = -log(par_va$V)
plot(X, Y, main = paste("Con theta=",theta))

#Para  θ = 0.85-----------------------------------------------------------------
theta = 0.85
n = 1000
par_va <- simular_cuadras_auge(n, theta)
names(par_va) <- c("U", "V")
hist(par_va$V, probability = TRUE,  main = paste("Marginal V con n =1000 con theta=",
                                                 theta))
hist(par_va$U, probability = TRUE,  main = paste("Marginal U con n =1000 con theta=",
                                                 theta))

X = -log(par_va$U)
Y = -log(par_va$V)
plot(X, Y, main = paste("Con theta=",theta))

#Para  θ = 0.9------------------------------------------------------------------
theta = 0.9
n = 1000
par_va <- simular_cuadras_auge(n, theta)
names(par_va) <- c("U", "V")
hist(par_va$V, probability = TRUE,  main = paste("Marginal V con n =1000 con theta=",
                                                 theta))
hist(par_va$U, probability = TRUE,  main = paste("Marginal U con n =1000 con theta=",
                                                 theta))

X = -log(par_va$U)
Y = -log(par_va$V)
plot(X, Y, main = paste("Con theta=",theta))
#------------------------------------------------------------------------------

