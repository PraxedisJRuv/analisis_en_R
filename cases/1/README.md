# Influenza vs COVID
Lo siguiente es una descripción general del análisis realizado. Para información más específica, cada sección de código tendrá documentación detallando las desiciones tomadas, teoría, código, resultados y conclusiones.

## Planteamiento
- Se buscó revisar cómo cambiaron los positivos de influenza detectados antes, durante y después del COVID-19.
Para lo que se contó con los datos de la Dirección General de Epidemiología de México. 

- Solo se contó con los positivos reportadas de las enfermedades. Lo cuál es un problema para determinar los efectos de la cuarentena, pues no podemos separar los cambios reales de las enfermedades de cambios en la vigilancia. Otra limitante resultó ser la falta de información pre-pandemia.

## Diseño 
La recomendación pragmática es que el trabajo sea descriptivo precisamente por la falta de datos ya mencionados. Esto ya que cualquier modelo tendría una lectura imprecisa y sin capacidad de elaborar una conclusión estadísticamente significativa. En caso de requerir una conclusión con significancia estadística, la opción que nos diera la mayor cantidad de tiempo sería realizar un análisis de serie de tiempo de nuestra información.

Así que se propuso una serie de tiempo ininterrumpida como modelo. Dividida en tres segmentos, pre-pandemia, pandemia y post-pandemia. Donde para cada período se estimará un nivel y una pendiente, para así poder proyectar lo que habría pasado y contrastarlo con lo observado, es decir, una prueba contrafactual. 

Se requirió en particular de una serie de tiempo construido con una regresión binomial negativa para capturar el comportamiento de los conteos con una cantidad considerable de ceros. Además, el modelo de la serie de tiempo también se apoyó en series de Fourier para capturar apropiadamente la estacionalidad.

Todo el proceso fue realizado en R versión 4.5.2. El único paquete utilizado fue MASS.
### Pasos del ánalisis

- **Estructurar datos**: Requerimos darle el formato a los datos de una serie de tiempo, por lo que se extrajeron de los excel, y fueron reordenados en formato largo con tiempo continuo, ubicando con cuidado las semanas 53.

- **Nivel de análisis**: Se decidió por agrupar todos los contagios, para solo hacer un análisis nacional. Esto ya que tenerlos por separado creaba problemas de dependencia espacial y en la matriz de varianzas. Mucho tiene que ver con los contrastes entre estados donde se concentra la mayoría de población y el resto del país. Agruparlos por regiones se deja como opción a futuro.

- **Conteo de ceros**: Se realizó un análisis descriptivo sobre las semanas con 0 casos, para revisar cómo pudiera afectar modelos y corroborar la elección de una regresión binomial negativa.

- **Modelo de conteo**: Al tratarse de conteos discretos con una gran dispersión de datos provocada por la abundante prescencia de ceros, se optó por utilizar una regresión bionomial negativa para ajustar a los datos y poder interpretar sus coeficientes como tazas de razones de cambio, que ayudarán a probar el objetivo.

- **Estacionalidad**: Los términos de la serie Fourier nos ayudan a capturar los ciclos de contagio en un año sin tener que estar partiendo los datos en temporadas.

- **Estacionalidad cambiante**: Se plantean tres casos en el que la estacionalidad funciona. El primero es que la estacionalidad de los contagios en los tres períodos es la misma, la segunda que solo cambió en la pandemia y la última es que todos los períodos poseen una estacionalidad distinta.

- **Inferencia**: Como la autocorrelación hace inválidos los errores estándar del modelo, se revisaron los errores HAC (Newey-West)

- **Resultado Principal**: Es la proporción observado/esperado, que para calcularse de forma precisa se realizó un bootstrap por bloques, ya que nos da una lectura mucho más estable que la de ciertos coeficientes que se estaban obtenido del modelo, los cuales no fueron muy identificables.

- **Robustez**: Se midió la sensibilidad a distintas fechas de corte, recorte de cola, los períodos de la serie de Fourier y especificación. Esto para revisar el impacto que pudieran tener, especialmente en relación al período pre-pandemia que era solo uno.

- **Análisis por temporada**: Describir y comparar sin parámetros las formas de las olas, revisando picos, totales, fechas y duración por temporada. (Esto y los 0s es lo que se recomienda hacer).

## Código
La implementación completa del código se encuentra en scripts/ mientras que en docs/ se encuntran documentos .md homónimos a los .R describiendo estos a detalle. 
### orden de ejecución
1. *limpieza.R*
2. *alineamiento.R*
3. *ceros.R* (opcional)
4. *its.R*
5. *estacionalidad.R*
6. *inferencia_HAC.R*
7. *res_principal.R*
8. *sensibilidad.R*
9. *temporadas.R*

## Sobre los datos utilizados
En particular, lo que me fue entregado se trató de dos Exceles con los positivos reportados del COVID e influenza.
La información de la influenza iba de 2019 a la semana 35 de 2026, donde cada año era una hoja del Excel. De COVID era de 2020 a la semana 35 de 2026. Las hojas estaban en orden ascendente y todas las hojas tenían el mismo formato que eran filas por cada estado y cada columna una semana epidemiológica, donde cada celda era un positivo.