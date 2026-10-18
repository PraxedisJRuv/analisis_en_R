#Script para realizar el scatterplot de los distintos tipos de VPH

#Extracción de los datos
datos<-readxl::read_excel("Data/ON23-00021_PARA-ACTUALIZAR DATOS.xlsx",sheet = "PLANTILLA",range="A140:B172")
#Para categorizar los datos se revisó las categorías que tenían en el documento base
nivel_riesgo<-factor(rep(c("Alto","Medio","Bajo"),c(13,6,13)), levels=c("Alto","Medio","Bajo"))
datos["nivel de riesgo"]<-nivel_riesgo
datos["orden_num"]<-c(1:length(nivel_riesgo))
datos["factor_genotipo"] <- factor(datos$Genotipo, levels = unique(datos$Genotipo))

colores_asignar<-c("Alto"="orange", "Medio"="grey", "Bajo"="lightblue")

#Gráfica
plot(datos$orden_num, datos$`n del genotipo`, 
     col = colores_asignar[datos$`nivel de riesgo`], 
     pch = 19,      # Tipo de punto
     cex = 2,       # Tamaño del punto
     xaxt="n",
     xlab = "Genotipo", ylab = "n del genotipo", 
     main = "Scatter")

#Añadido nombre de Genotipo de VPH
axis(side = 1, 
     at = 1:length(levels(datos$factor_genotipo)), 
     labels = levels(datos$factor_genotipo))

#Añadido de leyenda
legend("topleft", 
       legend = names(colores_asignar), 
       col = colores_asignar, 
       pch = 2, 
       title = "Nivel de riesgo")