###############################################################
# TAREA 2. ALGORITMOS E INTELIGENCIA ARTIFICIAL
# Máster en Bioinformática, UNIR
# Alumna: Caren Nicole Moreno
#
# Aplicación de técnicas de aprendizaje supervisado
# sobre datos biológicos
#
# En este script se realizó lo siguiete:
# 1. Carga de datos
# 2. Limpieza y preparación
# 3. División train/test
# 4. Entrenamiento de múltiples modelos
# 5. Evaluación comparativa
# 6. Selección del mejor modelo
#
###############################################################

############################
# 1. INSTALACIÓN DE PAQUETES
############################

# Instalación de paquetes y verificación de su correcta instalación.

packages <- c(
  "caret",
  "tidyverse",
  "randomForest",
  "e1071",
  "rpart",
  "rpart.plot",
  "gbm",
  "pROC"
)

installed <- packages %in% installed.packages()

if(any(installed == FALSE)){
  install.packages(packages[!installed])
}

# Carga de librerías
library(caret)
library(tidyverse)
library(randomForest)
library(e1071)
library(rpart)
library(rpart.plot)
library(gbm)
library(pROC)

############################
# 2. CONFIGURACIÓN INICIAL
############################

# Fijar semilla para reproducibilidad.
# Para obtener los mismos resultados cada vez que se ejecuta el script.

set.seed(123)

############################
# 3. CARGA DE DATOS
############################

# Lectura del dataset principal

data <- read.csv(
  "C:/Users/Usuario/Downloads/Maestrias en Bioinformatica opciones/Algoritmos e Inteligencia Artificial/Tarea 2/data.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)

# No use el archivo variables.csv para el entrenamiento 
# de los modelos supervisadosa, por tratarse de 
# un documento descriptivo del dataset.

# Limpieza de nombres de columnas
# Se eliminaron los espacios o tabulaciones invisibles.

names(data) <- trimws(names(data))

############################
# 4. EXPLORACIÓN INICIAL
############################

# Para Visualizar las dimensiones del dataset

dim(data)

# Primeras filas

head(data)

# Estructura de los datos

str(data)

# Resumen estadístico

summary(data)

############################
# 5. PREPARACIÓN DE LOS DATOS
############################

# Eliminación de filas duplicadas

data <- distinct(data)

# Verificar valores faltantes

colSums(is.na(data))

# Eliminar filas con NA
# (Elegi esta opción porque me parecio la más sencilla y segura para la tarea)

data <- na.omit(data)

# Eliminé la columna ID porque únicamente
# identifica pacientes y no aporta valor predictivo.

data$ID <- NULL

############################
# 6. DEFINICIÓN DE VARIABLE OBJETIVO
############################

# En este dataset la variable objetivo corresponde
# al diagnóstico tumoral:
#
# M = Tumor maligno
# B = Tumor benigno
#
# Esta será la variable que intentaremos predecir
# mediante aprendizaje supervisado.

target_variable <- "Diagnosis"

cat("Variable objetivo detectada:", target_variable, "\n")

# Para convertir variable objetivo a factor

data[[target_variable]] <- as.factor(data[[target_variable]])

# Para verificar distribución de clases

table(data[[target_variable]])

# Convertir la variable objetivo a factor
# para clasificación supervisada

data[[target_variable]] <- as.factor(data[[target_variable]])

############################
# 7. DIVISIÓN TRAIN / TEST
############################

# División 70% entrenamiento
# 30% prueba

trainIndex <- createDataPartition(
  data[[target_variable]],
  p = 0.7,
  list = FALSE
)

trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]

############################
# 8. CONTROL DE ENTRENAMIENTO
############################

# Validación cruzada de 10 folds

fitControl <- trainControl(
  method = "cv",
  number = 10
)

############################
# 9. MODELO KNN
############################

cat("\nEntrenando modelo KNN...\n")

knnModel <- train(
  as.formula(paste(target_variable, "~ .")),
  data = trainData,
  method = "knn",
  trControl = fitControl,
  preProcess = c("center", "scale"),
  tuneLength = 10
)

print(knnModel)

plot(knnModel)

############################
# 10. MODELO SVM
############################

cat("\nEntrenando modelo SVM...\n")

svmModel <- train(
  as.formula(paste(target_variable, "~ .")),
  data = trainData,
  method = "svmRadial",
  trControl = fitControl,
  preProcess = c("center", "scale"),
  tuneLength = 10
)

print(svmModel)

plot(svmModel)

