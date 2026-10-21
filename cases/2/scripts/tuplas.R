#Script para búsqueda de combinaciones de más de 2 grupos de VPH

#Lectura del archivo
df<-readxl::read_excel("Data/DATOS.xlsx",sheet = "1",range="D3:AJ217")

#Filtrado de solo VPH postivo
datos_con_VPH_positivo<-df[df$VPH==1,]

#Removemos la columna si indica prsencia de VPH, pues ya no es necesaria
datos_con_VPH_positivo<-datos_con_VPH_positivo[,-1] #la primer columna es la que indica positivo, por eso se remueve

frecuencias_de_cantidades_VPH<-table(rowSums(datos_con_VPH_positivo)) #Van a ser importantes para discusión

umbral_frecuencia_min<-2 #aquí se determina que se tomen aquellos con más de 2 genotipos

tuplas<-registrar_tuplas(datos_con_VPH_positivo, umbral_frecuencia_min)

mas_comunes_repetidas<-tuplas_repetidas(tuplas)

resultado<-frecuencias_y_tuplas_mas_repetidas(mas_comunes_repetidas)

print(resultado$frecuencias_mas_comunes)
print(resultado$mas_comunes)
