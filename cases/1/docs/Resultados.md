\# Resultados infvscovid



\## Notas previas

&#x09;- A menos que se especifique se está hablando de la suma de casos positivos a nivel nacional

&#x09;- Había algunos negativos, pero estos fueron cambiados por su valor absoluto. Hubieron 5 negativos, 1 en 2020 , 1 en 2024, 2 en 2025 y 1 en 2026. Los dos primeros eran en covid y los otros 3 de influenza.

&#x09;- Los outputs crudos están al final



\## ceros

Lo primero a notar es la presencia de ceros de casos de influenza, 

&#x09;- Ceros nacionales son el 0.09% de los datos

&#x09;- Donde el \~42% de los datos durante la pandemia son ceros

&#x09;- Únicamente hay ceros nacionales en este período

&#x09;- La dispersión dada por los ceros confirmó la necesidad de un modelo de regresión negativa



\## Estacionalidad



Reajusté las iteraciones y otros hiperparametros para revisar si convergía con estacionalidad 2, pero no parece conseguirlo. De cualquier forma, estacionalidad K=3, se mantiene como la de menor AIC, aunque mayor BIC. Realizando una proporción AIC/BIC se obtuvo que K=3 se mantenía outperfomreando a K=1, por esto y porque es más realista es que tomó la decisión de tomar esta estacionalidad. De cualquier forma se calcularon el resto de resultados para tomarlos un poco en cuenta y tener una noción más clara de la consistencia de lo que se estuvo realizando.



El LR probó (LRR \~21, p=0.0015) una mejoría al usar "periodo" en lugar de "pandemia", esto junto con los resultados visuales y otras consideraciones teóricas, como la permisividad de variar los coeficientes de Fourier por período. El ajuste periodo respeta mucho mejor la variabilidad interanual de los picos post-pandemia. Aunque tiene más grados de libertad, visualmente captura la verdadera heterogeneidad de las temporadas de influenza sin aplanar de más los picos más altos.



Aunque el BIC penalizaba al modelo por periodo por tener más parámetros, las gráficas demuestran que el modelo de pandemia sufre de un sesgo de especificación considerable en la estacionalidad post-pandemia (el supuesto de que la estacionalidad post-2022 es fija y uniforme se rompe con la realidad de los datos).



Se consideraron también la dispersión de los datos, theta y Ljung-Box, pero o son demasiado parecidos, o no son interpretables por la autocorrelación presente en el modelo.



El modelo elegido para las estimaciones fue el por período con estacionalidad 3. Es decir, se eligió un modelo que permitía modificar los coeficientes de Fourier en pre, pand y post pandemia, además de contar con 3 pares de armónicos. 



\## HAC



Los coeficientes del modelo no son interpretables. Los pocos que son estadísticamente significativos, no son interpretables ya que son no-identificables, pues toman una forma concreta para cancelar otros miembros del modelo y ajustar de manera precisa. Lo que sirvió de aquí fue corroborar consistencia del modelo, pues variando L, se mantuvo prácticamente igual el modelo. 



\## Observado/Esperado

Por periodo con contrafactual plano se tuvo una caída del \~80% durante la pandemia y un repunte del \~79% post, con respecto al período previo a pandemia.

El bootstrap corresponde solo con la caída, garantizando intervalos de confianza de una caída en pandemia del \~ -92% - -52%, mientras que para el repunte da un IC \~ -18% - +287%. con medianas -81% y +52%.



Así que podemos concluir con certeza que hubo una caída en la pandemia (\~80%), mientras que si bien, la evidencia apunta de un repunte (\~52%), no podemos garantizar esto porque el IC generado por el bootsrap incluye la posibilidad de ningún cambio. 



Al hacer los coeficientes observados/esperado, son consistentes con estos resultados, excepto por el único período post-pandemia en el que hubo una razón observado/esperado menor y ese fue el último evaluado hasta la semana 35 de 2026.



\## Sensibilidad

