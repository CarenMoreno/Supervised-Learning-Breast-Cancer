# Supervised-Learning-Breast-Cancer
Supervised machine learning pipeline in R for breast cancer diagnosis classification KNN, SVM, Decision Tree, Random Forest and GBM with 10-fold cross-validation and ROC analysis.

# Supervised Learning Applied to Breast Cancer Diagnosis

![R](https://img.shields.io/badge/R-4.x-276DC3?style=flat&logo=r&logoColor=white)
![caret](https://img.shields.io/badge/caret-ML%20Framework-orange?style=flat)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat)

Aplicación de seis algoritmos de **aprendizaje supervisado** sobre el dataset Wisconsin Breast Cancer Diagnostic para clasificar tumores mamarios como malignos (M) o benignos (B) a partir de características morfológicas del núcleo celular.

---

## Descripción

Este proyecto forma parte de la asignatura **Algoritmos e Inteligencia Artificial** del Máster Universitario en Bioinformática (UNIR). Se implementa un pipeline completo de machine learning en R utilizando el framework `caret`, cubriendo desde la preparación de los datos hasta la comparación de modelos mediante curvas ROC.

### Dataset

**Wisconsin Breast Cancer Diagnostic** - 569 muestras, 30 variables numéricas derivadas de imágenes digitalizadas de aspirados con aguja fina (FNA) de masa mamaria.

| Variable objetivo | Descripción |
|---|---|
| `M` (Maligno) | 212 casos |
| `B` (Benigno) | 357 casos |

Las variables predictoras describen características del núcleo celular (radio, textura, perímetro, área, suavidad, compacidad, concavidad, simetría y dimensión fractal), calculadas como media, error estándar y peor valor observado.

---

## Modelos implementados

| Modelo | Método en caret | Hiperparámetro optimizado |
|---|---|---|
| K-Nearest Neighbors | `knn` | Número de vecinos (k) |
| SVM Lineal | `svmLinear` | Coste (C) |
| SVM Radial (RBF) | `svmRadial` | Sigma, Coste (C) |
| Árbol de Decisión | `rpart` | Parámetro de complejidad (cp) |
| Random Forest | `rf` | Variables por nodo (mtry) |
| Gradient Boosting | `gbm` | n.trees, profundidad, shrinkage |

Todos los modelos se entrenaron con **validación cruzada de 10 folds** sobre el 70% de los datos, y se evaluaron sobre un conjunto de prueba independiente (30% del dataset).

---

## Estructura del repositorio

```
Supervised-Learning-Breast-Cancer/
│
├── Moreno_Caren_Actividad2_AlgoritmosIA.R   # Script principal (ejecutable)
│
├── data/
│   ├── data.csv                             # Dataset Wisconsin Breast Cancer
│   └── variables.csv                        # Documentación de variables
│
├── results/
│   ├── Resultados_accuracy_modelos.csv      # Tabla comparativa de Accuracy y Kappa
│   └── Resultados_AUC_modelos.csv           # Tabla comparativa de AUC por modelo
│
├── figures/                                 # Gráficos generados por el script
│   ├── knn_tuning.png
│   ├── svm_lineal_tuning.png
│   ├── svm_radial_tuning.png
│   ├── dt_tuning.png
│   ├── dt_tree.png
│   ├── rf_tuning.png
│   ├── gbm_tuning.png
│   ├── roc_curves.png
│   ├── model_comparison_bwplot.png
│   └── variable_importance_rf.png
│
├── docs/
│   └── mubio04_act2_ind.pdf                 # Enunciado de la actividad
│
├── .gitignore
└── README.md
```

---

## Cómo reproducir el análisis

### Requisitos

- R ≥ 4.0
- RStudio (recomendado)

### Pasos

**1. Clonar el repositorio**

```bash
git clone https://github.com/TU-USUARIO/Supervised-Learning-Breast-Cancer.git
cd Supervised-Learning-Breast-Cancer
```

**2. Verificar que los datos están en su lugar**

Asegurarse de que `data.csv` está dentro de la carpeta `data/`.  
El dataset original está disponible en el [UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/17/breast+cancer+wisconsin+diagnostic).

**3. Ajustar el directorio de trabajo en RStudio**

Abrir el proyecto en RStudio y ejecutar al inicio:

```r
setwd("ruta/a/Supervised-Learning-Breast-Cancer")
```

O usar directamente *Session → Set Working Directory → To Source File Location*.

**4. Ejecutar el script**

Abrir `Actividad2_AlgoritmosIA.R` en RStudio y ejecutar con `Ctrl + Shift + Enter`.

Los paquetes necesarios se instalan automáticamente si no están presentes. Las carpetas `figures/` y `results/` se crean solas al correr el script.

---

## Principales resultados

> Los valores exactos de Accuracy y AUC dependen de la ejecución; los resultados reproducibles se almacenan en `/results`.

- **Random Forest** y **GBM** obtienen el mayor Accuracy y AUC en el conjunto de prueba, superando el 95% en ambos casos.
- El **Árbol de Decisión** individual es el modelo más interpretable aunque con menor rendimiento predictivo.
- Las variables más discriminantes identificadas por Random Forest corresponden a características del tercer momento estadístico: `concave_points3`, `perimeter3`, `radius3` y `area3`.

<p align="center">
  <img src="figures/07_comparacion_accuracy.png?raw=true" width="600" alt="accuracy">
</p>

---

## Paquetes utilizados

```r
tidyverse · caret · e1071 · rpart · rpart.plot · rattle
randomForest · gbm · pROC · PRROC · gridExtra
```

---

## Autora

**Caren Moreno**  
Máster Universitario en Bioinformática - UNIR  
Asignatura: Algoritmos e Inteligencia Artificial

# Supervised Learning Applied to Breast Cancer Diagnosis

![R](https://img.shields.io/badge/R-4.x-276DC3?style=flat&logo=r&logoColor=white)
![caret](https://img.shields.io/badge/caret-ML%20Framework-orange?style=flat)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat)

Aplicación de cinco algoritmos de **aprendizaje supervisado** sobre el dataset **Wisconsin Breast Cancer Diagnostic** para clasificar tumores mamarios como malignos (M) o benignos (B) a partir de características morfológicas del núcleo celular extraídas mediante imágenes digitales de aspirados con aguja fina (FNA).

---

## Descripción

Este proyecto implementa un pipeline completo de machine learning en R utilizando el framework `caret`. Se entrena, optimiza y compara el rendimiento de cinco modelos supervisados sobre datos biológicos reales, evaluando su capacidad para distinguir entre tumores benignos y malignos.

### Dataset

**Wisconsin Breast Cancer Diagnostic (WBCD)**

| Característica | Detalle |
|---|---|
| Muestras | 569 pacientes |
| Variables predictoras | 30 (características morfológicas del núcleo celular) |
| Variable objetivo | `Diagnosis`: M = Maligno (212), B = Benigno (357) |
| Fuente | UCI Machine Learning Repository |

Las variables describen media, error estándar y peor valor observado de diez características nucleares: radio, textura, perímetro, área, suavidad, compacidad, concavidad, puntos cóncavos, simetría y dimensión fractal.

---

## Modelos implementados

| # | Modelo | Método (`caret`) | Hiperparámetro optimizado |
|---|---|---|---|
| 1 | K-Nearest Neighbors | `knn` | Número de vecinos (k) |
| 2 | Support Vector Machine (RBF) | `svmRadial` | Sigma y Coste (C) |
| 3 | Árbol de Decisión | `rpart` | Parámetro de complejidad (cp) |
| 4 | Random Forest | `rf` | Variables por nodo (mtry) |
| 5 | Gradient Boosting Machine | `gbm` | n.trees, profundidad, shrinkage |

Todos los modelos se entrenaron con **validación cruzada de 10 folds** sobre el 70% de los datos, y se evaluaron en un conjunto de prueba independiente (30%).

---

## Estructura del repositorio

```
Supervised-Learning-Breast-Cancer/
│
├── Actividad2_AlgoritmosIA.R          # Script principal (ejecutable)
│
├── data/
│   ├── data.csv                       # Dataset Wisconsin Breast Cancer Diagnostic
│   └── variables.csv                  # Documentación descriptiva de variables
│
├── results/
│   └── Resultados_accuracy.csv        # Tabla comparativa de Accuracy y Kappa
│
├── figures/                           # Gráficos generados al ejecutar el script
│   ├── 01_knn_tuning.png              # Accuracy vs. k (KNN)
│   ├── 02_svm_tuning.png              # Accuracy vs. C (SVM Radial)
│   ├── 03_arbol_decision.png          # Árbol de decisión final
│   ├── 04_arbol_tuning.png            # Accuracy vs. cp (Árbol de Decisión)
│   ├── 05_rf_tuning.png               # Accuracy vs. mtry (Random Forest)
│   ├── 06_gbm_tuning.png              # Accuracy vs. hiperparámetros (GBM)
│   ├── 07_comparacion_accuracy.png    # Comparativa de accuracy entre modelos
│   └── 08_importancia_variables_rf.png # Top 15 variables más importantes (RF)
│
├── .gitignore
└── README.md
```

---

## Cómo reproducir el análisis

### Requisitos

- R ≥ 4.0
- RStudio (recomendado)

### Pasos

**1. Clonar el repositorio**

```bash
git clone https://github.com/TU-USUARIO/Supervised-Learning-Breast-Cancer.git
cd Supervised-Learning-Breast-Cancer
```

**2. Verificar que los datos están en su lugar**

Asegurarse de que `data.csv` está dentro de la carpeta `data/`.  
El dataset original está disponible en el [UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/17/breast+cancer+wisconsin+diagnostic).

**3. Ajustar el directorio de trabajo en RStudio**

Abrir el proyecto en RStudio y ejecutar al inicio:

```r
setwd("ruta/a/Supervised-Learning-Breast-Cancer")
```

O usar directamente *Session → Set Working Directory → To Source File Location*.

**4. Ejecutar el script**

Abrir `Actividad2_AlgoritmosIA.R` en RStudio y ejecutar con `Ctrl + Shift + Enter`.

Los paquetes necesarios se instalan automáticamente si no están presentes. Las carpetas `figures/` y `results/` se crean solas al correr el script.

---

## Figuras generadas

| Figura | Descripción |
|---|---|
| `01_knn_tuning.png` | Accuracy en validación cruzada según el número de vecinos k |
| `02_svm_tuning.png` | Accuracy en validación cruzada según el coste C del SVM radial |
| `03_arbol_decision.png` | Estructura del árbol de decisión final con reglas de clasificación |
| `04_arbol_tuning.png` | Accuracy en validación cruzada según el parámetro de complejidad cp |
| `05_rf_tuning.png` | Accuracy en validación cruzada según mtry en Random Forest |
| `06_gbm_tuning.png` | Accuracy en validación cruzada según hiperparámetros del GBM |
| `07_comparacion_accuracy.png` | Gráfico comparativo del accuracy final de los cinco modelos |
| `08_importancia_variables_rf.png` | Top 15 variables más discriminantes según Random Forest |

---

## Resultados

Los resultados exactos de accuracy y kappa se almacenan en `results/Resultados_accuracy.csv` al ejecutar el script.

De manera general, **Random Forest** y **SVM Radial** obtuvieron el mayor accuracy en el conjunto de prueba. Las variables más discriminantes identificadas por el análisis de importancia corresponden a características del tercer momento estadístico del núcleo celular (`concave_points3`, `perimeter3`, `area3`).

<p align="center">
  <img src="figures/07_comparacion_accuracy.png?raw=true" width="600" alt="accuracy">
</p>

---

## Paquetes utilizados

```r
caret · tidyverse · randomForest · e1071 · rpart · rpart.plot · gbm · pROC
```

---

## Autora

**Caren Nicole Moreno**  
Máster Universitario en Bioinformática - UNIR  
Asignatura: Algoritmos e Inteligencia Artificial
