#Script para búsqueda de combinaciones de más de 2 grupos de VPH

#Función para revisar si dos vectores son iguales o no, 
#usada para revisar repeticiones en tuplas de variedades más comúnes
compare_vectors<-function(vector1, vector2){
  for (i in 1:length(vector1)){
    if(vector1[i]!=vector2[i]){
      return (FALSE)
    }
  }
  return(TRUE)
}

#Lectura del archivo
df<-readxl::read_excel("Data/ON23-00021_PARA-ACTUALIZAR DATOS.xlsx",sheet = "ON23-00021",range="D3:AJ217")

#Filtrado de solo VPH postivo
datos_con_VPH_positivo<-df[df$VPH==1,]

#Removemos la columna si indica prsencia de VPH, pues ya no es necesaria
datos_con_VPH_positivo<-datos_con_VPH_positivo[,-1] #la primer columna es la que indica positivo, por eso se remueve

frecuencias_de_cantidades_VPH<-table(rowSums(datos_con_VPH_positivo)) #Van a ser importantes para discusión


#Algoritmo que determina las tuplas con más de dos repeticiones y las guarda en "tuplas"
count =0
tuplas<-list()
for(i in 1:nrow(datos_con_VPH_positivo)){
  if(rowSums(datos_con_VPH_positivo[i,])>2){
    count =count+1
    variedades<-c()
    for(j in 1:ncol(datos_con_VPH_positivo)){
      if(datos_con_VPH_positivo[i,j]==1){
        variedades<-append(variedades,colnames(datos_con_VPH_positivo[j]))
      }
    }
    if(length(variedades)>0){
      tuplas[[count]]<-variedades
    }
  }
}

#Algoritmo que revisa cuáles son las tuplas que se repiten en alguna ocasión
#Es guardado en la lista "mas_comunes_repetidas"
isduplicated<-duplicated(tuplas)
mas_comunes_repetidas<-list()
count =0
for(i in 1:length(tuplas)){
  if(isduplicated[i]==1){
    count = count +1
    mas_comunes_repetidas[[count]]<-tuplas[[i]]
  }
}
print(mas_comunes_repetidas)

#Algortimo que determina cuántas veces se repitió una tupla de genotipo de los datos
#imprime al final las frecuencias en orden de las tuplas más encontradas.
mas_comunes<-list()
frecuencias_mas_coumnes<-c()

mas_comunes[[1]]<-mas_comunes_repetidas[[1]]
frecuencias_mas_coumnes[1]=2
  
for (i in 2:length(mas_comunes_repetidas)){
  item_checado=FALSE
  for(j in 1:length(mas_comunes)){
    if(length(mas_comunes_repetidas[[i]])==length(mas_comunes[[j]])){
      if(compare_vectors(mas_comunes_repetidas[[i]],mas_comunes[[j]])){
        frecuencias_mas_coumnes[j]=frecuencias_mas_coumnes[j]+1
        
        item_checado=TRUE
      }
    }
  }
  if(!item_checado){
    mas_comunes[[length(mas_comunes)+1]]<-mas_comunes_repetidas[[i]]
    frecuencias_mas_coumnes[length(frecuencias_mas_coumnes)+1]=2
  }
}

print(frecuencias_mas_coumnes)
print(mas_comunes)