Un modelo co rezago se ajustó como sensibilidad, donde se crearon distintos recortes alrededor de la pandemia de 0, 4, 8 y 12 semanas, ninguno presentando cambios significativos en los coeficientes del modelo pospandemia. El mayor cambio del valor del coeficiente fue de 0.014 puntos porcentuales (1.641-1.655), el cual no es un cambio relevante, por lo que ningún otro lo es. Así que el modelo se presenta consistente y robusto con respecto a distintas fechas de corte para la pandemia.



También se revisaron las estimaciones por parte de las otras opciones que se tuvieron a considerar, es decir, estacionalidad K=1 y el modelo pandemia, con respecto a las distintas combinaciones de estacionalidad y de modelo, así como una segunda opción de fecha de corte de pandemia en noviembre de 2021. Sin embargo, la estacionalidad 1 no pudo converger. Así que donde se pudo comparar, no se notaron cambios tan significativos en las predicciones de la razón observado/esperado, pero sí hay reducciones considerables de la estacionalidad 3 en el AIC, sea en el modelo pandemia (26 puntos) o periodo (29 puntos).



Se reviso precisamente si algo se afectaba cambiando la fecha de corte y modelo, pero todo se mantiene consistente, exactamente igual. Las diferencias podrían ser más dependientes de la entropía del computo de decimales de C que cambios significativamente reales.



\## Temporada

El análisis descriptivo de los picos, es algo que requiere mucho más contexto del que dispongo, así que ese análisis lo relego.



\## Resultados adicionales



\### Panel estatal con efectos fijos

En un modelo de panel con efectos fijos de estado y de semana (que absorben las diferencias permanentes entre estados y todo cambio nacional común), la intensidad relativa de COVID rezagada una semana no mostró asociación negativa con los positivos de influenza (IRR 1.10, IC 95 % 0.99-1.22; p = 0.089, errores agrupados por estado). La ausencia de asociación negativa es compatible con que no haya interferencia detectable a esta escala, aunque con solo positivos no es posible distinguir circulación real de cambios en la detección.



\### Correlación cruzada 

Quita estacionalidad y tendencia con diferencias y mira si los cambios semanales de ambos virus se mueven en sentidos opuestos y con qué rezago.

Puede servir para el periodo post, cuando ya ambas circulan.



\------

diagrama ACF covid(t+k) vs influenza (t)

\------

El punto de mayor ACF es en la semana 0, es decir, cuando sube COVID, sube influenza. Es muy probablemente un sesgo de vigilancia y lo que sesga todo el posible análisis.

Los -0.2 no son muy interpretables porque hay mucho ruido y las bandas por si mismo son de \~.14, así que no son precisamente interpretables o reportables.



\### Cambio y fase de amplitud estacional 

El punto es revisar si el COVID modificó estacionalidad de influenza, particularmente, cómo afectó la temporada.



Esto porque en el análisis descripto se notó que pre pandemia los picos de influenza eran alrededor de la semana 4, mientras que después de la pandemia eran alrededor de la semana 6. Aquí se modificaría con los parámetros de estacionalidad K=1, para revisar el mayor pico y el tipo de modelo periodo. 



Para generar los intervalos de confianza, se utiliza el mismo bootstrap que se había usado en \*Res\_principal\*, solo cambiando el output y cómo se mencionó, la estacionalidad y el modelo para evitar la base pandémica artefactual porque se busca evaluar únicamente pre y post



Lo único que describe la amplitud es que las temporadas post son más largas y menos concentradas, que es algo que se vio en el descriptivo con las duraciones de 23-35 semanas.

exp(2\*amplitud) es la razón pico/valle del ciclo anual. Está razón en pre es de alrededor de 11 y en post de 7.2, que concluye en lo anterior.



El adelanto de 3 semanas es irrelevante porque es una diferencia moderada, porque en el descriptivo tuvimos picos en semana 48, 51 y 7, así que el adelanto de 3 semanas es en cuanto al promedio, no un patrón firme.



Al bootsrapear se obtuvieron intervalos que incluían notoriamente al 0, aunque tuvieran colas notorias hacia la izquierda, es parte del problema de las datos, así que el bootsrap termina por confirmar que no hay cambios significativos con respecto a la amplitud y la semana del pico. 



