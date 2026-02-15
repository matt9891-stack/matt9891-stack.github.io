library(haven)
library(readr)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

# How many rows are in penguins? How many columns?
dim(penguins) 

nrow(penguins)
ncol(penguins)

# What does the bill_depth_mm variable in the penguins data frame describe? Read the help for ?penguins to find out.
penguins$bill_depth_mm # $ between dataset and column to access the column

summary(penguins$bill_depth_mm) # summary gives main info
?penguins # open the help 

# Make a scatterplot of bill_depth_mm versus bill_length_mm. That is, make a scatterplot with bill_depth_mm on the y-axis and bill_length_mm on the x-axis. 
# Describe the relationship between these two variables.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
        geom_point()
#What happens if you make a scatterplot of species versus bill_depth_mm? What might be a better choice of geom?
ggplot(data = penguins,
       mapping = aes(x = species, y = bill_depth_mm)) +
  geom_point()
# best way is the boxplot as it shows the distribution of values
ggplot(penguins, aes(x = species, y = bill_depth_mm, fill = species)) +
  geom_boxplot() +
  theme_minimal()

# Why does the following give an error, and how would you fix it?

ggplot(data = penguins) + 
  geom_point() 
#  it needs x and y values

# What does the na.rm argument do in geom_point()? What is the default value of the argument? 
#Create a scatterplot where you successfully use this argument set to TRUE.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,y = bill_depth_mm, colour = species )) +
      geom_point(na.rm = TRUE) # apply in geaom_point to remove the nan values
      theme_minimal()
      
  labs() # to look at documentation
  
  # Add the following caption to the plot you made in the previous exercise: “Data come from the palmerpenguins package.
  ggplot(data = penguins,
         mapping = aes(x = bill_length_mm,y = bill_depth_mm, colour = species )) +
    geom_point(na.rm = TRUE) + # apply in geaom_point to remove the nan values
    labs(
      title = "Data come from the palmerpenguins package" ) +
  theme_minimal()
  
  # Re-create the following visualization. What aesthetic should bill_depth_mm be mapped to? 
  #And should it be mapped at the global level or at the geom level?

  ggplot(penguins, aes(x = flipper_length_mm,
                       y = body_mass_g,
                       colour = bill_depth_mm)) +
    geom_point(na.rm = TRUE) +
    geom_smooth(method = "lm", se = TRUE, na.rm = TRUE) + # se controls to sho confidence intervals 
    labs(
      title = "Data come from the palmerpenguins package",
      colour = "bill_depth_mm"
    ) + 
    theme_minimal() +
    scale_colour_viridis_c()
  
#Polynomial regression line  
  ggplot(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
    geom_point() + #using no method will give a polynomial reg
    geom_smooth()
  
  
  ggplot() +
    geom_point(
      data = penguins,
      mapping = aes(x = flipper_length_mm, y = body_mass_g)
    ) +
    geom_smooth(
      data = penguins,
      mapping = aes(x = flipper_length_mm, y = body_mass_g)
    )
  #Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?
  ggplot(penguins, aes(y = fct_infreq(species))) +
    geom_bar()
  
  #How are the following two plots different? 
  #Which aesthetic, color or fill, is more useful for changing the color of bars?
  
  ggplot(penguins, aes(x = species)) +
    geom_bar(color = "red") # colour the border
  
  ggplot(penguins, aes(x = species)) +
    geom_bar(fill = "red")
  #Make a histogram of the carat variable in the diamonds dataset that is available when you load the tidyverse package. 
  #Experiment with different binwidth values. What value reveals the most interesting patterns?
  ggplot(diamonds, aes(x = carat)) +
    geom_histogram(binwidth = 0.01)
  #lower carats are more common and max carat are 5 if seen in binwidth 0.1
  #using binwidth 0.01 we can see some patterns  of frequency
  