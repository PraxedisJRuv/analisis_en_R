# helpers.R
Contiene todas las funciones necesarias para ejecutar tuplas.R

Las funciones están separadas porque son muy largas y estorban al proceso general de tuplas.R, así es más claro entender las funciones y algoritmos en helpers.R y el proceso y flujo general de tuplas.R

## Funciones
### *comparar_vectores*
Función de apoyo para comparar que los elementos de un vector son iguales que los dos de otro vector. Esto es necesario porque los vectores guardados en listas no se pueden guardar directamente. Se comparan elemento a elemento porque siempre fueron contruidos en el mismo orden, por lo que no pueden estar los elementos en distinto orden y si en una entrada, los elementos no coinciden, se rechaza la igualdad.

**Argumentos**:
- *vector1* y *vector2*: vectores de misma longitud cuyos elementos van a compararse.

### *registrar_tuplas*
Guarda todas las agrupaciones de genotipos que contengan una variedad mayor a la de un umbral

**Argumentos**:
- *datos_positivo*:
- *umbral_frecuencia_min*: