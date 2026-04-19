---
layout: post
title: "Seminar 4 Activity EDA "
subtitle: "Module 4 – Seminar 4 EDA" 
date: 2026-03-01
categories: [Module 4 Visualising Data]
tags: [R,tidyverse,tidyr,ggplot]
---

This exploratory data analysis (EDA) follows the structured approach introduced in Chapter 10, focusing on understanding data through variation, covariation, and pattern discovery.

The dataset used is the Gapminder dataset, which contains information on countries over time, including life expectancy, GDP per capita, and population. The analysis begins by importing and inspecting the dataset to understand its structure and variable types.

    print(df.head())
    print(df.info())
    print(df.describe())

               country continent  year  lifeExp       pop   gdpPercap iso_alpha  \
    0  Afghanistan      Asia  1952   28.801   8425333  779.445314       AFG   
    1  Afghanistan      Asia  1957   30.332   9240934  820.853030       AFG   
    2  Afghanistan      Asia  1962   31.997  10267083  853.100710       AFG   
    3  Afghanistan      Asia  1967   34.020  11537966  836.197138       AFG   
    4  Afghanistan      Asia  1972   36.088  13079460  739.981106       AFG   
    
       iso_num  
    0        4  
    1        4  
    2        4  
    3        4  
    4        4  
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 1704 entries, 0 to 1703
    Data columns (total 8 columns):
     #   Column     Non-Null Count  Dtype  
    ---  ------     --------------  -----  
     0   country    1704 non-null   object 
     1   continent  1704 non-null   object 
     2   year       1704 non-null   int64  
     3   lifeExp    1704 non-null   float64
     4   pop        1704 non-null   int64  
     5   gdpPercap  1704 non-null   float64
     6   iso_alpha  1704 non-null   object 
    ...
    25%    1965.75000    48.198000  2.793664e+06    1202.060309   208.000000
    50%    1979.50000    60.712500  7.023596e+06    3531.846989   410.000000
    75%    1993.25000    70.845500  1.958522e+07    9325.462346   638.000000
    max    2007.00000    82.603000  1.318683e+09  113523.132900   894.000000

The dataset structure and type are inspected.

The data is filtered to include recent years (1990 onwards) and reduced to the most relevant variables for analysis. This step ensures the dataset is tidy and suitable for exploration.

    # Focus on recent years (similar to R filter(year >= 1990))
    df_tidy = df[df["year"] >= 1990].copy()
    
    # Select relevant variables
    df_tidy = df_tidy[["country", "continent", "year",
                       "lifeExp", "gdpPercap", "pop"]]
    
    print(df_tidy)

                  country continent  year  lifeExp    gdpPercap       pop
    8     Afghanistan      Asia  1992   41.674   649.341395  16317921
    9     Afghanistan      Asia  1997   41.763   635.341351  22227415
    10    Afghanistan      Asia  2002   42.129   726.734055  25268405
    11    Afghanistan      Asia  2007   43.828   974.580338  31889923
    20        Albania    Europe  1992   71.581  2497.437901   3326498
    ...           ...       ...   ...      ...          ...       ...
    1691       Zambia    Africa  2007   42.384  1271.211593  11746035
    1700     Zimbabwe    Africa  1992   60.377   693.420786  10704340
    1701     Zimbabwe    Africa  1997   46.809   792.449960  11404948
    1702     Zimbabwe    Africa  2002   39.989   672.038623  11926563
    1703     Zimbabwe    Africa  2007   43.487   469.709298  12311143

# Variation - The first stage of EDA explores how individual variables behave.

Life expectancy shows a wide but structured distribution across countries.

    # --- Life Expectancy distribution ---
    plt.figure()
    sns.histplot(df_tidy["lifeExp"], bins=30, kde=True)
    plt.title("Distribution of Life Expectancy")
    plt.show()

<img width="562" height="455" alt="image" src="https://github.com/user-attachments/assets/a79e43be-7836-4af9-ba52-83aab5a41868" />

GDP per capita is heavily right-skewed, meaning a small number of countries have very high values.

    # --- GDP per capita distribution (log scale helps) ---
    fig,axis = plt.subplots(1,2,figsize=(10,5))
    sns.histplot(df_tidy["gdpPercap"], bins=30,ax=axis[0])
    axis[0].set_title("Distribution of GDP per capita")
    sns.histplot(df_tidy["gdpPercap"], bins=30,ax=axis[1])
    axis[1].set_xscale("log")
    axis[1].set_title("Distribution of GDP per capita (log scale)")
    plt.show()