############################
# 11. ÁRBOL DE DECISIÓN
############################

cat("\nEntrenando árbol de decisión...\n")

dtModel <- train(
  as.formula(paste(target_variable, "~ .")),
  data = trainData,
  method = "rpart",
  trControl = fitControl,
  tuneLength = 10
)

print(dtModel)

# Visualización del árbol

rpart.plot(dtModel$finalModel)

plot(dtModel)

############################
# 12. RANDOM FOREST
############################

cat("\nEntrenando Random Forest...\n")

rfModel <- train(
  as.formula(paste(target_variable, "~ .")),
  data = trainData,
  method = "rf",
  trControl = fitControl,
  importance = TRUE,
  tuneLength = 5
)

print(rfModel)

plot(rfModel)

############################
# 13. GRADIENT BOOSTING
############################

cat("\nEntrenando Gradient Boosting...\n")

gbmModel <- train(
  as.formula(paste(target_variable, "~ .")),
  data = trainData,
  method = "gbm",
  trControl = fitControl,
  verbose = FALSE,
  tuneLength = 5
)

print(gbmModel)

plot(gbmModel)

############################
# 14. PREDICCIONES
############################

knnPred <- predict(knnModel, testData)
svmPred <- predict(svmModel, testData)
dtPred  <- predict(dtModel, testData)
rfPred  <- predict(rfModel, testData)
gbmPred <- predict(gbmModel, testData)

############################
# 15. MATRICES DE CONFUSIÓN
############################

cat("\nResultados KNN\n")
knnConf <- confusionMatrix(knnPred, testData[[target_variable]])
print(knnConf)

cat("\nResultados SVM\n")
svmConf <- confusionMatrix(svmPred, testData[[target_variable]])
print(svmConf)

cat("\nResultados Árbol de Decisión\n")
dtConf <- confusionMatrix(dtPred, testData[[target_variable]])
print(dtConf)

cat("\nResultados Random Forest\n")
rfConf <- confusionMatrix(rfPred, testData[[target_variable]])
print(rfConf)

cat("\nResultados Gradient Boosting\n")
gbmConf <- confusionMatrix(gbmPred, testData[[target_variable]])
print(gbmConf)

############################
# 16. COMPARACIÓN DE ACCURACY
############################

accuracy_results <- data.frame(
  Modelo = c(
    "KNN",
    "SVM",
    "Decision Tree",
    "Random Forest",
    "Gradient Boosting"
  ),
  Accuracy = c(
    knnConf$overall["Accuracy"],
    svmConf$overall["Accuracy"],
    dtConf$overall["Accuracy"],
    rfConf$overall["Accuracy"],
    gbmConf$overall["Accuracy"]
  ),
  Kappa = c(
    knnConf$overall["Kappa"],
    svmConf$overall["Kappa"],
    dtConf$overall["Kappa"],
    rfConf$overall["Kappa"],
    gbmConf$overall["Kappa"]
  )
)

print(accuracy_results)

############################
# 17. GRÁFICO COMPARATIVO
############################

# Comparación visual del accuracy obtenido por cada modelo.

ggplot(
  accuracy_results,
  aes(x = Modelo, y = Accuracy, fill = Modelo)
) +
  geom_col() +
  theme_minimal() +
  labs(
    title = "Comparación de Accuracy entre modelos",
    x = "Modelo",
    y = "Accuracy"
  ) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold")
  )

############################
# 18. MEJOR MODELO
############################

best_model <- accuracy_results[
  which.max(accuracy_results$Accuracy),
]

cat("\nEl mejor modelo fue:\n")
print(best_model)

############################
# 19. IMPORTANCIA DE VARIABLES
############################

# La importancia de variables se analiza
# utilizando el modelo Random Forest.

varImp_rf <- varImp(rfModel)

print(varImp_rf)

plot(varImp_rf)

############################
# 20. GUARDAR RESULTADOS
############################

write.csv(
  accuracy_results,
  "Resultados_accuracy.csv",
  row.names = FALSE
)

cat("\nAnálisis finalizado correctamente.\n")

############################
# 21. CONCLUSIÓN FINAL
############################

# Los modelos de aprendizaje supervisado permitieron clasificar adecuadamente
# los tumores benignos y malignos.Random Forest y SVM presentaron
# los mejores resultados de accuracy, mostrando una buena capacidad predictiva.
#
# Además, el análisis de importancia de variables permitió identificar
# cuáles características tuvieron mayor influencia en la clasificación.