\### Composición entre virus 

\-ignorar-



\### "deuda inmunitaria"

Revisar de manera exploratoria si los que tuvieron más tiempo sin influenza tuvieron un rebote mayor. No se podría concluir mucho, porque hay demasiado ruido que no es sencillo de limpiar o removible en general.



\-----

Se obtuvo:

rho= -0.23

\-----



Sería la correlación entre el rebote post pandemia respecto al promedio de la fase previa. 

Tomando en cuenta que son 32 estados, no es una significancia interpretable. el umbral aproximado para mínima significancia debería ser de cerca de 0.35.

El signo es extraño porque uno creería que habría un rebote mayor entre más tiempo sin contagios, pero igual no es evidencia que se le pueda dar esta interpretación, especialmente estando tan lejana al umbral.

Si todos tienen una proporción de 0 parecida, entonces es irrelvante esta prueba.



\----

Se obtuvo 

p=0.1955



&#x20;  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 

&#x20;0.7009  0.7944  0.8224  0.8347  0.8715  0.9533 

\-----



Así que la correlación no es relevante, y como ya en el primer cuartil, el 80% coincide en ceros, es suficiente para demostrar que comparten demasiados ceros y el resultado no puede obtenerse de esta forma.





\# Resultados crudos



\## ceros



0.09

&#x20;     pre  pandemia      post 

0.0000000 0.4205607 0.0000000 



&#x20;\[1] "2020-07-12" "2020-07-19" "2020-08-09" "2020-08-16" "2020-08-23"

&#x20;\[6] "2020-09-20" "2020-09-27" "2020-10-11" "2020-10-18" "2020-10-25"

\[11] "2020-11-01" "2020-11-08" "2020-11-15" "2020-11-22" "2020-11-29"

\[16] "2020-12-06" "2020-12-13" "2020-12-27" "2021-01-03" "2021-01-10"

\[21] "2021-01-17" "2021-01-24" "2021-01-31" "2021-02-14" "2021-02-21"

\[26] "2021-02-28" "2021-03-07" "2021-03-14" "2021-03-21" "2021-04-04"

\[31] "2021-04-18" "2021-04-25" "2021-05-02" "2021-05-09" "2021-05-16"

\[36] "2021-05-23" "2021-05-30" "2021-06-06" "2021-06-13" "2021-06-27"

\[41] "2021-07-11" "2021-07-18" "2021-08-08" "2021-10-03" "2021-10-17"



\## Estacionalidad



Estacionalidad con hipótesis "todo común"

&#x20;    K      AIC      BIC conv

\[1,] 1 5474.753 5512.685    0

\[2,] 2 5494.381 5540.742    0

\[3,] 3 5495.805 5550.595    0

\[4,] 4 5492.450 5555.669    0



Estacionalidad con hipótesis "solo pandemia"



&#x20;    K      AIC      BIC conv

\[1,] 1 5418.177 5464.538    1

\[2,] 2 5416.107 5479.326    0

\[3,] 3 5392.305 5472.383    1

\[4,] 4 5397.603 5494.539    1



Estacionalidad con hipótesis "por período"

&#x20;    K      AIC      BIC conv

\[1,] 1 5411.112 5465.902    1

\[2,] 2 5406.592 5486.670    0

\[3,] 3 5382.841 5488.206    1

\[4,] 4 5388.067 5518.720    1



Proporción AIC/BIC

&#x09;pand		periodo

1	0.991516	0.989976

3	0.9853669	0.9808016



Response: flu

&#x20;                                                          Model    theta

1           tt + D1 + S1 + D2 + S2 + s1 + c1 + s2 + c2 + s3 + c3 1.153610

2    tt + D1 + S1 + D2 + S2 + pand:(s1 + c1 + s2 + c2 + s3 + c3) 1.442569

3 tt + D1 + S1 + D2 + S2 + periodo:(s1 + c1 + s2 + c2 + s3 + c3) 1.514846

