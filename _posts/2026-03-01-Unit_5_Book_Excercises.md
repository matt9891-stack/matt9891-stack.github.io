---
layout: post
title: "Unit 5 Data Visualisation Book Exercises"
subtitle: "Tidying Data"
date: 2026-03-01
categories: [Module 4 Visualising Data]
tags: [R,tidyverse,tidyr,ggplot]
---

This artefact showcases the use of R for tidying and reshaping datasets, following examples and exercises from the book R for Data Science (Wickham and Grolemund, 2017). 
The purpose is to demonstrate how the tidyverse suite can be used to clean, manipulate, and visualise data, particularly through the creation of new variables, summarising data, and pivoting between wide and long formats.

# 1. Loading libraries and inspecting datasets
   
    library(tidyverse)
    library(ggplot2)
    library(dplyr)
    library(tidyr)
    glimpse(table2)
    table1
    table2
    table3

    > table1
    # A tibble: 6 × 4
      country      year  cases population
      <chr>       <dbl>  <dbl>      <dbl>
    1 Afghanistan  1999    745   19987071
    2 Afghanistan  2000   2666   20595360
    3 Brazil       1999  37737  172006362
    4 Brazil       2000  80488  174504898
    5 China        1999 212258 1272915272
    6 China        2000 213766 1280428583
    > table2
    # A tibble: 12 × 4
       country      year type            count
       <chr>       <dbl> <chr>           <dbl>
     1 Afghanistan  1999 cases             745
     2 Afghanistan  1999 population   19987071
     3 Afghanistan  2000 cases            2666
     4 Afghanistan  2000 population   20595360
     5 Brazil       1999 cases           37737
     6 Brazil       1999 population  172006362
     7 Brazil       2000 cases           80488
     8 Brazil       2000 population  174504898
     9 China        1999 cases          212258
    10 China        1999 population 1272915272
    11 China        2000 cases          213766
    12 China        2000 population 1280428583
    > table3
    # A tibble: 6 × 3
      country      year rate             
      <chr>       <dbl> <chr>            
    1 Afghanistan  1999 745/19987071     
    2 Afghanistan  2000 2666/20595360    
    3 Brazil       1999 37737/172006362  
    4 Brazil       2000 80488/174504898  
    5 China        1999 212258/1272915272
    6 China        2000 213766/1280428583

The code begins by loading essential packages. glimpse(table2) provides a compact view of the dataset’s structure, including column names, types, and sample values. The built-in datasets table1, table2, and table3 are displayed to understand the data before tidying.

# 2. Creating new variables with mutate()
    table1 |>
      mutate(rate <- cases / population * 10000)

          # A tibble: 6 × 5
      country      year  cases population `rate <- cases/population * 10000`
      <chr>       <dbl>  <dbl>      <dbl>                              <dbl>
    1 Afghanistan  1999    745   19987071                              0.373
    2 Afghanistan  2000   2666   20595360                              1.29 
    3 Brazil       1999  37737  172006362                              2.19 
    4 Brazil       2000  80488  174504898                              4.61 
    5 China        1999 212258 1272915272                              1.67 
    6 China        2000 213766 1280428583                              1.67 
Here, a new variable rate is calculated for TB incidence per 10,000 people by dividing cases by population and multiplying by 10,000. This demonstrates how mutate() can be used to create new columns derived from existing data.

# 3. Summarising data with group_by() and summarize()
    table1 |>
      group_by(year) |>
      summarize(total_cases = sum(cases))
      
    # A tibble: 2 × 2
       year total_cases
      <dbl>       <dbl>
    1  1999      250740
    2  2000      296920


The group_by() function is used to aggregate data by year, and summarise () computes the total number of TB cases for each year. This illustrates summarising operations in R for exploratory analysis.

# 4. Visualising trends with ggplot2
   
    ggplot(table1, aes(x = year, y = cases)) +
      geom_line(aes(group = country), color = 'grey50') +
      geom_point(aes(color = country, shape = country)) +
      scale_x_continuous(breaks = c(1999, 2000))

<img width="995" height="546" alt="image" src="https://github.com/user-attachments/assets/c1fc4a6a-c48f-4759-8f91-198385ca862f" />
     
A line plot shows changes in TB cases over time, with points coloured and shaped by country. The x-axis is explicitly set to include only 1999 and 2000, providing clarity for small datasets.

