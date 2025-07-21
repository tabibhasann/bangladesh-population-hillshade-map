# 🇧🇩 Bangladesh Population Hillshade Map

> High-resolution terrain and population density visualization of Bangladesh featuring the world's largest river delta system

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![R](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)](https://www.r-project.org/)
[![WorldPop](https://img.shields.io/badge/Data-WorldPop-orange)](https://www.worldpop.org/)

## 🌟 Overview

This project generates a stunning high-resolution hillshade population density map of Bangladesh, showcasing:

- **🏞️ Ganges-Brahmaputra-Meghna Delta** - The world's largest river delta system
- **🏔️ Chittagong Hill Tracts** - Bangladesh's most mountainous region  
- **🌆 Major Urban Centers** - Dhaka (9M+), Chittagong, Sylhet, Rajshahi, Khulna
- **🌊 Complex River Networks** - Hundreds of rivers and waterways
- **📊 Population Density** - One of the world's highest at 1,265 people/km²

## 🖼️ Sample Output

![Bangladesh Population Hillshade Map](output/bangladesh_population_relief.png)

*A 4000x4000px visualization combining terrain relief with population density using plasma color mapping*

## 🛠️ Technical Specifications

| Feature | Details |
|---------|---------|
| **Resolution** | 4000×4000px @ 600 DPI |
| **Population Data** | WorldPop 2020 (100m constrained grid) |
| **Elevation Data** | SRTM via elevatr (30m resolution) |
| **Coordinate System** | Geographic WGS84 |
| **Processing** | Multi-directional hillshade with 2× exaggeration |
| **Color Scheme** | Viridis Plasma palette for population contrast |

## 🚀 Quick Start

### Prerequisites

```r
# Required R packages
install.packages(c(
  "terra", "elevatr", "tidyverse",
  "ggnewscale", "ggspatial", 
  "geodata", "sf", "scales"
))
```

### Running the Script

1. **Clone the repository**
   ```bash
   git clone https://github.com/tabibhasann/bangladesh-population-hillshade-map.git
   cd bangladesh-population-hillshade-map
   ```

2. **Run the R script**
   ```r
   source("generate_bangladesh_map.R")
   ```

3. **Find your output**
   ```
   output/bangladesh_population_relief.png
   ```

### ⏱️ Runtime
- **Estimated time**: 3-4 minutes
- **Memory usage**: ~2-3GB RAM recommended
- **Internet required**: Yes (for downloading WorldPop and elevation data)

## 📁 Project Structure

```
bangladesh-population-hillshade-map/
├── 📄 README.md                          # This file
├── 🔧 generate_bangladesh_map.R           # Main R script
├── 📂 output/                            # Generated maps
│   └── 🖼️ bangladesh_population_relief.png
├── 📄 LICENSE                            # MIT License
└── 📄 requirements.R                     # Package dependencies
```

## 🌍 Geographic Highlights

### Key Regions Visualized

- **🏙️ Dhaka Division**: Mega-urban agglomeration (20M+ metro area)
- **🚢 Chittagong Division**: Major port city and hill tracts
- **🌾 Rajshahi Division**: Agricultural heartland
- **🐅 Khulna Division**: Sundarbans mangrove forests
- **☂️ Sylhet Division**: Tea gardens and wetlands
- **🏛️ Rangpur Division**: Northern plains
- **🌊 Barisal Division**: River delta region
- **🎯 Mymensingh Division**: Central agricultural zone

### Topographic Features

- **Elevation Range**: Sea level to 1,064m (Keokradong Peak)
- **Average Elevation**: 85 meters
- **Delta Area**: 80% of country below 10m elevation
- **River Count**: 700+ rivers and tributaries

## 📊 Data Sources

| Dataset | Source | Resolution | Year |
|---------|--------|------------|------|
| Population | [WorldPop](https://www.worldpop.org/) | 100m | 2020 |
| Elevation | SRTM via [elevatr](https://github.com/jhollist/elevatr) | 30m | 2000 |
| Boundaries | [GADM](https://gadm.org/) | Country/Admin | 2022 |

## 🎨 Customization Options

### Color Schemes
```r
# Alternative color palettes
scale_fill_viridis_c(option = "magma")    # Purple-yellow
scale_fill_viridis_c(option = "inferno")  # Black-red-yellow  
scale_fill_viridis_c(option = "cividis")  # Colorblind-friendly
```

### Resolution Adjustments
```r
# Higher resolution (longer processing)
dem <- elevatr::get_elev_raster(country_sf, z = 9)

# Lower resolution (faster processing) 
dem <- elevatr::get_elev_raster(country_sf, z = 7)
```

### Export Formats
```r
# Vector format
ggsave("map.pdf", width = 10, height = 7)

# Web format
ggsave("map.jpg", width = 10, height = 7, dpi = 300)
```

## 🎯 Use Cases

### Academic & Research
- **Demographics Studies**: Population distribution analysis
- **Urban Planning**: Mega-city growth patterns
- **Climate Research**: Sea level rise vulnerability
- **Geographic Education**: South Asian geography

### Professional Applications  
- **NGO Work**: Development and aid planning
- **Government**: Policy visualization
- **Media**: Editorial and journalistic content
- **Tourism**: Geographic awareness campaigns

## 🤝 Contributing

Contributions are welcome! Here are some ideas:

- 🗓️ **Temporal Analysis**: Add multi-year population trends
- 🌡️ **Climate Data**: Integrate temperature/precipitation layers  
- 🚗 **Infrastructure**: Add roads, railways, airports
- 🏭 **Economic Data**: Include industrial zones, GDP per capita
- 🌊 **Flood Risk**: Incorporate flood zone mapping

### How to Contribute

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **[WorldPop](https://www.worldpop.org/)** - Population density data
- **[NASA SRTM](https://www2.jpl.nasa.gov/srtm/)** - Elevation data via elevatr
- **[GADM](https://gadm.org/)** - Administrative boundaries  
- **[R Spatial Community](https://r-spatial.org/)** - Amazing spatial analysis tools

## 📧 Contact

**Tabib Hasan** - [@tabibhasann](https://github.com/tabibhasann)

Project Link: [https://github.com/tabibhasann/bangladesh-population-hillshade-map](https://github.com/tabibhasann/bangladesh-population-hillshade-map)

---

⭐ **Star this repository if you found it helpful!**

*Made with ❤️ for geographic visualization and Bangladesh's incredible landscape*