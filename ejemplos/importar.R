# ejercicio, importar archivos
library(readxl)
library(readODS)

# probemos 
read_xls("ejemplos/fastfood.xls") 
read_xls("ejemplos/fastfood.xlsx") 
read_excel("ejemplos/fastfood.xlsx") 
read_excel("ejemplos/fastfood.xls") 

# asignando objeto
chatarra <- read_excel("ejemplos/fastfood.xlsx") 

# opendocumentformat
chatarra_ods <- read_ods("ejemplos/fastfood.ods")

# ¿qué pasa aquí?
read_excel("ejemplos/lasrosas.corn.xlsx")

# hojas
excel_sheets("ejemplos/cafeteria.xlsx")
# impotar 'Bebidas'