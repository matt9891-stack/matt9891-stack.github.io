---
layout: post
title: "Unit 9 Plotly Exercise pt 1"
subtitle: "Plotly Exercise."
date: 2026-03-29
categories: [Module 4 Visualising Data]
tags: [Python,Matplotlib,seaborn,sklearn,Plotly]
---

[NOTEBOOK](https://github.com/matt9891-stack/Plotly_2/blob/main/Plotly.ipynb)

# Overview of the Fruit Sales Dashboard

In this project, we are going to build an interactive web dashboard using Dash and Plotly to visualise monthly fruit sales. The dashboard allows users to explore data dynamically by selecting different fruits and instantly seeing the corresponding sales chart.

# What We Are Going to Do

We will start by setting up a simple dataset containing sales values for different fruits over several months. Then, we will create a Dash application and define its layout, including a title, a dropdown menu for selecting a fruit, and a graph area for displaying the chart.

Next, we will implement a callback function that updates the chart whenever the user selects a new fruit from the dropdown. This involves creating a Plotly figure, adding a bar chart with the selected fruit’s data, and updating the chart’s title and axis labels to make it clear and easy to read.

Finally, we will run the app locally so users can interact with it in a web browser, selecting fruits and instantly viewing how the sales data changes. This project demonstrates how to combine Python, Dash, and Plotly to create a responsive, user-friendly dashboard that effectively visualises data.

    from dash import Dash, dcc, html, Input, Output
    import plotly.graph_objects as go

Dash is the framework used to create the web application, providing the structure and server needed to run an interactive dashboard in a browser.
dcc, which stands for Dash Core Components, provides the interactive elements of the app, such as dropdown menus and graphs, allowing users to select options and see the data update in real time.
html in Dash is used to include standard HTML elements like divs and headings, helping to organize the layout and structure of the page visually.
Input and Output are essential for interactivity in Dash; they are used in callbacks to connect user actions, like selecting a fruit from the dropdown, to updates in the displayed graph.
plotly.graph_objects is a library used to build charts manually, giving precise control over the appearance and configuration of graphs, which allows for customised visualisations beyond the default options.

    # Sample data
    data = {
        "Apples": [10, 15, 13, 17],
        "Oranges": [16, 5, 11, 9],
        "Bananas": [12, 9, 15, 12]
    }
    
    months = ["Jan", "Feb", "Mar", "Apr"]

A simple dictionary is used to store the sales values for each fruit, with the fruit names as keys and their monthly sales as lists of numbers. The months list is used for the x-axis of the graph, representing each month, so that the sales data can be plotted over time.

    # Initialise app
    app = Dash(__name__)

The code creates an instance of the Dash app, which serves as the main application object where the layout, callbacks, and all components are defined. 

The __name__ parameter helps Dash locate resources, such as CSS and JavaScript files, and ensures the app runs correctly whether it’s executed directly or imported as a module.

    # Layout
    app.layout = html.Div([
        html.H1("Fruit Sales Dashboard"),

    dcc.Dropdown(
        id="fruit-dropdown",
        options=[{"label": fruit, "value": fruit} for fruit in data.keys()],
        value="Apples"
    ),

    dcc.Graph(id="sales-graph")
    ])

This section defines the layout of the page and determines what the user sees. The components include html.H1, which displays the main title of the dashboard, dcc.Dropdown, which allows the user to select a fruit from a list of options, and dcc.Graph, which is where the chart is displayed. 

The options parameter specifies the list of items the user can choose from, value sets the default selection when the app loads, and id is used to connect each component to the callback so that user interactions can trigger updates in the graph.

    # Callback
    @app.callback(
        Output("sales-graph", "figure"),
        Input("fruit-dropdown", "value")
    )
    
This part of the code controls the interactivity of the app using a callback. When the value in the dropdown changes, the callback function is automatically triggered. 

It updates the figure property of the graph, meaning the chart displayed on the screen changes based on the user’s selection.

    def update_graph(selected_fruit):
        fig = go.Figure()
        
The function receives the selected value from the dropdown as an input, which tells it which fruit’s data to use. 
    
    
    fig.add_trace(go.Bar(
        x=months,
        y=data[selected_fruit],
        name=selected_fruit
    ))


It then creates a new Plotly figure using go.Figure(), which starts as an empty chart. 

A bar chart is added using go.Bar(), and the data for the selected fruit is inserted dynamically, so the graph always reflects the user’s choice.

    fig.update_layout(
        title=f"Monthly Sales for {selected_fruit}",
        xaxis_title="Month",
        yaxis_title="Sales"
    )
    
This part of the code updates the layout of the graph by adding a title and axis labels, which makes the chart easier to understand. 
By clearly labelling the x-axis as months and the y-axis as sales, and including a descriptive title, it improves the overall readability and helps users quickly interpret the data being displayed.
   
    return fig

    # Run app
    if __name__ == "__main__":
        app.run(debug=True)

<img width="1518" height="450" alt="newplot1" src="https://github.com/user-attachments/assets/7a949380-f6a6-4238-9b8e-9ddb71780441" />

<img width="1518" height="450" alt="newplot2" src="https://github.com/user-attachments/assets/d0e77e12-4b85-49e2-8acf-47052f3fc460" />



