---
layout: post
title: "Seminar 2 Activity"
subtitle: "Module 4 – Seminar 2"
date: 2026-02-13
categories: [Module 4 Visualising Data]
---

# Part 1

This project introduces the fundamentals of data visualisation in R using the ggplot2 ecosystem. 

The workflow is structured to ensure reproducibility and clarity: first, a setup script installs and loads all required packages, defines a consistent visual theme, and prepares the project folder structure. 
Then, subsequent scripts focus on building visualisations step by step, applying best practices for clean and informative graphics.

The goal of this work is to demonstrate not only how to create plots, but also how to organise a data science project in a structured and reusable way.

This script prepares the working environment and ensures that the project runs smoothly across different machines.

- Package management

A vector of required packages is defined (tidyverse, ggplot2, palmerpenguins, etc.). 
The script checks which packages are missing and installs them automatically. This ensures that all dependencies are available without manual intervention.

    packs <- c(
      "tidyverse",
      "palmerpenguins",
      "nycflights13",
      "gapminder",
      "ggrepel",
      "scales",
      "here"
    )
    
    to_install <- setdiff(packs, rownames(installed.packages()))
    if (length(to_install) > 0) install.packages(to_install)

- Loading libraries
Each package is loaded using library(), making its functions available for use throughout the project.

      # Load packages
      library(tidyverse)
      library(palmerpenguins)
      library(nycflights13)
      library(gapminder)
      library(ggrepel)
      library(scales)
      library(here)
  
- Folder creation
The script creates standard directories (data/ and figures/) using dir.create(). This helps maintain an organised project structure and separates raw data from outputs.

      # Create standard folders (safe if they already exist)
      dir.create(here::here("data"), showWarnings = FALSE, recursive = TRUE)
      dir.create(here::here("figures"), showWarnings = FALSE, recursive = TRUE)
  
- Custom theme definition
A reusable function theme_house() is defined. This function customises plot appearance using ggplot2::theme_minimal() and additional styling (e.g., bold titles, bottom legend, simplified grid).
This ensures visual consistency across all plots in the project.


      # Define a lightweight reusable theme
      theme_house <- function() {
        ggplot2::theme_minimal(base_size = 12) +
          ggplot2::theme(
            plot.title.position = "plot",
            plot.title = ggplot2::element_text(face = "bold"),
            legend.position = "bottom",
            panel.grid.minor = ggplot2::element_blank()
          )
      }
  
      message("Setup complete. theme_house() is available.")

# Part 2 

This script demonstrates core data visualisation techniques in R using the ggplot2 framework (part of the tidyverse). 
It builds progressively from simple scatterplots to more advanced visualisations, including faceting, aesthetic mappings, distributions, and transformations. 
The workflow highlights best practices such as code modularity, reusable themes, and exporting high-quality figures.

The dataset used includes mpg (fuel efficiency data) and penguins (biological measurements), allowing for exploration of both continuous and categorical variables.

# --- Task A: mpg scatter, trend, facet
    pA <- ggplot(mpg, aes(displ, hwy)) +
      geom_point() +
      labs(
        title = "Engine size vs highway mpg",
        x = "Displacement (L)",
        y = "Highway MPG"
      ) +
      theme_house()
    
    pA
<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/097818ea-43dc-49d3-8dcc-1a8530f2470c" />

Visualises the relationship between engine size (displ) and highway fuel efficiency (hwy).
This introduces the core ggplot structure: data + aesthetics + geometry.

    pA_color <- ggplot(mpg, aes(displ, hwy, color = class)) +
      geom_point(alpha = 0.7) +
      geom_smooth(se = FALSE, linewidth = 0.8) +
      labs(
        title = "Bigger engines → lower MPG, with variation by class",
        color = "Class"
      ) +
      theme_house()
    
    pA_color

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/375eb853-21b1-42fb-bfe8-a7fdd8736f81" />


Enhanced scatterplot (pA_color) adds colour mapping (class) to distinguish vehicle types, transparency (alpha) to reduce overplotting, and a trend line (geom_smooth()) to highlight the overall relationship

    pA_facet <- pA_color +
      facet_wrap(~ drv) +
      labs(subtitle = "Faceted by drivetrain (f = front, r = rear, 4 = 4WD)")
    
    pA_facet

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/1d0aaca9-73d2-4bac-a578-1c7e5e1d3a6a" />

Uses facet_wrap(~ drv) to split the data by drivetrain type, enabling comparison across subgroups.