<img width="850" height="475" alt="image" src="https://github.com/user-attachments/assets/64e10f6f-b997-48fb-8ab0-6400a3ffa9a3" />

Population also shows strong skewness

    plt.figure()
    sns.histplot(df_tidy["pop"], bins=30)
    plt.title("Distribution of Population ")
    plt.show()

 <img width="571" height="455" alt="image" src="https://github.com/user-attachments/assets/ab18f8b5-eb73-46a2-ba77-f6f5292887a2" />

# Outliers

    # Detect extreme GDP values
    outliers = df_tidy[df_tidy["gdpPercap"] > df_tidy["gdpPercap"].quantile(0.99)]
    print(outliers.head())

            country continent  year  lifeExp    gdpPercap      pop
    863      Kuwait      Asia  2007   77.588  47306.98978  2505559
    1149     Norway    Europe  1997   78.320  41283.16433  4405672
    1150     Norway    Europe  2002   79.050  44683.97525  4535591
    1151     Norway    Europe  2007   80.196  49357.19017  4627926
    1367  Singapore      Asia  2007   79.972  47143.17964  4553009

Extreme GDP observations were identified using quantile-based filtering. These represent countries with exceptionally high economic output and highlight inequality in global development.
 
# Covariation

    # Life expectancy vs GDP per capita
    plt.figure()
    sns.scatterplot(data=df_tidy,
                    x="gdpPercap",
                    y="lifeExp",
                    hue="continent",
                    alpha=0.6)
    plt.xscale("log")
    plt.title("Life Expectancy vs GDP per Capita")
    plt.show()

<img width="562" height="459" alt="image" src="https://github.com/user-attachments/assets/c11c0c82-092c-4fa7-ac6e-a9a91680bd3b" />

The relationship between GDP per capita and life expectancy was explored using scatterplots with continent-based colouring. A strong positive relationship is observed: countries with higher GDP generally have higher life expectancy.

    # Trend lines 
    plt.figure()
    sns.lmplot(data=df_tidy,
               x="gdpPercap",
               y="lifeExp",
               hue="continent",
               scatter_kws={"alpha": 0.3},
               logx=True)
    plt.show()

<img width="598" height="489" alt="image" src="https://github.com/user-attachments/assets/393fca6a-2e9b-451e-be79-6537ffb20934" />

Trend lines reinforce this pattern while also showing differences between continents.

# Categorical Comparisons

    # Life expectancy by continent (boxplot)
    plt.figure()
    sns.boxplot(data=df_tidy,
                x="continent",
                y="lifeExp")
    plt.title("Life Expectancy by Continent")
    plt.show()

<img width="562" height="455" alt="image" src="https://github.com/user-attachments/assets/820e51d8-4ee1-4eab-a576-f780a27c3f11" />

    # GDP by continent
    plt.figure()
    sns.boxplot(data=df_tidy,
                x="continent",
                y="gdpPercap")
    plt.yscale("log")
    plt.title("GDP per Capita by Continent")
    plt.show()

<img width="570" height="455" alt="image" src="https://github.com/user-attachments/assets/9142b7fe-2cfc-47c9-87e0-ecf7963907a6" />

Boxplots were used to compare life expectancy and GDP across continents. These reveal clear regional differences, with some continents showing consistently higher development indicators than others.

# Two Categorical Variables

    # Average life expectancy by continent and year
    pivot = df_tidy.groupby(["continent", "year"])["lifeExp"].mean().reset_index()
    
    plt.figure()
    sns.heatmap(pivot.pivot(index="continent",
                            columns="year",
                            values="lifeExp"),
                cmap="viridis")
    plt.title("Life Expectancy Heatmap (Continent x Year)")
    plt.show()

<img width="530" height="455" alt="image" src="https://github.com/user-attachments/assets/47aae76c-c274-41c2-8b7a-0a995dd2764e" />

A heatmap was used to analyse average life expectancy across continents and years. This visualisation highlights global improvement over time and persistent regional differences.

# Conclusion

The EDA shows clear relationships between economic development and life expectancy, as well as noticeable differences across regions and over time. However, the interpretation of these patterns is still limited.
Even though the visual trends are clear, understanding what actually causes them would require more statistical analysis and more background knowledge about the data.
It is also important to remember that correlation does not mean causation, and some of the patterns seen in the plots could be affected by other factors that are not included in the dataset.
Overall, this exercise helped with learning how to explore and summarise data, but it also showed that more advanced methods are needed to fully understand the relationships in the data.
