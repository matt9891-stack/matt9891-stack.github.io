---
layout: post
title: "Seminar Activity 2"
subtitle: "Module 4 – Seminar 2 Airlines Analysis"
date: 2026-02-13
categories: [Module 4 Visualising Data]
---


This script focuses on analysing flight delays using the NYCflights13 dataset, with an emphasis on summarisation and effective visual communication.
The analysis explores differences in delays across airlines (carriers) and examines seasonal patterns over time. 
By combining data transformation with targeted visualisations, the script demonstrates how aggregation and plotting can reveal meaningful trends in real-world data.


    flights_summ <- flights |>
        group_by(carrier) |>
         summarise(
            n = n(),
            mean_arr_delay = mean(arr_delay, na.rm = TRUE),
            mean_dep_delay = mean(dep_delay, na.rm = TRUE),
            .groups = "drop"
          ) |>
          arrange(desc(mean_arr_delay))
        
        flights_summ

  <img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/aea838b6-6549-4fe5-a713-694a4d1c4a32" />

The dataset is grouped by carrier, and key metrics are calculated: total number of flights (n), mean arrival delay (mean_arr_delay), mean departure delay (mean_dep_delay)

Missing values are handled using na.rm = TRUE, ensuring accurate averages.

The majority of Airlines have delays between 0 and 10 mins with only 2 Airlines with delays over 20 mins which, anyway, only involves a small number of carriers.

    pF <- flights_summ |>
      mutate(carrier = forcats::fct_reorder(carrier, mean_arr_delay)) |>
      ggplot(aes(x = mean_arr_delay, y = carrier)) +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_point(aes(size = n), alpha = 0.8) +
      scale_size_continuous(name = "Flights") +
      labs(
        title = "Mean arrival delay by carrier",
        x = "Mean arrival delay (min)",
        y = NULL,
        caption = "Source: nycflights13"
      ) +
      theme_house()
    
    pF

  <img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/59d3b117-3f04-40ee-b9d9-4cedfbb37522" />

  This reveals seasonal patterns, such as periods with higher congestion or operational challenges.

      monthly <- flights |>
      group_by(month) |>
      summarise(mean_dep_delay = mean(dep_delay, na.rm = TRUE), .groups = "drop")
    
    monthly

        month mean_dep_delay
       <int>          <dbl>
     1     1          10.0 
     2     2          10.8 
     3     3          13.2 
     4     4          13.9 
     5     5          13.0 
     6     6          20.8 
     7     7          21.7 
     8     8          12.6 
     9     9           6.72
    10    10           6.24
    11    11           5.44
    12    12          16.6 

This summarises the average delays by month, confirming the picture above

    pHeat <- ggplot(heat, aes(factor(month), carrier, fill = mean_dep_delay)) +
      geom_tile() +
      scale_fill_viridis_c(option = "C") +
      labs(
        title = "Departure delays by carrier and month",
        x = "Month",
        y = "Carrier",
        fill = "Mean dep delay"
      ) +
      theme_house()
    
    pHeat

<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/0942ca9c-8927-4e2f-85f2-afb0bf374f0c" />

# Conclusion

This visualisation provides a compact overview of how delays vary across both airlines and time, making it easier to detect recurring patterns or anomalies.

This analysis demonstrates how aggregating data at different levels can reveal distinct but complementary insights. Looking at delays by carrier highlights structural differences between airlines, while the monthly aggregation uncovers broader seasonal patterns that might affect all carriers. The combination of these perspectives makes the analysis more informative than relying on a single summary.

The visualisations also show the importance of choosing appropriate plot types for different analytical goals. The dot plot is effective for ranking and comparison, the line chart captures temporal trends, and the heatmap provides a compact overview of interactions between variables. Together, they illustrate how multiple representations of the same dataset can deepen understanding.

Overall, this work reinforces the idea that good data visualisation is not just about presenting results, but about guiding interpretation. By carefully structuring both the data transformations and the visual outputs, the analysis becomes clearer, more insightful, and easier to communicate.
