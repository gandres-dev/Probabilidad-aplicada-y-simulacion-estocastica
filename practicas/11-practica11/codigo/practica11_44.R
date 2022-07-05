# Forma para instalar los paquetes
# install.packages("viridis")
library(SciViews) # Biblioteca para utilizar ln 
library(scatterplot3d)
library(ggplot2)
library(viridis)
library(plot3D)
library(MASS)
library(RColorBrewer) # Color housekeeping


#' Funcion inversa de la distribucion exponencial
#'
#' @param u - la probabilidad acumulada.
#' @param lambda parametro de forma.
#'
#' @return una variable aleatoria.
inversa_distribucion_exp <- function(u, lambda) {
  return((-ln(1-u)/lambda))
}

#' Generador de variables aleatorias exponencial.
#'
#' @param n - numero de variables.
#' @param lamda - parámetro de forma.
#'
#' @return vector de variables aleatorias.
generacion_va_exp <- function(n, lambda) {
  va = c()
  for (i in 1:n) {
    u = runif(1)
    va[i] = inversa_distribucion_exp(u, lambda)
  }
  return(va)
}

#' Gráfica las variables aleatorias X y Y
#'
#' @param n - numero de variables aleatorias.
graficar_variables_X_Y <- function(n) {
  X <- generacion_va_exp(n, 1)
  Y <- generacion_va_exp(n, 1/y)
  plot(X, Y)
}

graficar_variables_X_Y(500)

#--------------------------Ejercicio 2 -------------------------------------

#' Simula variables aleatorias normales multivariadas
#'
#' @param n - numero de simulaciones.
#' @param sigma - matriz de covarianza.
#' @param u - vector de medias.
#'
#' @return - el vector Y es de variables normales.
simular_va_norm_multivariadas <- function(n, sigma, u) {
  va_X <- c()
  va <- c()
  eigenvec_val <- eigen(sigma)
  Q <- eigenvec_val$vectors
  values <- eigenvec_val$values
  A <- rbind(c(values[1],0), c(0,values[2]))
  M = Q %*% A^0.5
  
  for (i in 1:n) {
    X = rnorm(ncol(M),0,1) 
    Y = M %*% X + u
    va <- cbind(va, Y)
  }
  va <- t(va)
  return(va)
}

sigma1 <- rbind(c(1,0), c(0,1))
u1 <- c(0,0)
Y <- simular_va_norm_multivariadas(1000, sigma1, u1)
y1 <- cut(t(Y[,1]), breaks = 30)
y2 <- cut(t(Y[,2]), breaks = 30)
z <- table(y1, y2)

# Para declarar la paleta de colores a utilizar
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
r <- rf(32)

# Defimos un data frame para hacer nuestra grafica
df <-  data.frame(Y[,1], Y[,2])
h1 <- hist(df[,1], breaks=25, plot=F)
h2 <- hist(df[,2], breaks=25, plot=F)
top <- max(h1$counts, h2$counts)
k <- kde2d(df[,1], df[,2], n=25)

# Generamos las imagenes y juntamos los histogramas
oldpar <- par()
par(mar=c(3,3,1,1))
layout(matrix(c(2,0,1,3),2,2,byrow=T),c(3,1), c(1,3))
image(k, col = r) #plot the image
#image2D(z=z, border="black")
par(mar=c(0,2,1,0))
barplot(h1$counts, axes=F, ylim=c(0, top), space=0, col='red')
par(mar=c(2,0,0.5,1))
barplot(h2$counts, axes=F, xlim=c(0, top), space=0, col='red', horiz=T)

hist3D(z=z, border="black")

# @references: https://everydayanalytics.ca/2014/09/5-ways-to-do-2d-histograms-in-r.html
# @references: https://stackoverflow.com/questions/30563340/how-to-make-3d-histogram-in-r
#---------------------------------------------------------------
sigma2 <- rbind(c(1, 0.7),c(0.7, 1))
u2 <- c(1,0)
Y <- simular_va_norm_multivariadas(1000, sigma2, u2)
y1 <- cut(t(Y[,1]), breaks = 30)
y2 <- cut(t(Y[,2]), breaks = 30)
z <- table(y1, y2)

# Para declarar la paleta de colores a utilizar
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
r <- rf(32)

# Defimos un data frame para hacer nuestra grafica
df <-  data.frame(Y[,1], Y[,2])
h1 <- hist(df[,1], breaks=25, plot=F)
h2 <- hist(df[,2], breaks=25, plot=F)
top <- max(h1$counts, h2$counts)
k <- kde2d(df[,1], df[,2], n=25)

# Generamos las imagenes y juntamos los histogramas
oldpar <- par()
par(mar=c(3,3,1,1))
layout(matrix(c(2,0,1,3),2,2,byrow=T),c(3,1), c(1,3))
image(k, col = r) #plot the image
#image2D(z=z, border="black")
par(mar=c(0,2,1,0))
barplot(h1$counts, axes=F, ylim=c(0, top), space=0, col='red')
par(mar=c(2,0,0.5,1))
barplot(h2$counts, axes=F, xlim=c(0, top), space=0, col='red', horiz=T)

hist3D(z=z, border="black")


