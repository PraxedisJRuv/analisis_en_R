# Predicción diabetes gestacional

Se buscaba determinar la probabilidad de desarrollar diabetes gestacional dados ciertos antecedentes, entre ellos el IMC. La manera en que se resolvió fue a través de una regresión logística.

# Detalles
- El IMC se consideró como una variable categórica con factores "normal", "sobrepeso" y "obesidad", lo cuál determinaría que la regresión requeriría un 1, 2 y 3 en una entrada para representar esas categorías.
- Las probabilidades de desarrollar diabetes gestacional presentadas en los resultados eran alarmentemente altas, teniendo en varias marcadas por encima del 50%
- Al revisar manualmente si los valores coincidían, fallaban siempre debajo y se notó que de hecho, pareciese que estaban recorridos y en realidad la categorías "normal", "sobrepeso" y "obesidad" equivalían a un 2, 3 y 4 como valores de entrada de la regresión, lo que significaría que existía otra categoría no reportada en los datos, clasificaciones y metodología

# ¿Qué errores se cometieron?
1. Al intentar replicar los valores reportados con el modelo de la regresión se noto la inconsitencia y que los valores encajaban perfectamente si se añadía una categoría previa a "normal", sin embargo esto no estaba reportado.

2. Una posibilidad no tan factible pero posible es el uso de variables dummy no reportadas en el modelo ni integradas apropiadamente en el modelo final. De cualquier forma, había información que no se presentaba de manera clara y completa.

# Posibles Soluciones
Notar si hubo otra categoría, se añadió algo al modelo o se estaban tomando consideraciones especiales. Detallar en la construcción de la regresión y todas las variables consideradas y no solo la ecuación o modelo final. 