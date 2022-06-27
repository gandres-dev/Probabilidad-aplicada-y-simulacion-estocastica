
#' Genenerador lineal congruencial
#'
#' @param n es la cantidad de números a generar.
#' @param semilla es nuestro x0 donde empezara nuestro algoritmo.
#' @param m es el modulo.
#' @param a es la constante multiplicativa.
#' @param c es la constante aditiva.
#'
#' @return un vector de números pseudoaleatorios.
generador_congruencial <- function(n, semilla, m, a, c){
  x = c(semilla)
  for(i in 2:(n+1)){
    x[i] = (a*x[i-1]+c) %% m
  }
  return(x[2:(n+1)])
}

# Para n=3, semilla=15, mod=100, a=50, c=16
generador_congruencial(3, 15, 100, 50, 16)
generador_congruencial(10, 15, 100, 50, 16)
# Generando más números
generador_congruencial(28, 23, 100, 32, 53)
generador_congruencial(28, 67, 100, 45, 23)

# Cuando c = 0
generador_congruencial(50, 23, 100, 77, 0)
generador_congruencial(100, 45, 100, 67, 0)

# Pruebas para un m muy grande
generador_congruencial(101, 45, 1000, 67, 0)
generador_congruencial(100, 45, 10000, 67, 0)

#------------------------------------------------------------

#' Genenerador lineal congruencial uniforme distribuido entre [0,1]
#'
#' @param n es la cantidad de números a generar.
#' @param m es el modulo.
#' @param a es la constante multiplicativa.
#' @param c es la constante aditiva.
#'
#' @return un vector de números pseudoaleatorios.
generador_congruencial_u <- function(n, m = 1000, a = 32, c = 0){
  semilla <- as.numeric(Sys.time())
  x <-  c(semilla)
  norm <- c(x)
  for(i in 2:(n+1)){
    x[i] <- (a*x[i-1]+c) %% m
    norm[i]<- x[i] / (m-1)
  }
  return(norm[2:(n+1)])
}
generador_congruencial_u(20, 1000, 67, 0)

# Para esta prueba tenemos
# n = 100, m = 1000, a = 342
nums_pseudo = generador_congruencial_u(100, 1000, 342)
hist(nums_pseudo, main="Frecuencia de numero aleatorios")

# Prueba con n = 500000, m = 1000, a = 342
nums_pseudo = generador_congruencial_u(500000, 1000, 342)
hist(nums_pseudo, main="Frecuencia de numero aleatorios")

r1 <- generador_congruencial_u(1000, 3245, 234)
r2 <- generador_congruencial_u(1000, 4536, 432)
r3 <- generador_congruencial_u(1000, 6754, 543)

# Ojo: Tarde 8 minutos en instalar todas sus dependencias.
# sudo dnf install libcurl-devel
# sudo dnf install openssl-devel
library(plotly)
plot_ly(x=r1,y=r2,z=r3,type = "scatter3d", marker = list(size = 2)) %>% layout(title="m = 3245, 4536, 6754   a = 342")

# Ahora con los valores
# n = 500000, m = 2^31 - 1, a = 7^5
nums_pseudo_2 = generador_congruencial_u(500000, 2^31 - 1, 7^5)
hist(nums_pseudo_2, main="Frecuencia de numero aleatorios")

r1_1 <- generador_congruencial_u(1000, 2^31-1, 7^5)
r2_2 <- generador_congruencial_u(1000, 2^31-1, 7^5)
r3_3 <- generador_congruencial_u(1000, 2^31-1, 7^5)
plot_ly(x=r1_1,y=r2_2,z=r3_3,type = "scatter3d", marker = list(size = 2)) %>% layout(title="m = 2ˆ31 - 1, a = 7ˆ5")

#------------------Calculando pi---------------------------------
# Generador runif
gotas_dentro1 <- function(n){
  x <- runif(n, -1, 1)
  y <- runif(n, -1, 1)
  contador_dentro <- 0
  for(i in 1:n){
    if(x[i]^2+y[i]^2 <= 1){
      contador_dentro = contador_dentro + 1
    }
  }
  return(contador_dentro)
}

# Generador lineal congruencial
gotas_dentro2 <- function(n){
  x <- generador_congruencial_u(n, 2^31-1, 7^5)
  y <- generador_congruencial_u(n, 2^31-1, 7^5)
  contador_dentro <- 0
  for(i in 1:n){
    if(x[i]^2+y[i]^2 <= 1){
      contador_dentro = contador_dentro + 1
    }
  }
  return(contador_dentro)
}


simulacion_lluvia <- function(num_gotas, f, msg="", graficar=FALSE) {
  x <- 1:num_gotas
  aprox_pi <- c()
  for(i in 1:num_gotas){
    aprox_pi[i]= (4*f(i))/i
  }
  if (graficar) {
    plot(x , aprox_pi,
         main = paste("Calculando pi",msg),       
         ylab = expression(pi),
         xlab = "Numero de gotas",
         pch=16, cex=.3, col="red")
    abline(0,0,pi-0.1,0)
    abline(0,0,pi,0)
    abline(0,0,pi+0.1,0)
    
  }
}

time_fun <- function(num_gotas, f, f2) {
  t_ini = as.numeric(Sys.time())
  f(num_gotas, f2)
  return(as.numeric(Sys.time()) - t_ini)
}

simulacion_lluvia(2000, gotas_dentro1, "con runif", graficar = TRUE)
simulacion_lluvia(2000, gotas_dentro2, "con GLC", graficar = TRUE)

paste("Tiempo usando runif: ", time_fun(2000, simulacion_lluvia, gotas_dentro1))
paste("Tiempo usando GLC: ", time_fun(2000, simulacion_lluvia, gotas_dentro2))
