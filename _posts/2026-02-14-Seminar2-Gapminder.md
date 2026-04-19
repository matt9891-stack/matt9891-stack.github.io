---
layout: post
title: "Seminar 2 Activity"
subtitle: "Module 4 – Seminar 2 Gapminder"
date: 2026-02-13
categories: [Module 4 Visualising Data]
---

This script uses the Gapminder dataset to explore global development patterns over time, focusing on the relationship between income, life expectancy, and population. 
The analysis extends beyond simple comparisons by introducing small multiples, logarithmic scaling, and uncertainty visualisation, allowing for a more nuanced interpretation of global inequalities and long-term trends.

    latest <- gapminder |> filter(year == 2007)

The dataset is filtered to include only the year 2007, providing a snapshot of global development at a single point in time.

    pH1 <- ggplot(latest, aes(gdpPercap, lifeExp, size = pop, color = continent)) +
      geom_point(alpha = 0.7) +
      scale_x_log10(labels = scales::label_number_si()) +
      scale_size_continuous(labels = scales::label_number_si()) +
      labs(
        title = "Income vs Life Expectancy (2007)",
        x = "GDP per capita (log scale)",
        y = "Life expectancy",
        size = "Population"
      ) +
      theme_house()
    
    pH1

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/198330c4-008b-44d0-b736-fda30c25ba23" />

The use of a logarithmic scale for GDP is essential, as it allows countries with large income differences to be compared on a more interpretable scale. The result is a compact but information-rich view of global inequality and development patterns.

    with_decade <- gapminder |> mutate(decade = floor(year / 10) * 10)

A new variable is created by grouping years into decades, enabling a broader temporal perspective.

    pH2 <- ggplot(with_decade, aes(gdpPercap, lifeExp, size = pop, color = continent)) +
      geom_point(alpha = 0.5) +
      scale_x_log10(labels = scales::label_number_si()) +
      facet_wrap(~ decade) +
      labs(title = "Convergence patterns across decades") +
      theme_house()
    
    pH2

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/be7c8ff7-4a50-4223-aa51-90f2f9cf52d0" />

The same visual structure is repeated, but now separated by decade using facet_wrap(). 
This reveals how the relationship between income and life expectancy evolves, making it easier to observe convergence patterns across countries.

    cont_summ <- gapminder |>
      group_by(continent, year) |>
      summarise(mean = mean(lifeExp), sd = sd(lifeExp), .groups = "drop")
    
    cont_summ

    cont_summ
    # A tibble: 60 × 4
       continent  year  mean    sd
       <fct>     <int> <dbl> <dbl>
     1 Africa     1952  39.1  5.15
     2 Africa     1957  41.3  5.62
     3 Africa     1962  43.3  5.88
     4 Africa     1967  45.3  6.08
     5 Africa     1972  47.5  6.42
     6 Africa     1977  49.6  6.81
     7 Africa     1982  51.6  7.38
     8 Africa     1987  53.3  7.86
     9 Africa     1992  53.6  9.46
    10 Africa     1997  53.6  9.10

    pI <- ggplot(cont_summ, aes(year, mean, color = continent, fill = continent)) +
      geom_ribbon(aes(ymin = mean - sd, ymax = mean + sd), alpha = 0.2, color = NA) +
      geom_line(linewidth = 0.8) +
      labs(
        title = "Life expectancy uncertainty bands by continent",
        y = "Mean ± SD"
      ) +
      theme_house()
    
    pI

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/aef24a67-bae8-4fca-81d7-38d83fb4d044" />

This dual representation highlights both the overall trajectory and the variability within each continent, providing a more honest depiction of global differences.

# Reflection

This analysis illustrates how visualisation can move beyond static comparisons to tell a more dynamic and layered story about global development. The use of log scales, faceting, and uncertainty bands allows complex relationships to be communicated in a way that remains interpretable while preserving important detail.

A key insight from this section is that global averages alone can be misleading without considering variability. By introducing measures of dispersion alongside mean trends, the analysis acknowledges that development is not uniform within regions but shaped by internal diversity.

Overall, this work shows how thoughtful visualisation design can transform raw data into meaningful narratives. It reinforces the idea that effective data storytelling requires not only technical implementation but also careful consideration of scale, context, and uncertainty.
