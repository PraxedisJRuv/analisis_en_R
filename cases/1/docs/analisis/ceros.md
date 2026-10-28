# ceros.R
Evalúa la cantidad de ceros en los totales nacionales, en qué fechas se encuentra y a qué porcentaje de los datos equivalen. Además genera gráficos para notar visualmente los ceros

## Teoría
Es necesario determinar la prescencia de los ceros para poder elegir apropiadamente un modelo que se ajuste a los datos, o si hay inconstitencias notables. Contagios de influenza en un país del tamaño de México, no deberían ser 0, así que el porcentaje de cuántas semanas reportadas son 0, debería ser 0.

Cómo solo tenemos los casos positivos, es por lo que se sugiere la regresión Poisson o la Binomial Negativa. Sería una Binomial si lo que tuvieramos es la población total evalúada, pero solo tenemos quiénes sí tienen influenza y no los negativos, lo cuál resultará la prinicipal limitante. Lo que diferenica la Poisson de la Binomial Negativa, es sobre la dispersión de los datos. A mayor dispersión causada precisamente por presencia de algo que no debería presentarse como muchas semanas con 0 casos de influenza, la Binomial Negativa se ajusta mucho mejor que la Poission que es mucho más sensible a ese tipo de dispersión de los datos.

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