# 5. Reshaping datasets: calculating rates for table2 and table3

    table2new <- table2 |>
      pivot_wider(names_from = type, values_from = count)
      
        # A tibble: 6 × 4
        country      year  cases population
        <chr>       <dbl>  <dbl>      <dbl>
      1 Afghanistan  1999    745   19987071
      2 Afghanistan  2000   2666   20595360
      3 Brazil       1999  37737  172006362
      4 Brazil       2000  80488  174504898
      5 China        1999 212258 1272915272
      6 China        2000 213766 1280428583  
      
    table2new$rate <- table2new |>
      mutate(rate <- cases / population * 10000)

        # A tibble: 6 × 5
      country      year  cases population rate$country $year $cases $population $rate <- cases/population *…¹
      <chr>       <dbl>  <dbl>      <dbl> <chr>        <dbl>  <dbl>       <dbl>                         <dbl>
    1 Afghanistan  1999    745   19987071 Afghanistan   1999    745    19987071                         0.373
    2 Afghanistan  2000   2666   20595360 Afghanistan   2000   2666    20595360                         1.29 
    3 Brazil       1999  37737  172006362 Brazil        1999  37737   172006362                         2.19 
    4 Brazil       2000  80488  174504898 Brazil        2000  80488   174504898                         4.61 
    5 China        1999 212258 1272915272 China         1999 212258  1272915272                         1.67 
    6 China        2000 213766 1280428583 China         2000 213766  1280428583                         1.67 
    
    table3new <- table3 |>
      separate(rate, into = c('cases', 'population'), sep = '/')

          # A tibble: 6 × 4
      country      year  cases population
      <chr>       <dbl>  <dbl>      <dbl>
    1 Afghanistan  1999    745   19987071
    2 Afghanistan  2000   2666   20595360
    3 Brazil       1999  37737  172006362
    4 Brazil       2000  80488  174504898
    5 China        1999 212258 1272915272
    6 China        2000 213766 1280428583
    
    table3new$cases <- as.numeric(table3new$cases)
    table3new$population <- as.numeric(table3new$population)
    
    table3new$rate <- table3new |>
      mutate(rate <- cases / population * 10000)

    table3new

            # A tibble: 6 × 5
      country      year  cases population rate$country $year $cases $population $rate <- cases/population *…¹
      <chr>       <dbl>  <dbl>      <dbl> <chr>        <dbl>  <dbl>       <dbl>                         <dbl>
    1 Afghanistan  1999    745   19987071 Afghanistan   1999    745    19987071                         0.373
    2 Afghanistan  2000   2666   20595360 Afghanistan   2000   2666    20595360                         1.29 
    3 Brazil       1999  37737  172006362 Brazil        1999  37737   172006362                         2.19 
    4 Brazil       2000  80488  174504898 Brazil        2000  80488   174504898                         4.61 
    5 China        1999 212258 1272915272 China         1999 212258  1272915272                         1.67 
    6 China        2000 213766 1280428583 China         2000 213766  1280428583                         1.67

table2 is reshaped to a wider format to separate case types, and a new rate column is calculated. For table3, the combined rate column is split into separate cases and population columns with separate(), and converted to numeric before calculating the incidence rate. This demonstrates data tidying for consistent analysis.

# 6. Pivoting billboard data to long format

    billboard |>
      pivot_longer(
        cols = starts_with('wk'),
        names_to = 'week',
        values_to = 'rank',
        values_drop_na = TRUE
      ) |>
      mutate(week = parse_number(week))

        # A tibble: 5,307 × 5
       artist  track                   date.entered  week  rank
       <chr>   <chr>                   <date>       <dbl> <dbl>
     1 2 Pac   Baby Don't Cry (Keep... 2000-02-26       1    87
     2 2 Pac   Baby Don't Cry (Keep... 2000-02-26       2    82
     3 2 Pac   Baby Don't Cry (Keep... 2000-02-26       3    72
     4 2 Pac   Baby Don't Cry (Keep... 2000-02-26       4    77
     5 2 Pac   Baby Don't Cry (Keep... 2000-02-26       5    87
     6 2 Pac   Baby Don't Cry (Keep... 2000-02-26       6    94
     7 2 Pac   Baby Don't Cry (Keep... 2000-02-26       7    99
     8 2Ge+her The Hardest Part Of ... 2000-09-02       1    91
     9 2Ge+her The Hardest Part Of ... 2000-09-02       2    87
    10 2Ge+her The Hardest Part Of ... 2000-09-02       3    92

