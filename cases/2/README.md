# Genotipos de VPH
En un estudio se revisaron varias características de una cierta población de mujeres, entre ellas, qué genotipo de VPH tenían positivo de una lista de -30-. De aquí surgieron dos problemas que era cómo presentar los datos y anlizar la forma en que se presentaban múltiples genotipos.

## Sobre múltiples genotipos
Se vio que de la población positiva, la mayoría presentaba más de un genotipo y el equipo revisó manualmente los pares más comúnes, además propusieron clasificar los resultados en las categorías: un genotipo, dos genotipos y más de dos. Después durante revisión se hizo notar que la cantidad de genotipos que algunos llegaban a tener era de hasta 16, por lo que esas categorías no eran muy representativas, más aún, de las frcuencias más abundantes era con 4 genotipos.

Para poder revisar las agrupaciones, duplas, tripletas, o tuplas en en general de genotipos más frecuentes, se elaboró un código en R que leía los datos guardados en un excel e imprimía las tuplas más comúnes y sus respectivas frecuencias

## Presentación
La manera en que se quería presentar la variedad de genotipos encontrados era una que ayudará a entender las frecuencias, su presencia y el grado de riesgo, ya que cada genotipo distinto está asociado clínicamente con un cierto nivel de riesgo. 

Con referencias a trabajos previos, se decidió optar por un scatterplot donde cada punto es un genotipo y su altura es su frecuencia, de manera que estén ordenados de menor a mayor riesgo y coloreados de maneras particulares para remarcar el grado de riesgo y grupo al que pertenecen.

## Sobre esta carpeta
En scripts/ están los códigos de R para resolver ambos problemas, mientras que en docs/ están archvios .md del mismo nombre explicando el código del que comparten nombre.