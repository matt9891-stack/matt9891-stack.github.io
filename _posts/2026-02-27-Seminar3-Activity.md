---
layout: post
title: "Seminar 3 Activity"
subtitle: "Module 4 – Seminar 3 - Cleaning Organising Data"
date: 2026-02-27
categories: [Module 4 Visualising Data]
---

This mini-project demonstrates a complete and structured workflow for handling data in R, moving from initial data loading to cleaning, transformation, and exporting results. 
The process is applied to the Gapminder dataset, which provides information on global development indicators across countries and years.

The dataset is loaded directly from the gapminder package using gapminder <- data. This represents a common scenario in data science where data is imported from an external library or source.

    data <- gapminder
    
    data

To understand the structure of the dataset, functions such as glimpse() and summary() are used. These provide an overview of variable types, missing values, and the general distribution of the data, which is essential before any analysis is performed.

    # Quick inspection
    glimpse(data)
    summary(data)

    > glimpse(data)
    Rows: 1,704
    Columns: 6
    $ country   <fct> "Afghanistan", "Afghanistan", "Afghanistan", "Afghanistan", "Afghanistan", "Afghanist…
    $ continent <fct> Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Europe, Europ…
    $ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992, 1997, 2002, 2007, 1952, 1957, 1…
    $ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.854, 40.822, 41.674, 41.763, 42.12…
    $ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 14880372, 12881816, 13867957, 1631792…
    $ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 786.1134, 978.0114, 852.3959, 649.3…
    > summary(data)
            country        continent        year         lifeExp           pop              gdpPercap       
     Afghanistan:  12   Africa  :624   Min.   :1952   Min.   :23.60   Min.   :6.001e+04   Min.   :   241.2  
     Albania    :  12   Americas:300   1st Qu.:1966   1st Qu.:48.20   1st Qu.:2.794e+06   1st Qu.:  1202.1  
     Algeria    :  12   Asia    :396   Median :1980   Median :60.71   Median :7.024e+06   Median :  3531.8  
     Angola     :  12   Europe  :360   Mean   :1980   Mean   :59.47   Mean   :2.960e+07   Mean   :  7215.3  
     Argentina  :  12   Oceania : 24   3rd Qu.:1993   3rd Qu.:70.85   3rd Qu.:1.959e+07   3rd Qu.:  9325.5  
     Australia  :  12                  Max.   :2007   Max.   :82.60   Max.   :1.319e+09   Max.   :113523.1  
     (Other)    :1632  

The dataset is already in a tidy format, meaning each row corresponds to a single observation (a country-year combination), and each column represents a variable.
To prepare the data for analysis, a filtered version is created by selecting only observations from 1990 onwards. 
Additionally, only relevant variables are retained (country, continent, year, lifeExp, gdpPercap, and pop). This step reduces complexity and ensures that the dataset is focused on the analytical goal.

     data_tidy <- data |>
      filter(year >= 1990) |>
      select(country, continent, year, lifeExp, gdpPercap, pop)
    
    data_tidy

    > data_tidy
    # A tibble: 568 × 6
       country     continent  year lifeExp gdpPercap      pop
       <fct>       <fct>     <int>   <dbl>     <dbl>    <int>
     1 Afghanistan Asia       1992    41.7      649. 16317921
     2 Afghanistan Asia       1997    41.8      635. 22227415
     3 Afghanistan Asia       2002    42.1      727. 25268405
     4 Afghanistan Asia       2007    43.8      975. 31889923
     5 Albania     Europe     1992    71.6     2497.  3326498
     6 Albania     Europe     1997    73.0     3193.  3428038
     7 Albania     Europe     2002    75.7     4604.  3508512
     8 Albania     Europe     2007    76.4     5937.  3600523
     9 Algeria     Africa     1992    67.7     5023. 26298373
    10 Algeria     Africa     1997    69.2     4797. 29072015

The next step involves summarising the data at a higher level. The dataset is grouped by country and continent, and summary statistics are calculated, including mean life expectancy, mean GDP per capita, and total population.

    # Create summary statistics per country
    country_summary <- data_tidy |>
      group_by(country, continent) |>
      summarise(
        mean_lifeExp = mean(lifeExp),
        mean_gdp = mean(gdpPercap),
        total_pop = sum(pop),
        .groups = "drop"
      ) |>
      arrange(desc(mean_lifeExp))
    
    # View result
    country_summary

   <img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/d07f4941-7511-4d82-943b-5855248e07da" />

   This transformation shifts the analysis from individual observations to aggregated insights, making it easier to compare countries and identify broader patterns across regions.

This step is crucial in real-world workflows, as it allows the results to be stored, shared, and reused independently of the R environment. It also ensures that the processing pipeline produces tangible outputs that can be used in future analysis or reporting.

       # Save cleaned dataset
    write_csv(data_tidy, "gapminder_tidy.csv")
    
    # Save summary dataset
    write_csv(country_summary, "gapminder_summary.csv")

# Conclusion

This project illustrates the essential stages of a data workflow: importing data, organising it into a usable structure, transforming it into meaningful summaries, and exporting the results. Each step contributes to building a clear and reproducible analysis pipeline.

By following this structured approach, the data becomes easier to understand, manipulate, and communicate. It also reflects good data science practice, where clarity, reproducibility, and organisation are as important as the analysis itself.
 
