# ============================================================
# plot_menores_padre_hogar.R
# Genera el gráfico del porcentaje de menores cuyo padre vive
# en el hogar, por grupo de edad.
# Requiere: data/menores_padre_hogar/resumen_menores_padre_hogar_ensanut2018.rds
# Guarda: outputs/menores_padre_hogar_ensanut2018.png
# ============================================================
# Ejecutar desde la raíz del proyecto:
# Rscript scripts/menores_padre_hogar.R
# ============================================================

source("scripts/utils.R")
source("scripts/packages.R")
ensure_packages(c("dplyr", "ggplot2", "ragg", "scales", "stringr"))

out_path <- "outputs/menores_padre_hogar_ensanut2018.png"

plot_df <- readRDS("data/menores_padre_hogar/resumen_menores_padre_hogar_ensanut2018.rds") %>%
  mutate(
    grupo_edad = factor(
      as.character(grupo_edad),
      levels = c("1-5", "6-10", "11-15", "16-18"),
      labels = c("1 a 5\naños", "6 a 10\naños", "11 a 15\naños", "16 a 18\naños")
    ),
    pct_padre_expandido = pct_padre_expandido / 100
  )

title_raw <- "A medida que crecen, menos \nniños viven en el hogar con su padre"
subtitle_raw <- paste(
  "Porcentaje de niñas, niños y adolescentes cuyo padre",
  "vive en el hogar, por grupo de edad, ENSANUT 2018",
  sep = "\n"
)
caption_raw <- paste(
  "Fuente: INEC, Encuesta Nacional de Salud y Nutrición (ENSANUT), 2018. Cálculos",
  "de Alonso Quijano-Ruiz para El Quantificador de Laboratorio LIDE. Nota: Las proporciones",
  "son ponderadas por el factor de expansión de la encuesta.",
  sep = "\n"
)

g_menores_padre <- ggplot(
  plot_df,
  aes(x = grupo_edad, y = pct_padre_expandido)
) +
  geom_col(fill = "#00A1CB", width = 0.58) +
  geom_text(
    aes(label = percent_intl(pct_padre_expandido, accuracy = 0.1)),
    vjust = -0.3,
    size = 2.7,
    colour = "grey20"
  ) +
  scale_y_continuous(
    labels = label_percent_intl(accuracy = 1),
    limits = c(0, 0.82),
    breaks = seq(0, 0.8, 0.2),
    expand = expansion(mult = c(0, 0.02))
  ) +
  labs(
    title = title_raw,
    subtitle = subtitle_raw,
    x = NULL,
    y = "Porcentaje",
    caption = caption_raw
  ) +
  theme_quantificador() +
  theme(
    axis.text.x = element_text(colour = "grey20", size = 7.5, margin = margin(t = 8)),
    axis.text.y = element_text(colour = "grey20", size = 7.5),
    axis.ticks.x = element_blank(),
    axis.title.y = element_text(size = 7, margin = margin(r = 5), hjust = 0.5),
    plot.title = element_text(colour = "grey20", size = 12.5, face = "bold", hjust = 0, lineheight = 1.02),
    plot.subtitle = element_text(colour = "grey30", size = 9, lineheight = 1.08, hjust = 0),
    plot.caption = element_text(
      colour = "grey30",
      size = 6,
      lineheight = 1.08,
      hjust = 0,
      margin = margin(t = 6)
    ),
    plot.margin = margin(5, 14, 5, 12)
  )

g_menores_padre_logo <- add_logo(
  g_menores_padre,
  x = 0.895,
  y = 0.085,
  width = 0.08,
  height = 0.08
)

dir.create("outputs", showWarnings = FALSE, recursive = TRUE)

ggsave(
  filename = out_path,
  plot = g_menores_padre_logo,
  width = 3.6,
  height = 4.9,
  dpi = 320,
  device = ragg::agg_png,
  bg = "white"
)

message("Guardado: ", out_path)
