# Contributing to Bangladesh Population Hillshade Map

Thank you for your interest in contributing to this project! We welcome contributions from the community.

## 🚀 Ways to Contribute

### 1. Code Improvements
- **Performance optimizations** for faster processing
- **Code refactoring** for better readability
- **Error handling** improvements
- **Memory usage** optimizations

### 2. Feature Enhancements
- **Multi-temporal analysis** (comparing different years)
- **Additional data layers** (roads, railways, economic zones)
- **Interactive visualizations** (Shiny apps, leaflet maps)
- **Alternative color schemes** and styling options
- **Batch processing** for multiple countries

### 3. Documentation
- **Tutorial improvements** and clearer instructions
- **Code comments** and inline documentation
- **Example outputs** and use cases
- **Troubleshooting guides** for common issues

### 4. Data Sources
- **Alternative population datasets** (LandScan, GPW)
- **Higher resolution elevation data** 
- **Administrative boundary updates**
- **Climate and environmental layers**

## 🛠️ Development Setup

### Prerequisites
```r
# Install development tools
install.packages(c("devtools", "roxygen2", "testthat"))

# Install spatial packages
install.packages(c("terra", "sf", "elevatr", "geodata"))

# Install visualization packages  
install.packages(c("ggplot2", "ggnewscale", "ggspatial"))
```

### Getting Started
1. **Fork** the repository
2. **Clone** your fork locally
   ```bash
   git clone https://github.com/YOUR_USERNAME/bangladesh-population-hillshade-map.git
   cd bangladesh-population-hillshade-map
   ```
3. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
4. **Make your changes**
5. **Test thoroughly**
6. **Commit with descriptive messages**
   ```bash
   git commit -m "feat: add multi-year comparison functionality"
   ```

## 📝 Coding Standards

### R Style Guide
- Follow [Tidyverse Style Guide](https://style.tidyverse.org/)
- Use meaningful variable names
- Include comments for complex operations
- Keep functions focused and modular

### Example Code Style
```r
# Good: Clear variable names and comments
population_density_df <- terra::as.data.frame(
    population_raster,
    xy = TRUE,
    na.rm = TRUE  # Remove NA values for cleaner visualization
)

# Good: Proper spacing and indentation
create_hillshade <- function(elevation_raster, 
                           angle = 40, 
                           direction = 225) {
    slope <- terra::terrain(elevation_raster, v = "slope", unit = "radians")
    aspect <- terra::terrain(elevation_raster, v = "aspect", unit = "radians")
    return(terra::shade(slope, aspect, angle = angle, direction = direction))
}
```

## 🧪 Testing

### Before Submitting
1. **Run the complete script** to ensure it works end-to-end
2. **Test with different parameters** (resolution, color schemes)
3. **Check memory usage** with larger datasets
4. **Verify output quality** and correctness

### Test Checklist
- [ ] Script runs without errors
- [ ] Output files are generated correctly
- [ ] Memory usage is reasonable
- [ ] Processing time is acceptable
- [ ] Visual output looks correct

## 📋 Pull Request Process

### Before Creating a PR
1. **Update documentation** if needed
2. **Add examples** for new features
3. **Test on different systems** if possible
4. **Update README** if functionality changes

### PR Template
When creating a pull request, please include:

**Description**
- Brief summary of changes
- Motivation for the changes
- Any breaking changes

**Testing**
- How you tested the changes
- Screenshots of new output (if applicable)
- Performance comparisons (if relevant)

**Checklist**
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tested on sample data

## 🐛 Reporting Issues

### Bug Reports
When reporting bugs, please include:
- **R version** and platform (Windows/Mac/Linux)
- **Package versions** (use `sessionInfo()`)
- **Reproducible example** with sample data
- **Error messages** (full stack trace)
- **Expected vs actual behavior**

### Feature Requests
For new features, please describe:
- **Use case** and motivation
- **Proposed implementation** (if you have ideas)
- **Potential alternatives**
- **Additional context** or examples

## 🎨 Proposed Enhancements

### High Priority
- [ ] **Performance optimization** for large countries
- [ ] **Multi-year animation** capabilities
- [ ] **Interactive web version** using Shiny
- [ ] **Batch processing** for multiple countries

### Medium Priority
- [ ] **Alternative data sources** integration
- [ ] **Urban area highlighting** functionality
- [ ] **Climate zone overlays**
- [ ] **Economic indicator integration**

### Low Priority
- [ ] **3D visualization** options
- [ ] **Mobile-friendly output** formats
- [ ] **Social media templates**
- [ ] **Print-ready formats**

## 📚 Resources

### Learning Resources
- [R Spatial Community](https://r-spatial.org/)
- [Terra Package Documentation](https://rspatial.github.io/terra/)
- [ggplot2 Reference](https://ggplot2.tidyverse.org/)
- [Spatial Data Science with R](https://rspatial.org/raster/)

### Data Sources
- [WorldPop](https://www.worldpop.org/) - Population data
- [NASA SRTM](https://www2.jpl.nasa.gov/srtm/) - Elevation data
- [GADM](https://gadm.org/) - Administrative boundaries
- [Natural Earth](https://www.naturalearthdata.com/) - Geographic data

## 🤝 Community

### Getting Help
- **GitHub Issues** for bug reports and feature requests
- **Discussions** for questions and community interaction
- **Email** for private communication

### Code of Conduct
- Be respectful and inclusive
- Provide constructive feedback
- Help others learn and grow
- Follow community guidelines

## 🙏 Recognition

Contributors will be:
- **Listed in README** acknowledgments
- **Tagged in releases** when their contributions are included
- **Credited in documentation** for significant contributions

---

Thank you for helping make this project better! 🌟