&#x20; Resid. df    2 x log-lik.   Test    df  LR stat.     Pr(Chi)

1       488       -5469.805                                   

2       482       -5354.305 1 vs 2     6 115.49980 0.000000000

3       476       -5332.841 2 vs 3     6  21.46428 0.001513416



&#x20;      df      AIC

m\_c    13 5495.805

m\_pand 19 5392.305

m\_per  25 5382.841

&#x20;      df      BIC

m\_c    13 5550.595

m\_pand 19 5472.383

m\_per  25 5488.206



solo pandemia | dispersión: 0.93 | theta: 1.44 | Ljung-Box p: 0 



por periodo | dispersión: 0.96 | theta: 1.51 | Ljung-Box p: 0 



\## HAC



\[\[1]]

&#x20;                     IRR     lo      hi     p

(Intercept)        74.496 50.557 109.770 0.000

tt                  1.092  0.919   1.297 0.319

D1                  0.075  0.019   0.299 0.000

S1                  1.161  0.393   3.434 0.787

D2                 15.117  4.923  46.416 0.000

S2                  0.784  0.264   2.322 0.660

periodopre:s1       2.173  1.563   3.021 0.000

periodopandemia:s1  5.096  2.812   9.234 0.000

periodopost:s1      1.432  1.112   1.845 0.005

periodopre:c1       2.458  1.945   3.106 0.000

periodopandemia:c1  4.512  2.069   9.838 0.000

periodopost:c1      2.515  2.021   3.130 0.000

periodopre:s2       1.352  1.070   1.709 0.012

periodopandemia:s2  0.867  0.476   1.579 0.641

periodopost:s2      0.980  0.768   1.250 0.871

periodopre:c2       1.109  0.832   1.478 0.480

periodopandemia:c2  1.305  0.719   2.369 0.381

periodopost:c2      1.053  0.877   1.264 0.581

periodopre:s3       0.900  0.689   1.174 0.436

periodopandemia:s3  0.763  0.464   1.254 0.286

periodopost:s3      0.974  0.797   1.190 0.796

periodopre:c3       0.813  0.669   0.989 0.038

periodopandemia:c3  1.899  1.118   3.226 0.018

periodopost:c3      1.000  0.844   1.184 0.998



\[\[2]]

&#x20;                     IRR     lo      hi     p

(Intercept)        74.496 49.270 112.637 0.000

tt                  1.092  0.914   1.303 0.332

D1                  0.075  0.017   0.343 0.001

S1                  1.161  0.353   3.821 0.805

D2                 15.117  4.418  51.725 0.000

S2                  0.784  0.239   2.575 0.688

periodopre:s1       2.173  1.508   3.131 0.000

periodopandemia:s1  5.096  2.631   9.870 0.000

periodopost:s1      1.432  1.081   1.897 0.012

periodopre:c1       2.458  1.948   3.100 0.000

periodopandemia:c1  4.512  1.928  10.557 0.001

periodopost:c1      2.515  2.020   3.132 0.000

periodopre:s2       1.352  1.059   1.727 0.016

periodopandemia:s2  0.867  0.495   1.519 0.618

periodopost:s2      0.980  0.754   1.273 0.880

periodopre:c2       1.109  0.840   1.464 0.466

periodopandemia:c2  1.305  0.722   2.359 0.377

periodopost:c2      1.053  0.882   1.257 0.569

periodopre:s3       0.900  0.699   1.159 0.413

periodopandemia:s3  0.763  0.520   1.119 0.167

periodopost:s3      0.974  0.797   1.190 0.796

periodopre:c3       0.813  0.680   0.973 0.024

periodopandemia:c3  1.899  1.242   2.902 0.003

periodopost:c3      1.000  0.850   1.176 0.998



\[\[3]]

&#x20;                     IRR     lo      hi     p

(Intercept)        74.496 47.656 116.454 0.000

tt                  1.092  0.913   1.305 0.336

D1                  0.075  0.013   0.429 0.004

S1                  1.161  0.316   4.263 0.822

