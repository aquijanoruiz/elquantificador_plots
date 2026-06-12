# ------------------------------------------------------------------------------------------------ #
# Gráficos para El Quantificador sobre percepciones de los ecuatorianos frente a la homosexualidad
# con datos de la Encuesta Mundial de Valores (WVS).
# ------------------------------------------------------------------------------------------------ #

source("code/utils.R")
ensure_packages(c("scales"))

# Cargar los datos
wvs_homo_vecinos <- readRDS("data/lgbtq/wvs_homo_vecinos")
wvs_homo_padres <- readRDS("data/lgbtq/wvs_homo_padres")

dir.create("outputs", showWarnings = FALSE, recursive = TRUE)

quantificador_colores <- c(
  "2013" = "#475B8F",
  "2018" = "#D1495B"
)

# ---- A124_09: Preferiría no tener a un homosexual como vecino ----

wvs_homo_vecinos$anio <- factor(wvs_homo_vecinos$anio)
wvs_homo_vecinos$sexo <- factor(wvs_homo_vecinos$sexo, levels = c("Hombre", "Mujer"))

g_homo_vecinos <- ggplot(
  wvs_homo_vecinos,
  aes(x = sexo, y = mean, fill = anio)
) +
  geom_col(position = position_dodge(width = 0.72), width = 0.62) +
  geom_text(
    aes(label = label_percent_intl(accuracy = 1)(mean)),
    position = position_dodge(width = 0.72),
    vjust = -0.45,
    size = 2.5,
    colour = "grey20"
  ) +
  scale_fill_manual(values = quantificador_colores) +
  scale_y_continuous(
    labels = label_percent_intl(accuracy = 1),
    limits = c(0, 0.46),
    expand = expansion(mult = c(0, 0.03))
  ) +
  labs(
    title = "Uno de cada tres ecuatorianos preferiría no tener\na un homosexual como vecino",
    subtitle = "Porcentaje de hombres y mujeres que preferirían no tener a un homosexual como vecino,\nWVS 2013 y 2018",
    x = NULL,
    y = "Porcentaje",
    fill = NULL,
    caption = "Fuente: Encuesta Mundial de Valores (WVS), 2013 y 2018. Cálculos de Alonso Quijano Ruiz para El Quantificador.\nLa WVS utiliza una muestra probabilística representativa de la población adulta residente en Ecuador."
  ) +
  theme_quantificador() +
  theme(
    legend.position = "top",
    legend.justification = "left",
    legend.title = element_blank(),
    legend.text = element_text(size = 7.5, colour = "grey20"),
    axis.line.x = element_line(colour = "grey60"),
    axis.ticks.x = element_blank()
  )

g_homo_vecinos_logo <- add_logo(
  g_homo_vecinos,
  x = 0.86,
  y = 0.08,
  width = 0.1,
  height = 0.1
)

ggsave(
  filename = "outputs/lgbtq_homo_vecinos.png",
  plot = g_homo_vecinos_logo,
  width = 6.4,
  height = 4.2,
  dpi = 320,
  bg = "white"
)

# ---- D081: Las parejas homosexuales son tan buenos padres como otras parejas ----

wvs_homo_padres$D081 <- factor(
  wvs_homo_padres$D081,
  levels = c(
    "Totalmente de acuerdo",
    "De acuerdo",
    "Indiferente",
    "En desacuerdo",
    "Totalmente en desacuerdo",
    "No sabe"
  )
)

g_homo_padres <- ggplot(
  wvs_homo_padres,
  aes(x = D081, y = porc)
) +
  geom_col(width = 0.66, fill = "#2A9D8F") +
  geom_text(
    aes(label = label_percent_intl(accuracy = 1)(porc)),
    hjust = -0.18,
    size = 2.5,
    colour = "grey20"
  ) +
  coord_flip(clip = "off") +
  scale_y_continuous(
    labels = label_percent_intl(accuracy = 1),
    limits = c(0, 0.4),
    expand = expansion(mult = c(0, 0.03))
  ) +
  labs(
    title = "La mayoría de ecuatorianos piensa que las parejas\nhomosexuales no deberían tener hijos",
    subtitle = "Respuesta a la afirmación \"Las parejas homosexuales son tan buenos padres\", WVS 2018",
    x = NULL,
    y = "Porcentaje",
    caption = "Fuente: Encuesta Mundial de Valores (WVS), 2018. Cálculos de Alonso Quijano Ruiz para El Quantificador.\nLa WVS utiliza una muestra probabilística representativa de la población adulta residente en Ecuador."
  ) +
  theme_quantificador() +
  theme(
    axis.line.y = element_blank(),
    axis.ticks.y = element_blank(),
    plot.margin = margin(6, 46, 6, 16)
  )

g_homo_padres_logo <- add_logo(
  g_homo_padres,
  x = 0.86,
  y = 0.08,
  width = 0.1,
  height = 0.1
)

ggsave(
  filename = "outputs/lgbtq_homo_padres.png",
  plot = g_homo_padres_logo,
  width = 6.4,
  height = 4.2,
  dpi = 320,
  bg = "white"
)
