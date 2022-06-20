# Problema 1

#' Obtiene una matriz de Hilbert de orden n.
#' Con entradas $h[i,j] = 1/(i+j+1)$
#' 
#' @param n Indica la dimensionalida de matriz nxn
#' 
#' @return matriz_hilbert Regresa una matriz de Hilbert.
matriz_hilbert <- function(n){
  matriz = matrix(nrow = n, ncol = n)
  for(i in 1:n){
    for(j in 1:n){
      matriz[i,j] = 1/(i+j-1)
    }
  }
  return(matriz)
}
print(matriz_hilbert(5))

# Problema1.2 -------------------------------------------------------------
for(i in 1:100){
  if (det(matriz_hilbert(i)) == 0) {
    print("No tiene matriz inversa porque su determinante es cero.")
    print(i)
    break
  }
}

#------------------------------------
# Problema 2
regla_simpson <- function(f, a, b, n) {
  # Verificamos que n sea par
  if (bitwAnd(n,1)) {
    return("n debe ser par")
  }
  h = (b-a)/n
  suma = 0
  x0 <- a
  suma <- suma + f(x0)
  for (i in seq(1, n-1, 1)) {
    xi <- a + i * h
    if (bitwAnd(i,1)) {
      suma <- suma + (4 * f(xi))
    } else {
      suma <- suma + (2 * f(xi))
    }
  }
  xn <- a + n * h
  suma <- suma + f(xn)
  return((h/3) * suma)
}

cuadrado <- function(x) x^2
seno <- function(x) sin(x)
e <- function(x) exp(-(x^2))
raiz <- function(x) sqrt(1+x^3)

regla_simpson(cuadrado, 0, 150, 10000)
regla_simpson(seno, 0, (3 * pi) /4, 8)
regla_simpson(e, 0, 100, 1000)
regla_simpson(raiz, 0, 100, 10)