D2                 15.117  4.004  57.066 0.000

S2                  0.784  0.216   2.846 0.711

periodopre:s1       2.173  1.417   3.331 0.000

periodopandemia:s1  5.096  2.424  10.712 0.000

periodopost:s1      1.432  1.024   2.004 0.036

periodopre:c1       2.458  2.050   2.946 0.000

periodopandemia:c1  4.512  1.915  10.631 0.001

periodopost:c1      2.515  2.032   3.114 0.000

periodopre:s2       1.352  1.055   1.732 0.017

periodopandemia:s2  0.867  0.605   1.244 0.439

periodopost:s2      0.980  0.723   1.328 0.896

periodopre:c2       1.109  0.860   1.431 0.426

periodopandemia:c2  1.305  0.831   2.051 0.248

periodopost:c2      1.053  0.883   1.255 0.566

periodopre:s3       0.900  0.717   1.129 0.362

periodopandemia:s3  0.763  0.587   0.992 0.043

periodopost:s3      0.974  0.813   1.166 0.774

periodopre:c3       0.813  0.687   0.964 0.017

periodopandemia:c3  1.899  1.311   2.749 0.001

periodopost:c3      1.000  0.885   1.129 0.998



&#x20;pandemia      post 

0.1980198 1.5442264 



&#x20;       pandemia      post

2.5%  0.07775811 0.8210696

50%   0.18927540 1.5297557

97.5% 0.48276653 3.8774263



&#x20;  temporada   flu       esp       razon

1  2016-2017  5561 5711.1760 0.973704894

2  2017-2018  3976 7729.9615 0.514362201

3  2018-2019  8247 7729.9845 1.066884414

4  2019-2020  6523 7730.0143 0.843853554

5  2020-2021    24 7785.0235 0.003082842

6  2021-2022  3237 7729.9400 0.418761333

7  2022-2023 11172 7729.9518 1.445287158

8  2023-2024 13252 7729.9709 1.714366101

9  2024-2025 14462 7729.9969 1.870893368

10 2025-2026  9775 7785.0710 1.255608336

11 2026-2027   183  206.2775 0.887154334





\## Sensibilidad



&#x20;      corte1 rec      AIC conv pandemia  post

1  2020-02-23   0 5408.395    1    0.238 1.514

2  2020-03-15   0 5382.841    1    0.198 1.544

3  2020-04-12   0 5319.015    1    0.190 1.641

4  2020-02-23   4 5370.223    1    0.238 1.518

5  2020-03-15   4 5344.846    1    0.198 1.548

6  2020-04-12   4 5281.445    1    0.190 1.646

7  2020-02-23   8 5331.526    1    0.238 1.523

8  2020-03-15   8 5306.178    1    0.198 1.554

9  2020-04-12   8 5242.788    1    0.190 1.652

10 2020-02-23  12 5289.943    1    0.238 1.526

11 2020-03-15  12 5264.694    1    0.198 1.557

12 2020-04-12  12 5201.514    1    0.190 1.655



&#x20;        c2 K    spec      AIC conv pandemia  post

1 2021-11-01 1    pand 5324.260    0    0.087 1.654

2 2022-04-01 1    pand 5380.407    1    0.234 1.804

3 2021-11-01 3    pand 5218.797    1    0.088 1.655

4 2022-04-01 3    pand 5354.180    1    0.232 1.798

5 2021-11-01 1 periodo 5302.931    0    0.077 1.460

6 2022-04-01 1 periodo 5373.020    1    0.211 1.628

7 2021-11-01 3 periodo 5186.264    1    0.076 1.369

8 2022-04-01 3 periodo 5344.846    1    0.198 1.548





\## Temporalidad



&#x20;         temporada n\_sem total\_flu pico\_flu fecha\_pico sem\_pico

2016-2017 2016-2017    26      5561      633 2017-02-26        9

2017-2018 2017-2018    52      3976      390 2018-01-21        4

2018-2019 2018-2019    52      8247      492 2019-02-03        6

2019-2020 2019-2020    52      6523      550 2020-01-19        4