This code converts weekly chart rankings from wide to long format, drops missing values, and parses the week variable as numeric using parse_number(). Long-form data is easier to analyse and visualise over time.

    billboard_longer |> 
      ggplot(aes(x = week, y = rank, group = track)) + 
      geom_line(alpha = 0.25) + 
      scale_y_reverse()

  <img width="995" height="546" alt="image" src="https://github.com/user-attachments/assets/db6c866f-b817-4a75-b621-75228586a5f9" />

The resulting long-form data is plotted, with the y-axis reversed to reflect chart ranking positions correctly.

# 7. Pivoting and reshaping other datasets
    df <- tribble(
      ~id, ~bp1, ~bp2,
      'A', 100, 120,
      'B', 140, 115,
      'C', 120, 125
    )
    
    df |> 
      pivot_longer(
        cols = bp1:bp2,
        names_to = 'measurement',
        values_to = 'value'
      )

          id    measurement value
      <chr> <chr>       <dbl>
    1 A     bp1           100
    2 A     bp2           120
    3 B     bp1           140
    4 B     bp2           115
    5 C     bp1           120
    6 C     bp2           125

A small tibble is reshaped from wide to long format, demonstrating how multiple columns can be condensed into a tidy structure.

    household |> 
      pivot_longer(
        cols = !family, 
        names_to = c(".value", "child"), 
        names_sep = "_", 
        values_drop_na = TRUE
      )
    # A tibble: 9 × 4
      family child  dob        name  
       <int> <chr>  <date>     <chr> 
    1      1 child1 1998-11-26 Susan 
    2      1 child2 2000-01-29 Jose  
    3      2 child1 1996-06-22 Mark  
    4      3 child1 2002-07-11 Sam   
    5      3 child2 2004-04-05 Seth  
    6      4 child1 2004-10-10 Craig 
    7      4 child2 2009-08-27 Khai  
    8      5 child1 2000-12-05 Parker
    9      5 child2 2005-02-28 Gracie

  Here, advanced pivoting with .value is used to create multiple value columns from the original column names, while generating identifiers for each child in the household.

      cms_patient_experience |> 
      pivot_wider(
        id_cols = starts_with("org"),
        names_from = measure_cd,
        values_from = prf_rate
      )

      # A tibble: 500 × 9
       org_pac_id org_nm            measure_title CAHPS_GRP_1 CAHPS_GRP_2 CAHPS_GRP_3 CAHPS_GRP_5 CAHPS_GRP_8
       <chr>      <chr>             <chr>               <dbl>       <dbl>       <dbl>       <dbl>       <dbl>
     1 0446157747 USC CARE MEDICAL… CAHPS for MI…          63          NA          NA          NA          NA
     2 0446157747 USC CARE MEDICAL… CAHPS for MI…          NA          87          NA          NA          NA
     3 0446157747 USC CARE MEDICAL… CAHPS for MI…          NA          NA          86          NA          NA
     4 0446157747 USC CARE MEDICAL… CAHPS for MI…          NA          NA          NA          57          NA
     5 0446157747 USC CARE MEDICAL… CAHPS for MI…          NA          NA          NA          NA          85
     6 0446157747 USC CARE MEDICAL… CAHPS for MI…          NA          NA          NA          NA          NA
     7 0446162697 ASSOCIATION OF U… CAHPS for MI…          59          NA          NA          NA          NA
     8 0446162697 ASSOCIATION OF U… CAHPS for MI…          NA          85          NA          NA          NA
     9 0446162697 ASSOCIATION OF U… CAHPS for MI…          NA          NA          83          NA          NA
    10 0446162697 ASSOCIATION OF U… CAHPS for MI…          NA          NA          NA          63          NA

Data from patient experience surveys is widened so that each measurement code becomes a separate column, showing the flexibility of tidyverse functions for both long-to-wide and wide-to-long transformations.

Conclusion

This artefact demonstrates the use of R and the tidyverse to tidy, manipulate, and visualise data. Techniques include creating new variables, summarising data, pivoting between wide and long formats, splitting combined columns, converting strings to numeric values, and producing clear visualisations. 
The examples reflect the principles of tidy data as presented in R for Data Science (Wickham and Grolemund, 2017), showcasing how to structure datasets for efficient analysis and interpretation.

Reference

Wickham, H. and Grolemund, G., 2017. R for Data Science. Sebastopol: O’Reilly Media. Available at: https://learning.oreilly.com/library/view/r-for-data/9781492097396/ch05.html#data-tidy-summary
[Accessed 1 March 2026].
