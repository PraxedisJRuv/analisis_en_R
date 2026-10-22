# helpers.R
Contiene todas las funciones necesarias para ejecutar tuplas.R

Las funciones están separadas porque son muy largas y estorban al proceso general de tuplas.R, así es más claro entender las funciones y algoritmos en helpers.R y el proceso y flujo general de tuplas.R. Por lo tal, este script solo se ejecuta para guardar las funciones en el entorno de RStudio.

## Funciones
### *comparar_vectores*
Función de apoyo para comparar que los elementos de un vector son iguales que los dos de otro vector. Esto es necesario porque los vectores guardados en listas no se pueden guardar directamente. Se comparan elemento a elemento porque siempre fueron contruidos en el mismo orden, por lo que no pueden estar los elementos en distinto orden y si en una entrada, los elementos no coinciden, se rechaza la igualdad.

**Argumentos**:
- *vector1* y *vector2*: vectores de misma longitud cuyos elementos van a compararse.

**Output**: Devuelve un valor booleano indicando si los vectores son iguales o no.

### *registrar_tuplas*
Guarda todas las agrupaciones de genotipos presentadas que contengan una variedad mayor a la de un umbral.

Revisa las sumas por renglones de las columnas de cada renglón de *datos_positivo*, si la suma es mayor al *umbral_frecuencia_min*, entonces guarda todos los nombres de los genotipos positivos en ese renglón en un vector y cuando termina, guarda el vector de nombre en una lista. 

*count* es una variable que lleva el seguimiento de cuál fue la última posición de la lista en ser actualizada. Puede removerse utilizando *length()*, pero se uso el contador con un fin didáctico y de claridad. Era algo que la otra persona entendió de manera más clara.

**Argumentos**:
- *datos_positivo*: dataframe con solo los pacientes que presentaron positivo en general, no es necesario esto, pueden estar también los negativos pero es mejor haber ya recortado esos datos que no son relevantes para esta evaluación
- *umbral_frecuencia_min*: A partir de cuántos genotipos nos importa guardar las tuplas, en este caso concreto fue 2, pero pudiera ser de interés las combinaciones de más elementos.

**Output**: Devuelve una lista donde cada entrada de la lista es un vector con los nombres de los genotipos.

### *tuplas_repitidas*
Revisa de una lista de tuplas evalúando cuáles son las que se repiten al menos una vez.

Revisa dentro de la lista *tuplas* que valores están repetidos, si existe la repetición, se guarda en una lista.

**Argumentos**:
- *tuplas*: lista donde cada entrada es una tupla

**Output**: lista con las tuplas que se repitieron al menos en alguna ocasión

### *frecuencias_y_tuplas_mas_repetidas*
Determina cuántas veces y cuáles tuplas se repitieron.

De *mas_comunes_repetidas* se toma el primer elemento y se determina que su frecuencia es 2, ya que si está en la lista de repetidos al menos una vez, significa que al menos existen dos de esas tuplas y al haberse guardado se removió una repetición, por lo que siempre que se agregue una tupla nueva su frecuencia empieza en 2. Después se van revisando los siguientes tuplas en la lista, si alguna es igual a las tuplas que ya hemos visto, le agregamos a esta una frecuencia, si no es igual, la agregamos a la lista junto con una frecuencia de 2 y continuamos hasta haber explorado todas las tuplas que tuvieron al menos una repetición.

**Argumentos**:
- *mas_comunes_repetidas*: lista con las tuplas que se repitieron al menos una vez, asumiendo que se guardaron en la forma de *tuplas_repetidas*, es decir, se guardaron también las repeticiones.

**Output**: lista con la lista de las tuplas más repetidas y lista de la frecuencia de estas tuplas, nombradas como mas_comunes y frecuencias_mas_comunes respectivamente.