2020-2021 2020-2021    53        24        4 2021-04-11       15

2021-2022 2021-2022    52      3237      460 2022-01-09        2

2022-2023 2022-2023    52     11172     1068 2022-11-27       48

2023-2024 2023-2024    52     13252      650 2023-12-17       51

2024-2025 2024-2025    52     14462      769 2025-02-09        7

2025-2026 2025-2026    53      9775      656 2026-02-08        6

2026-2027 2026-2027     4       183       53 2026-07-12       28

&#x20;         dur\_20pct total\_covid fecha\_pico\_covid pico\_covid

2016-2017        13           0       2017-01-01          0

2017-2018        16           0       2017-07-02          0

2018-2019        29           0       2018-07-01          0

2019-2020        14      221086       2020-06-21          0

2020-2021        13     2305800       2021-01-10      25676

2021-2022        10     3420060       2022-01-16     126701

2022-2023        11     1526238       2022-07-10      12243

2023-2024        35       84699       2023-09-03        174

2024-2025        28       11680       2024-07-21         83

2025-2026        23        2959       2025-07-06         30

2026-2027         4         938       2026-07-12        277

&#x20;         sem\_pico\_covid dur\_20pct.1

2016-2017              1          26

2017-2018             27          52

2018-2019             27          52

2019-2020             26           9

2020-2021              2          46

2021-2022              3          22

2022-2023             28           8

2023-2024             36          12

2024-2025             30          24

2025-2026             28          19

2026-2027             28           4



\## Adicionales



\### Panel estatal de efectos fijos



IRR.cov\_rel  lo.cov\_rel  hi.cov\_rel 

&#x20; 1.0965524   0.9870179   1.2182424 



ML estimation, family = Negative Binomial, Dep. Var.: flu

Observations: 9,216

Fixed-effects: estado: 32,  t: 288

Standard-errors: Clustered (estado) 

&#x20;       Estimate Std. Error z value Pr(>|z|)    

cov\_rel 0.092171   0.054172 1.70145 0.088858 .  

\---

Signif. codes:  0 '\*\*\*' 0.001 '\*\*' 0.01 '\*' 0.05 '.' 0.1 ' ' 1

Over-dispersion parameter: theta = 0.9069517  

Log-Likelihood: -19,574.6   Adj. Pseudo R2: 0.142227

&#x20;          BIC:  42,070.3     Squared Cor.: 0.486429





&#x20;                        m\_sp.1          m\_sp.2

Sample (per)           pandemia            post

Dependent Var.:             flu             flu

&#x20;                                              

cov\_rel         0.1358 (0.2290) 0.0871 (0.0551)

Fixed-Effects:  --------------- ---------------

estado                      Yes             Yes

t                           Yes             Yes

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

S.E.: Clustered      by: estado      by: estado

Observations              1,312           7,904

Squared Cor.            0.23591         0.46493

Pseudo R2               0.26227         0.12755

BIC                     1,936.1        40,093.4

Over-dispersion         0.65166         0.92583



\### Correlación cruzada

&#x20;--Diagrama ACF--



\### Cambio de fase y amplitud estacional



&#x20;     amplitud sem\_pico

pre  1.1934948 6.207914

post 0.9886604 3.096594





dif\_amplitud dif\_sem\_pico 

&#x20; -0.2048344   -3.1113197 



&#x20;     dif\_amplitud dif\_sem\_pico

2.5%    -0.7662063    -7.509591

50%     -0.1973737    -3.005986

97.5%    0.4113862     1.234752



dif\_amplitud dif\_sem\_pico 

&#x20;      0.246        0.078 



\### "Deuda inmunitaria"



\-0.2349604



&#x09;Spearman's rank correlation rho



data:  dur0 and reb

S = 6737.9, p-value = 0.1955

alternative hypothesis: true rho is not equal to 0

sample estimates:

&#x20;      rho 

\-0.2349604 



&#x20;  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 

&#x20;0.7009  0.7944  0.8224  0.8347  0.8715  0.9533

