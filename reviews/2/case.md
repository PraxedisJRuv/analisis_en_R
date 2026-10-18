# Identificar factores asociados al Cáncer de Mamá

 A través de un estudio de casos y controles, identificar factores asociados al cáncer de mamá en primer nivel de atención.

# Detalles
- Para este estudio se utilizaron 1:3 casos:controles, pareados por edad.
- Se estableció de qué manera reportar los datos cualitativos y cuantitativos.
- Los factores que se midieron fueron precencia de: antecedentes familiares, mastografía sospechosa, lactancia, menopausia, consumo de alcohol, consumo de tabaco, uso de anticonceptivos orales. Admeás la paridad y si menarquia fue antes o después de los 12 años.
- Los métodos para el análisis fueron las pruebas McNemmar y de rangos de Wilcoxon

# ¿Qué errores se cometieron?
1. Las pruebas McNemmar son para pares 1:1, por eso es una prueba muy usada en estudios longitudinales, aunque en general sirve siempre y cuando sean estudios pareados 1:1. La prueba de rangos Wilcoxon de igual forma quedaría inválidada por la misma razón.

2. Todos los factores medidos fueron cualitativos. No había mucho sentido en sugerir el uso o implementación de pruebas cuantitativas.

# Posibles Soluciones
Para el segundo error y la mención de la rpueba de rangos de Wilcoxon, es más una cuestión narrativa y basta con omitir el caso de mediciones cualitativas si no se está tomando ninguna. En cambio,  para el primero: 

- Un primer instinto común es cuando se trata de una prueba comparando el impacto de variables categóricas es utilizar una ji-cuadrada, sin embargo, hay que recordar que para que está sea válida, se debe contar con independencia de variables, cosa que no existe porque hubo un pareo por edad, así que los controles dependieron de las edades de los casos. 

- Dependiendo el objetivo del investigador y lo que hayan expresado en protocolo de la investigación, tendrían que elegir entre Mantel-Haenzel para controloes 1:m, o una regresión logística condicional. Si solo se busca evalúar la variable categórica sin ajustar por más factores, la primera opción sería la más ideal, que en general da resultados similares a loq ue pudiera ser que se buscara realizar con McNemmar. La regresión logística condicional en cambio, permitiría controlas el efecto confusor de la edad en el pareo, no tiene ningún problema manejando pareos 1:m, y tiene cabida para un trabajo multivariable, sea medir el efecto de dos variables al mismo tiempo o analizar que factores son confusores.