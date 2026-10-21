# alienamiento.R
Para las siguientes pruebas se vuelve mucho más práctico, tener los datos en formato "largo", es decir, una sola tabla con la información de todos los años, volviendo el tiempo continuo para poder analizarlo con Fourier y como una serie de tiempo propia. Para esto último habría que agregar una columna "t" que indique el momento (la semana de los 8 años), y de una vez, vamos agregando la semana que comprende ya como una fecha con la que poder hacer puntos de corte y poder operar después.

## Funciones
### _a_ _largo_ es una función que transforma los elementos de las listas
descripción
**Argumentos:**
- a