---
layout: post
title: "Unit 9 Plotly Exercise pt 2"
subtitle: "Plotly Exercise 2."
date: 2026-03-29
categories: [Module 4 Visualising Data]
tags: [Python,Matplotlib,seaborn,sklearn,Plotly]

---

[NOTEBOOK](https://github.com/matt9891-stack/Plotly_exc/blob/main/Plotly%20-%20Excercise%20mpg.ipynb)

# Project Description

In this project, we build an interactive MPG Dashboard using Dash and Plotly. The goal is to allow the user to explore the relationship between car characteristics, such as weight, fuel efficiency, and the number of cylinders, through dynamic visualisations. We provide two types of charts: a bar chart that shows the average miles per gallon for each cylinder type, and a scatter plot that displays the relationship between car weight and MPG. The app leverages Dash’s reactive components to update the visualisation immediately based on user input.

The app is initialised by creating an instance of Dash, which serves as the foundation for the web application. We then define the layout of the app using a single html.Div container. The layout includes a large header displaying the title "MPG Dashboard," a dropdown menu that allows the user to select the type of graph to view, and a graph component where the visualisation is rendered. The dropdown has two options: a bar plot labelled “Bar Plot (mpg vs cylinders)” and a scatter plot labelled “Scatter Plot (weight vs mpg).” By default, the bar plot is displayed when the app loads. Each component has a unique identifier (id), which is used to link it to the interactive callback logic.

The callback function is responsible for updating the figure whenever the user changes the selection in the dropdown menu. It takes the selected graph type as input and creates a new Plotly figure. If the user selects the bar plot, the function calculates the average MPG for each cylinder type using a group-by operation. A bar chart is then added to the figure, with cylinders on the x-axis and average MPG on the y-axis. The chart layout is customised with a descriptive title and labelled axes.

If the user selects the scatter plot, the function creates a scatter chart using the car weights for the x-axis and MPG for the y-axis. Each point represents a car, and hovering over a point shows the car's name. The layout is updated to provide a clear title and axis labels, making it easy to interpret the relationship between weight and fuel efficiency.

Finally, the app is executed within a Jupyter notebook cell using app.run(jupyter_mode="inline"), which allows the dashboard to render directly in the notebook output. Users can interact with the dropdown to switch between the bar and scatter plots, instantly updating the visualisation to explore different aspects of the MPG dataset. This project demonstrates the power of combining Dash for interactivity with Plotly for flexible data visualisation, creating a dynamic tool for exploring automotive data.
   
    
    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns
    
    from dash import Dash, dcc, html, Input, Output
    import plotly.graph_objects as go
    
    df = sns.load_dataset("mpg")
    
    app = Dash(__name__)
    
Initialise the Dash app instance, which will hold the layout and callback logic

    app.layout = html.Div([
        html.H1("MPG Dashboard"),
        # Display a large title at the top of the app
         dcc.Dropdown(
            id="graph-type",
            options=[
                {"label": "Bar Plot (mpg vs cylinders)", "value": "bar"},
                {"label": "Scatter Plot (weight vs mpg)", "value": "scatter"}
            ],
            value="bar"
        ),
Create a dropdown menu that lets the user select the type of graph to display

The default selection is the bar plot

The id "graph-type" links this dropdown to the callback

            dcc.Graph(id="graph")
            
Create a placeholder for the graph that will be updated dynamically based on the dropdown
                

    @app.callback(
        Output("graph", "figure"),
        Input("graph-type", "value")
    )
Define a callback function that updates the 'figure' property of the graph whenever the dropdown selection changes

    def update_graph(selected_type):
        fig = go.Figure()
    
Start with an empty figure

    if selected_type == "bar": # If the user selects the bar plot

        avg_mpg = df.groupby("cylinders")["mpg"].mean()
  
  Calculate the average MPG for each number of cylinders

        fig.add_trace(go.Bar(
            x=avg_mpg.index,
            y=avg_mpg.values,
            name="Avg MPG"
        ))
        
 Add a bar chart to the figure using cylinders as x-axis and average MPG as y-axis
 
        fig.update_layout(
            title="Average mpg vs cylinders type",
            xaxis_title="Cylinders",
            yaxis_title="Average mpg"
    
        )
        
Update the chart layout with a title and axis labels

    elif selected_type == "scatter":
    
 If the user selects the scatter plot
 
        fig.add_trace(go.Scatter(
            x=df["weight"],
            y=df["mpg"],
            mode="markers",
            marker=dict(size=8),
            text=df["name"]
        ))
        
 Add a scatter plot showing the relationship between weight (x-axis) and MPG (y-axis)
 
 Each point represents a car and displays the car's name when hovered over
 
        fig.update_layout(
            title="Relationship between weight and mpg",
            xaxis_title="Weight",
            yaxis_title="MPG"
        )
        
 Update the layout with a descriptive title and axis labels
 
    return fig
    
Return the completed figure to be displayed in the graph component

    if __name__ == "__main__":
        app.run(jupyter_mode="inline", port=8051)
        
# Run the Dash app directly within a Jupyter notebook cell

<img width="1518" height="450" alt="newplot4" src="https://github.com/user-attachments/assets/bc714dca-7940-4591-950b-1ea26b1ae50a" />

<img width="1518" height="450" alt="newplot5" src="https://github.com/user-attachments/assets/cfbc8608-ca95-49f9-80eb-267d8738a727" />




    
