# limpieza.R

## Funciones de R
is.na(x)
Dice si existe un valor nulo en x

any(x)
Dice si hay algún valor TRUE en x

which(x, arr.ind=TRUE)
En qué índices los valores son TRUE. Sin arr.ind no da los índices.
En este caso al x tratarse los datos de un data.frame que cumplen con una determinada condición, sus índices son coordenadas así que está función devuelve una matriz donde los renglones es el dato que cumplió la condición y las columnas su índice de fila e índice de columna del data.frame del que vienen. Por eso se realiza una iteración sobre los valores [i,1] e [i,2] de la matriz resultante.

lista[[length(lista)+1]]= valor
Señala que agregues un valor que siga del último anterior a la lista. los dobles [[]] son necesarios por notación de R para señalar una posición particular en la lista.

cat(x1,x2,...,xn)
Sirve para imprimir en consola valores y texto en la misma línea.
Se utilizó para saber dónde fueron removidos negativos para poder valorar después del proceso automático si era necesario. También para señalar la presencia de nulos en alguno de los datos y siempre saber específicamente dónde.

names(lista)=nombres
Sirve para a los valores de una lista darle nombres con los cuáles poder identificarlos más allá de los índices. En este caso va a servir nombrarlos por el año que corresponden porque es mucho más claro que los índices.

## Funciones
revisar_datos 
 

agregar_a_lista 
argumentos
	- i:la hoja del excel donde se encuentra el dato
	- lista: una lista en la cual agregar los data.frames con la información de frecuencias por semana
	- file_path: la dirección del archivo de excel
	- rango_tabla: las coordenadas de la tabla de excel con los datos.