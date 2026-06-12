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

**Wisconsin Breast Cancer Diagnostic (WBCD)** - 569 muestras, 30 variables numéricas derivadas de imágenes digitalizadas de aspirados con aguja fina (FNA) de masa mamaria.

| Variable objetivo | Descripción |
|---|---|
| `M` (Maligno) | 212 casos |
| `B` (Benigno) | 357 casos |

Las variables predictoras describen características del núcleo celular (radio, textura, perímetro, área, suavidad, compacidad, concavidad, simetría y dimensión fractal), calculadas como media, error estándar y peor valor observado.

| Característica | Detalle |
|---|---|
| Muestras | 569 pacientes |
| Variables predictoras | 30 (características morfológicas del núcleo celular) |
| Variable objetivo | `Diagnosis`: M = Maligno (212), B = Benigno (357) |
| Fuente | UCI Machine Learning Repository |

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
- Las variables más discriminantes identificadas por Random Forest corresponden a características del tercer momento estadístico: `concave_points3`, `perimeter3` y `area3`.

<table align="center" style="border: none; border-collapse: collapse;">
  <tr style="border: none;">
    <td align="center" style="border: none; padding: 10px;">
      <img src="figures/03_arbol_decision.png" width="450" alt="Arbol_decision"><br>
      <sub><b>Árbol Decisión</b></sub>
    </td>
    <td align="center" style="border: none; padding: 10px;">
      <img src="figures/07_comparacion_accuracy.png" width="450" alt="comparacion_accuracy"><br>
      <sub><b>Comparación Accuracy</b></sub>
    </td>
  </tr>
</table>

<table align="center" style="border: none; border-collapse: collapse;">
  <tr style="border: none;">
    <td align="center" style="border: none; padding: 10px;">
      <img src="figures/01_knn_tuning.png" width="300" alt="Knn Tuning"><br>
      <sub><b>K-Nearest Neighbors</b></sub>
    </td>
    <td align="center" style="border: none; padding: 10px;">
      <img src="figures/02_svm_tuning.png" width="300" alt="svm_tuning"><br>
      <sub><b>SVM Turing</b></sub>
    </td>
    <td align="center" style="border: none; padding: 10px;">
      <img src="figures/03_arbol_decision.png" width="300" alt="Arbol_decision"><br>
      <sub><b>Árbol Decisión</b></sub>
    </td>
    <td align="center" style="border: none; padding: 10px;">
      <img src="figures/04_arbol_tuning.png" width="300" alt="arbol_tuning"><br>
      <sub><b>Árbol Tuning</b></sub>
    </td>
  </tr>
</table>

<table align="center" style="border: none; border-collapse: collapse;">
  <tr style="border: none;">
    <td align="center" style="border: none; padding: 10px;">
      <img src="figures/05_rf_tuning.png" width="300" alt="Rf Tuning"><br>
      <sub><b>RF Tuning</b></sub>
    </td>
    <td align="center" style="border: none; padding: 10px;">
      <img src="figures/06_gbm_tuning.png" width="300" alt="gbm_tuning"><br>
      <sub><b>GBM Tuning</b></sub>
    </td>
    <td align="center" style="border: none; padding: 10px;">
      <img src="figures/07_comparacion_accuracy.png" width="300" alt="comparacion_accuracy"><br>
      <sub><b>Comparación Accuracy</b></sub>
    </td>
    <td align="center" style="border: none; padding: 10px;">
      <img src="figures/08_importancia_variables_rf.png" width="300" alt="importancia_variables_rf"><br>
      <sub><b>Importancia Variables RF</b></sub>
    </td>
  </tr>
</table>

## Curvas ROC

<p align="center">
  <img src="figures/07_comparativa_curvas_roc.png?raw=true" width="600" alt="curvas ROC">
</p>

---

## Paquetes utilizados

```r
tidyverse · caret · e1071 · rpart · rpart.plot · rattle
randomForest · gbm · pROC · PRROC · gridExtra
```

---

## Autora

**Caren Nicole Moreno**  
Máster Universitario en Bioinformática - UNIR  
Asignatura: Algoritmos e Inteligencia Artificial
