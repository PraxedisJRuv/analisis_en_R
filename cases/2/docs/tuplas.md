# tuplas.R
Imprime las combinaciones de genotipos más frecuentes y cuál es su frecuencia

## Funciones de R
### *rowSums()*
Suma las columnas por cada renglón de un argumento que normalmente es un dataframe

La utilidad yace en que la presencia de un genotipo se guardó como 1 y su ausencia como 0, siendo cada columna un genotipo, por lo que si la suma de los valores en un renglón es *x*, significa que esa persona tiene *x* genotipos presentes.
