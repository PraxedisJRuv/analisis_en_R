# ceros.R

## Funciones de R
### _aggregate_

Parte un conjunto de datos en subconjuntos, calcula un summary estadístico y los retorneo por forma conveniente.

### _cbind_

Combina objetos de R como un dataframe, acorde a columnas o a filas.

### _tapply_

aplica una operación a un array, pudiendo especificar a cuáles, y qué operación.

_tapply_(d$flu==0, d$periodo, mean) toma todos los momentos donde hubieron 0 casos de influenza en un cierto período y calcula la media. 

_tapply (d$flu, d$periodo, mean)_
la media de los casos de influenza por período.