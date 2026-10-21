#Aquí se limpian los datos y agrupan en listas para tenerlos listos por años para un preproceso

#Para 2019, de COVID no tenemos, así que toca construirlo, primero limpiamos Influenza
data<- readxl::read_xlsx("Data/INFLUENZA.xlsx", sheet=1)
#Limpieza
#Removemos filas sin información relevante como total, año y fila vacía
datos_limpios<-data[-c(34,35,36),]
any(is.na(datos_limpios))#No hay datos nulos
#No hay negativos ni nada inusual, así que guardamos
influenza<-datos_limpios

#construimos los ceros para el COVID
covid<-datos_limpios
for(i in 1:nrow(covid)){
  for(j in 2:ncol(covid)){
      covid[i,j]=0
  }
}


#Construimos las listas donde guardamos los datos de cada año nombrados por el año.
lista_covid<-list(covid)
lista_influenza<-list(influenza)


#FUnción para obtener un dataframe sin negativos y alertar si hay nulos para revisiones posteriores
revisar_datos<-function(i,data,tipo){
  cat(i,tipo,"\n")
  #Removemos filas que no tienen aporte
  datos_limpios<-data[-c(34:36),]
  
  if(tipo=="influenza"){i=i-1} #para que el mismo módulo sirva en ambos casos
  if(ncol(datos_limpios)>53 && (i-1)%%5!=0){
    datos_limpios<-datos_limpios[,-54]
  }
  #Si quedan nulos, avisa porque para eso es necesario revisión manual
  if(any(is.na(datos_limpios))){
    cat("hubieron nulos en",tipo,"iteración ",i,"\n")
  }
  #Los negativos los transforma automáticamente en positivos.
  if(any(datos_limpios<0)){
    indices_negativos<-which(datos_limpios<0, arr.ind = TRUE)
    for(i in 1:nrow(indices_negativos)){
      datos_limpios[indices_negativos[i,1],indices_negativos[i,2]]<-abs(datos_limpios[indices_negativos[i,1],indices_negativos[i,2]])
      cat("Sustituyendo negativo #",i,"\n")
    }
  }
  
  return (datos_limpios)
}

#función para ir agregando cada año a la lista de dataframes de cada enfermedad
agregar_a_lista<-function(i, lista, file_path, rango_tabla, tipo){
  datos<-readxl::read_xlsx(file_path, sheet=i, .name_repair="minimal", range=rango_tabla)
  datos_limpios<-revisar_datos(i,datos,tipo)
  
  lista[[length(lista)+1]]=datos_limpios
  return(lista)
}

#guardamos datos correctos de 2020 a 2025
for(r in 1:6){
  lista_covid<-agregar_a_lista(r, lista_covid,"Data/COVID.xlsx", "A1:BB37","covid")
  lista_influenza<-agregar_a_lista(r+1,lista_influenza,"Data/INFLUENZA.xlsx","A1:BB37","influenza")
}

#agregamos los datos de 2026 a las listas.
#dejamos hasta la semana 30 para evitar que retrasos en el último mes afecten.
lista_covid<-agregar_a_lista(7,lista_covid,"Data/COVID.xlsx","A1:AE37","covid")
lista_influenza<-agregar_a_lista(8,lista_influenza,"Data/INFLUENZA.xlsx","A1:AE37","influenza")

 
#nombramos cada dataframe enlistado y guardado según su respectivo año
anios=c("2019","2020","2021","2022","2023","2024","2025","2026")
names(lista_covid)=anios
names(lista_influenza)=anios
