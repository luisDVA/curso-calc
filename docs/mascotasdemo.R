# limpiar archivo de mascotas
library(readxl)
library(unheadr)
library(janitor)
library(stringr)
library(dplyr)

excel_sheets("hojs/mascotas2.xlsx")


# importar, estandarizando datos faltantes
masc <- read_excel("hojs/mascotas2.xlsx", na = c("NA", "falta"))
# aplanar los nombres de las variables y homogeneizar
masc <- masc |> mash_colnames(2) |> clean_names()
masc


# fechas?
masc <- masc |>
  mutate(
    fecha_sindiag = if_else(
      !str_detect(fecha_de_ingreso, "/"),
      fecha_de_ingreso,
      NA_character_
    )
  )

masc <- masc |>
  mutate(fecha_limpia = excel_numeric_to_date(as.numeric(fecha_sindiag)))

# formato
mascformat <-
  annotate_mf_all("hojs/mascotas2.xlsx") |>
  mash_colnames(2) |>
  clean_names()

mascformat

mascformat <- mascformat |>
  mutate(unidades_peso = if_else(str_detect(peso, "bold"), "kg", "lbs"))

mascformat <-
  mascformat |>
  mutate(
    revisar_chip = if_else(str_detect(chip, "highlight"), "revisar", "listo")
  )

# para juntar las dos tablas
mascotas_ind <- mascformat |>
  select(nombre_de_la_mascota, unidades_peso, revisar_chip)

# juntar las tablas
mascotas_casi_final <- left_join(
  masc,
  mascotas_ind,
  by = "nombre_de_la_mascota"
)

# convertir las unidades
mascotas_casi_final |>
  mutate(peso_kg = if_else(unidades_peso == "lbs", peso * 0.453, peso)) |>
  View()