# --- Task B: scales & guides
    pB <- ggplot(mpg, aes(displ, hwy, color = class)) +
      geom_point(alpha = 0.7) +
      geom_smooth(se = FALSE) +
      scale_x_continuous(n.breaks = 6) +
      scale_y_continuous(n.breaks = 6) +
      scale_color_brewer(palette = "Set2") +
      guides(color = guide_legend(ncol = 2)) +
      labs(
        title = "Encoding class with a discrete palette",
        caption = "Source: ggplot2::mpg"
      ) +
      theme_house()
    
    pB

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/1383566b-2617-432b-a21c-bbcf3015b5e2" />

This section refines the visual encoding scale_x_continuous() and scale_y_continuous() control axis tick marks while scale_color_brewer() applies a predefined colour palette for better readability. Guides() customise the legend layout (e.g., two columns)

# ---  Task C: Multivariable Encoding (Penguins Dataset)

    pC <- ggplot(
      peng,
      aes(
        bill_length_mm,
        bill_depth_mm,
        color = species,
        shape = sex
      )
    ) +
      geom_point(size = 2, alpha = 0.8) +
      facet_wrap(~ island) +
      scale_color_brewer(palette = "Dark2") +
      labs(
        title = "Bill morphology by species, island, and sex",
        x = "Bill length (mm)",
        y = "Bill depth (mm)"
      ) +
      theme_house()
    
    pC

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/a83d5f9d-57a7-40e8-938d-a11302aa03b2" />

This demonstrates how multiple variables can be encoded simultaneously to reveal complex patterns in the data.

# --- Task D: Distributions
    pD_hist <- ggplot(peng, aes(flipper_length_mm, fill = species)) +
      geom_histogram(position = "identity", alpha = 0.5, bins = 25) +
      theme_house() +
      labs(title = "Flipper length — histogram")
    
    pD_hist

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/01362058-d09a-41a0-a4fc-7a15230b63ef" />

Histogram (pD_hist) shows the frequency distribution of flipper length

    pD_dens <- ggplot(peng, aes(flipper_length_mm, fill = species)) +
      geom_density(alpha = 0.4) +
      theme_house() +
      labs(title = "Flipper length — density")
    
    pD_dens

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/10983306-14e6-4513-b04d-cebad9b644a9" />

Density plot (pD_dens) provides a smoothed version of the distribution

    pD_box <- ggplot(peng, aes(species, body_mass_g, fill = species)) +
      geom_boxplot(width = 0.6, outlier.alpha = 0.5) +
      theme_house() +
      labs(title = "Body mass — boxplot")
    
    pD_box

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/23641ed5-6da2-4d5f-b7c4-d8c707cac89d" />

Boxplot (pD_box) summarises the distribution using quartiles and highlights outliers

    pD_violin <- ggplot(peng, aes(species, body_mass_g, fill = species)) +
      geom_violin(trim = FALSE) +
      stat_summary(fun = median, geom = "point", size = 2, color = "black") +
      theme_house() +
      labs(title = "Body mass — violin with median")
    
    pD_violin

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/9af60656-76f4-4822-bf0c-c785c57c61bf" />

Violin plot (pD_violin) combines density and distribution shape, with median overlay

# --- Task E: Transformations & cropping

    pE1 <- ggplot(peng, aes(body_mass_g, bill_length_mm)) +
      geom_point(alpha = 0.7) +
      theme_house() +
      labs(title = "Raw scale")
    
    pE1
    
  <img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/765bb19c-0ae3-4686-9bc3-efadafa1d435" />

Baseline scatterplot of body mass vs bill length

    pE2 <- pE1 + scale_x_log10() + labs(title = "Log10 X scale (body mass)")
    
    pE2
    
 <img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/d14f11af-893c-44bb-b160-192cbdab8ff0" />

 Applies scale_x_log10() to better visualise skewed data
 
    pE3 <- pE1 + coord_cartesian(ylim = c(30, 60)) + labs(title = "Cropped Y (cartesian)")

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/60ca388e-d10d-4a06-8036-8a2b827fa4e1" />

    pE3    

Uses coord_cartesian() to zoom into a specific y-range without removing data

# Reflection

This project highlights how effective data visualisation is not only about producing plots, but about structuring analysis in a clear and reproducible way. 

As the exercises progress, the transition from simple scatterplots to more complex visualisations shows how additional layers of information can be incorporated without overwhelming the viewer, provided that aesthetic mappings and layout choices are used carefully. 
Techniques such as faceting, scaling, and transformation reveal how the same data can tell different stories depending on how it is represented. This underlines the importance of making deliberate choices rather than relying on default settings.

Overall, this work reflects a growing awareness of visualisation as both a technical and interpretative process. It is not just about applying functions correctly, but about understanding how visual decisions influence interpretation.
Developing this awareness is essential for producing graphics that are not only accurate but also meaningful and accessible.
