#funciones para apoyar y realizar el proceso en tuplas.R

#Función para revisar si dos vectores son iguales o no, 
#usada para revisar repeticiones en tuplas de variedades más comúnes
comparar_vectors<-function(vector1, vector2){
  for (i in 1:length(vector1)){
    if(vector1[i]!=vector2[i]){
      return (FALSE)
    }
  }
  return(TRUE)
}

#Algoritmo que determina las tuplas con más de dos repeticiones y las guarda en "tuplas"
registrar_tuplas<-function(datos_positivo, umbral_frecuencia_min){
  count =0
  tuplas<-list()
  for(i in 1:nrow(datos_positivo)){
    if(rowSums(datos_positivo[i,])>umbral_frecuencia_min){
      count =count+1
      variedades<-c()
      for(j in 1:ncol(datos_positivo)){
        if(datos_positivo[i,j]==1){
          variedades<-append(variedades,colnames(datos_positivo[j]))
        }
      }
      if(length(variedades)>0){
        tuplas[[count]]<-variedades
      }
    }
  }
  return(tuplas) 
}

#Algoritmo que revisa cuáles son las tuplas que se repiten en alguna ocasión
#Es guardado en la lista "mas_comunes_repetidas"

tuplas_repetidas<-function(tuplas){
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
  return(mas_comunes_repetidas)
}

#Algortimo que determina cuántas veces se repitió una tupla de genotipo de los datos
#imprime al final las frecuencias en orden de las tuplas más encontradas.

frecuencias_y_tuplas_mas_repetidas<-function(mas_comunes_repetidas){
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
  resultado<-list("mas_comunes"=mas_comunes, "frecuencias_mas_comunes"=frecuencias_mas_coumnes)
  return(resultado)
}