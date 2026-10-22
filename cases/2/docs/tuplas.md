# tuplas.R
Imprime las combinaciones de genotipos más frecuentes y cuál es su frecuencia. Guarda estos resultados también en una lista para análisis o revisión posterior.

Se leen los datos, para después filtrar los que solo tienen VPH positivo y remover esa información de estatus positivo. Como un extra para otros análisis se imprimen las frecuencias de cada cantidad de genotipos presentada por los pacientes. Después se declara el tamaño de las tuplas mínimo que se busca explorar, es decir, cuánta es la mínima cantidad de genotipos presentes en un paciente, del que quisieramos ver si se repiten combinaciones de.

Después se utilizan las funciones de helpers.R. *registrar_tuplas*, guarda todas las agrupaciones de genotipos presentadas que contengan una variedad mayor a la de un umbral, *tuplas_repitidas* revisa de una lista de tuplas evalúando cuáles son las que se repiten al menos una vez, *frecuencias_y_tuplas_mas_repetidas* determina cuántas veces y cuáles tuplas se repitieron. Imprimiendo estos dos últimos resultados al final.

## Funciones de R
### *rowSums()*
Suma las columnas por cada renglón de un argumento que normalmente es un dataframe

La utilidad yace en que la presencia de un genotipo se guardó como 1 y su ausencia como 0, siendo cada columna un genotipo, por lo que si la suma de los valores en un renglón es *x*, significa que esa persona tiene *x* genotipos presentes.

