# elquantificador_plots

Repositorio de gráficos para El Quantificador. El proyecto contiene scripts de R, datos procesados y salidas listas para publicación.

## Contenido

- `code/`: scripts de R para generar gráficos y utilidades compartidas.
- `data/`: datos procesados usados por los scripts.
- `outputs/`: gráficos exportados en formato PNG.
- `quantificador.png`: logo usado en los gráficos.

## Gráficos disponibles

El script `code/lgbtq.R` genera dos gráficos con datos de la Encuesta Mundial de Valores (WVS) para Ecuador:

- `outputs/lgbtq_homo_vecinos.png`
- `outputs/lgbtq_homo_padres.png`

## Reproducir los gráficos

Desde la raíz del proyecto, ejecutar:

```r
source("code/lgbtq.R")
```

O desde la terminal:

```sh
Rscript code/lgbtq.R
```

El script instala y carga los paquetes necesarios mediante `code/packages.R` y guarda los PNG actualizados en `outputs/`.

## Fuente

Encuesta Mundial de Valores (WVS), Ecuador. Cálculos de Alonso Quijano Ruiz para El Quantificador.
