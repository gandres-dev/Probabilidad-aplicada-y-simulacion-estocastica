
#' Representa un ensayo de bernoulli.
#'
#' @param p la probabilidad de éxito.
#'
#' @return un entero que representa éxito o fracaso
bernoulli <- function(p){
  x = runif(1)
  if(x<p){
    return(1)
  }
  else{
    return(0)
  }
}

#' Simulación para la distribución geométrica
#' 
#' El número de fracasos antes del primer éxito.
#' 
#' @param p un decimal que representa la probabilidad de éxito.
#'
#' @return un entero que es el valor de la variable aleatoria.
geometrica <- function(p){
  fracaso = 0
  while(bernoulli(p)==0){
    fracaso = fracaso + 1
  }
  return(fracaso)
}

#' Simulación para la distribución geométrica, método de intervalos.
#'
#' @param p un decimal que representa la probabilidad de éxito.
#'
#' @return un entero que es el valor de la variable aleatoria.
geometrica2 <- function(p){
  x = runif(1)
  intervalo = 0
  extremo = p
  k=0
  while(x>extremo){
    intervalo = intervalo + 1
    k = k + 1
    extremo = extremo + ((1-p)^k)*p
  }
  return(intervalo)
}
geometrica2(0.3)

