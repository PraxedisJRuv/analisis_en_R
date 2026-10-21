# limpieza.R
Preparar los datos crudos para que sean manejables en procesos posteriores. Aquí se detectan nulos, se corrigen negativos y se descarta la información innesecaria para procesos posteriores. Se prepara lo necesario como llenar de 0 los datos del COVID previos a 2020 o recorte de últimas semanas reportadas dada posibles actualizaciones de esa información.

## Funciones
### _revisar_ _datos_
 
 Revisa si hay presencia de nulos en los datos y avisa esto para una revisión manual. Cambia los negativos por su valor absoluto, y remueve las filas y columnas innecesarias dependiendo de los datos. por ejemplo, en este caso concreto las filas 34:36 no tenían información relvante y estaban presentes en todos los archvios, por lo que eran removidas ya que solo interesaban los conteos de positivos de las 32 entidades federativas. 

 A su vez, hay criterios condicionales para remover la fila correspondiente a la semana 43, que es algo que existe en epidemiología en México, por la semana epidemiólogica empezar en domingo y es cada 6 años. Por eso se considera el módulo 5, como criterio para considerar si es un año correspondiente, ya que los datos desde los que se usa la función son a partir de 2020, y se toma _i-1_ para comparar con el módulo. 

 Se imprimé cada que se sustituye un negativo para revisar si había una cantidad de negativos anormal. Se consideró simplemente sustituir por valor absoluto ya que eran pocos los negativos y acordó que eran "error de dedo"

 **Argumentos:**
 - _i_: Iteración en la que se está utilizando _revisar datos_, es decir, si _i=5_ es porque se está revisando el quinto año
 - _data_: el dataframe crudo leído del excel donde se tuviera
 - _tipo_: la enfermedad o categoría de lo que se está evalúando la información. Aquí se usó "influenza" y "covid".

### _agregar_ _a_ _lista_

Lee un archivo de excel para obtener los datos de un año de información de los positivos de una enfermedad en específico, bajo determinadas condiciones dadas en los argumentos de la función, llama a la función _revisar_ _datos_ para prepararlos, para después guardarlos en una lista donde se tienen el resto de datos en orden y se mantienen en orden bajo la implementación.

**Argumentos:**
- _i_:la hoja del excel donde se encuentra el dato
- _lista_: una lista en la cual agregar los data.frames con la información de frecuencias por semana
- _file path_: la dirección del archivo de excel
- _rango tabla_: las coordenadas de la tabla de excel con los datos.

## Funciones de R
### _is.na(x)_
Dice si existe un valor nulo en x

### _any(x)_
Dice si hay algún valor TRUE en x

### _which(x, arr.ind=TRUE)_
En qué índices los valores son TRUE. Sin arr.ind no da los índices.
En este caso al x tratarse los datos de un data.frame que cumplen con una determinada condición, sus índices son coordenadas así que está función devuelve una matriz donde los renglones es el dato que cumplió la condición y las columnas su índice de fila e índice de columna del data.frame del que vienen. Por eso se realiza una iteración sobre los valores [i,1] e [i,2] de la matriz resultante.

### _lista[[length(lista)+1]]= valor_
Señala que agregues un valor que siga del último anterior a la lista. los dobles [[]] son necesarios por notación de R para señalar una posición particular en la lista.

### _cat(x1,x2,...,xn)_
Sirve para imprimir en consola valores y texto en la misma línea.
Se utilizó para saber dónde fueron removidos negativos para poder valorar después del proceso automático si era necesario. También para señalar la presencia de nulos en alguno de los datos y siempre saber específicamente dónde.

### _names(lista)=nombres_
Sirve para a los valores de una lista darle nombres con los cuáles poder identificarlos más allá de los índices. En este caso va a servir nombrarlos por el año que corresponden porque es mucho más claro que los índices.