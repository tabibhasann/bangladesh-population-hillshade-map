# ============================================================================
# BANGLADESH HILLSHADE POPULATION MAP
# ============================================================================
# High-resolution hillshade population density visualization
# Featuring Ganges-Brahmaputra-Meghna Delta, Chittagong Hill Tracts, and Sylhet Hills
# 
# Author: Tabib Hasan
# Date: 2025
# Resolution: 4000x4000px @ 600 DPI
# ============================================================================

# –– libraries
# Set CRAN mirror to avoid installation error
options(repos = c(CRAN = "https://cran.rstudio.com/"))
options(timeout = 300)  # Increase timeout for downloads

if (!require("pacman")) install.packages("pacman")
pacman::p_load(
    terra, elevatr, tidyverse,
    ggnewscale, ggspatial,
    geodata, sf, scales
)

cat("Starting Bangladesh hillshade population map...\n")

# Create output directory
if (!dir.exists("output")) {
  dir.create("output", recursive = TRUE)
}

# ── 1) Bangladesh boundary ───
cat("Loading Bangladesh administrative boundaries...\n")
country_sf <- geodata::gadm(
    country = "BGD", level = 0,
    path = tempdir()
) |> sf::st_as_sf()

# Fix geometry issues
country_sf <- sf::st_make_valid(country_sf)
country_sf <- sf::st_cast(country_sf, "MULTIPOLYGON")

country_vect <- terra::vect(country_sf)

# ── 2) WorldPop 100m population count 2020 ──
cat("Loading WorldPop population data for Bangladesh...\n")
# Try with retry logic for network issues
pop_100m <- NULL
for(i in 1:3) {
  tryCatch({
    pop_100m <- terra::rast(
        "https://data.worldpop.org/GIS/Population/Global_2000_2020_Constrained/2020/BSGM/BGD/bgd_ppp_2020_UNadj_constrained.tif"
    )
    break
  }, error = function(e) {
    cat("Attempt", i, "failed, retrying...\n")
    Sys.sleep(5)
  })
}

if(is.null(pop_100m)) {
  stop("Failed to download population data after 3 attempts")
}

# ── 3) DEM & hill-shade on finer (~30 m) grid ──
cat("Generating Digital Elevation Model and hillshade...\n")
dem <- elevatr::get_elev_raster(
    country_sf,
    z = 8, clip = "locations"  # Good resolution for Bangladesh
)

dem_country <- terra::rast(dem) |>
    terra::crop(country_vect) |>
    terra::mask(country_vect)

# exaggerate the DEM for Bangladesh's flat terrain ---------
dem_exaggerated <- dem_country * 2.0  # Higher exaggeration for flat delta

# shaded relief ---------
slope <- terra::terrain(
    dem_exaggerated,
    v = "slope", unit = "radians"
)

aspect <- terra::terrain(
    dem_exaggerated,
    v = "aspect",
    unit = "radians"
)

hillshade_raw <- terra::shade(
    slope, aspect,
    angle = 40, direction = 225
)

# ── 4) resample pop onto the hill-shade grid,
# ── then blank relief where pop exists

cat("Processing population and hillshade data...\n")
pop_on_hillshade <- terra::resample(
    pop_100m, hillshade_raw,
    method = "bilinear" # method
)

hillshade_no_pop <- terra::ifel(
    is.na(pop_on_hillshade), hillshade_raw,
    NA
)

# ── 5) data frames for ggplot
# ── (NA rows dropped automatically) ──

cat("Converting to data frames for visualization...\n")
hillshade_df <- terra::as.data.frame(
    hillshade_no_pop,
    xy = TRUE,
    na.rm = TRUE
)

pop_df <- terra::as.data.frame(
    pop_on_hillshade,
    xy = TRUE, na.rm = TRUE
)

# Fix column name issue - get the actual column name
col_name <- names(pop_df)[3]  # Third column should be population data
pop_df[[col_name]][pop_df[[col_name]] <= 0.1] <- NA

# ── 6) plot ──
cat("Creating the final map...\n")
## legend breaks once, so we can reuse them
brks <- c(1, 10, 100, 1e3, 1e4)

# a) hill-shade
p <- ggplot() +
    geom_raster(data = hillshade_df, aes(
        x, y,
        fill = .data[[names(hillshade_df)[3]]]
    )) +
    scale_fill_gradient(
        low = "grey70", high = "grey10",
        guide = "none"
    ) +
    # 2) population layer
    ggnewscale::new_scale_fill() +
    geom_raster(data = pop_df, aes(
        x, y,
        fill = .data[[col_name]]
    )) +
    scale_fill_viridis_c(
        name = "Population",
        option = "plasma",
        alpha = 1, begin = .2, end = 1,
        trans = "log10", breaks = brks,
        labels = scales::comma,
        guide = guide_colourbar(
            title.position = "top",
            barheight = unit(15, "mm"),
            barwidth = unit(1.5, "mm"),
            ticks.color = "grey10",
            frame.colour = "grey10"
        )
    ) +
    # 3) country boundaries
    geom_sf(
        data = country_sf, fill = NA,
        color = "black", linewidth = .25
    ) +
    # 4) cartographic extras - BANGLADESH OPTIMIZED PLACEMENT
    ggspatial::annotation_north_arrow(
        location = "tr", which_north = "true",
        height = unit(15, "mm"),
        width = unit(15, "mm"),
        pad_x = unit(20, "mm"),
        pad_y = unit(20, "mm"),
        style = ggspatial::north_arrow_fancy_orienteering
    ) +
    ggspatial::annotation_scale(
        location = "bl", 
        pad_x = unit(20, "mm"),
        pad_y = unit(20, "mm"),
        height = unit(4, "mm")
    ) +
    coord_sf(expand = FALSE) +
    # 5) typography & layout
    labs(
        title = "Bangladesh · Population (2020)",
        subtitle = "WorldPop 100m constrained grid - Ganges-Brahmaputra-Meghna Delta",
        caption = "Data: WorldPop · SRTM via elevatr | © Tabib Hasan"
    ) +
    theme(
        plot.title = element_text(
            size = 16, face = "bold", hjust = .02
        ),
        plot.subtitle = element_text(
            size = 14, hjust = .02
        ),
        plot.caption = element_text(
            hjust = .5, size = 10
        ),
        legend.title = element_text(
            size = 12
        ),
        legend.text = element_text(
            size = 11
        ),
        legend.position = "right",
        legend.margin = margin(
            t = 0, r = 5, b = 0, l = 5
        ),
        plot.margin = margin(
            t = 10, r = 10, b = 10, l = 10
        )
    ) +
    theme_void()

# Display the plot
print(p)

# save
cat("Saving the final map...\n")
ggsave(
    "output/bangladesh_population_relief.png",
    width = 10, height = 7, dpi = 600,
    bg = "white", p
)

cat("Map saved as 'output/bangladesh_population_relief.png'\n")
cat("Bangladesh script completed successfully!\n")