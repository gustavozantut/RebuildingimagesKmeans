
# instalar pacotes --------------------------------------------------------

install.packages("imager")
install.packages("ggplot2")

# carregar pacotes --------------------------------------------------------

library(imager)
library(ggplot2)

# teste biblioteca imager -------------------------------------------------

plot(boats)
x <- boats
plot(x)

# importando imagem da internet ---------------------------------------------------------
#https://secondnature.org/planet-earth-1401465698wt7/

x<- load.image(file.choose())
dim(x)
plot(x)

# Tranformando a imagem em uma matriz de pixels  ---------------------------------

y <- array(x) 
dim(y)
z <- matrix(data = y,nrow = length(y)/3, ncol = 3, byrow = F)
colnames(z)<- c("Red", "Green", "Blue")
dim(z) #são 90.000 pixels(300x300) com 3 paramêteros cada(Red, Green, Blue)

# Aplicando kmeans nos pixels agrupando-os em 30 grupos(cores) --------------------

modelo<- kmeans(z,centers = 30)
centros_pixel <- modelo$cluster #cluster do pixel
centros <- modelo$centers       #centro de cada variavel dos clusters

# Preenchendo a matriz com os valores de centro do cluster de cada pixel-----------

pixelsnew <- matrix(data = NA,nrow = length(y)/3, ncol = 3)
colnames(pixelsnew)<- c("Red", "Green", "Blue")
for (i in 1:(length(y)/3)) {
  pixelsnew[i,]<-centros[centros_pixel[i],]
}

# Comparando a imagem montada pelo Kmeans vs. Original -----------------------------------

dados2 <- array(pixelsnew, dim=c(dim(x)[1],dim(x)[2],1,3))
split.screen(figs=c(1,2))
screen(1)
plot(x, main="Imagem Original" )
screen(2)
plot(cimg(dados2), main="Imagem criada") #função cimg da library imager cria uma imagem apartir de um array






