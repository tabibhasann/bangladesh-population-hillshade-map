# ============================================================================
# PACKAGE REQUIREMENTS FOR BANGLADESH HILLSHADE POPULATION MAP
# ============================================================================
# Install required R packages for running the Bangladesh map generation script
# 
# Author: Tabib Hasan
# Date: 2025
# ============================================================================

# Set CRAN mirror and timeout for reliable package installation
options(repos = c(CRAN = "https://cran.rstudio.com/"))
options(timeout = 300)

# Function to install and load packages
install_and_load <- function(packages) {
  # Install pacman if not already installed
  if (!require("pacman", character.only = TRUE)) {
    install.packages("pacman")
    library(pacman)
  }
  
  # Use pacman to install and load packages
  pacman::p_load(char = packages)
}

# Required packages
required_packages <- c(
  "terra",        # Spatial raster data manipulation
  "elevatr",      # Download elevation data from AWS Terrain Tiles
  "tidyverse",    # Data manipulation and visualization
  "ggnewscale",   # Multiple fill and colour scales in ggplot2
  "ggspatial",    # Spatial annotations (north arrow, scale bar)
  "geodata",      # Administrative boundaries (GADM)
  "sf",           # Simple features for R
  "scales"        # Scale functions for visualization
)

# Display system information
cat("====================================\n")
cat("BANGLADESH MAP REQUIREMENTS INSTALLER\n")
cat("====================================\n\n")

cat("R Version:", R.version.string, "\n")
cat("Platform:", .Platform$OS.type, "\n\n")

# Install required packages
cat("Installing required packages...\n\n")

tryCatch({
  install_and_load(required_packages)
  cat("✅ All packages installed successfully!\n\n")
}, error = function(e) {
  cat("❌ Error installing packages:", e$message, "\n")
  cat("Please try installing packages manually:\n")
  cat("install.packages(c('terra', 'elevatr', 'tidyverse', 'ggnewscale', 'ggspatial', 'geodata', 'sf', 'scales'))\n")
})

# Verify installations
cat("Verifying package installations...\n")
for(pkg in required_packages) {
  if(require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat("✅", pkg, "- OK\n")
  } else {
    cat("❌", pkg, "- FAILED\n")
  }
}

cat("\n====================================\n")
cat("SYSTEM REQUIREMENTS CHECK\n")
cat("====================================\n\n")

# Check for potential issues
cat("Recommended system specifications:\n")
cat("• RAM: 4GB+ (8GB recommended)\n")
cat("• Storage: 2GB free space\n")
cat("• Internet: Required for data download\n")
cat("• R Version: 4.0+ recommended\n\n")

# Check R version
r_version <- as.numeric(paste0(R.version$major, ".", R.version$minor))
if(r_version >= 4.0) {
  cat("✅ R version is compatible\n")
} else {
  cat("⚠️  R version may be outdated. Consider upgrading to R 4.0+\n")
}

# Check available memory (approximate)
cat("💾 Memory check:\n")
if(memory.size() > 4000) {  # Windows
  cat("✅ Sufficient memory available\n")
} else {
  cat("⚠️  Low memory detected. Close other applications if needed\n")
}

cat("\n====================================\n")
cat("READY TO RUN!\n")
cat("====================================\n\n")

cat("You can now run the main script:\n")
cat("source('generate_bangladesh_map.R')\n\n")

cat("Expected runtime: 3-4 minutes\n")
cat("Output: output/bangladesh_population_relief.png\n")