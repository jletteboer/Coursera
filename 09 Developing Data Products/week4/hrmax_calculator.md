HRmax Calculator
========================================================
author: John Letteboer
date: 03-03-2019
width: 1680
height: 1050

Overview
========================================================
This is an RStudio shiny application developed as a part of final project in the 
Developing Data Products course in the Coursera Data Science Specialization track.

The application calculates your maximum heart rate and the target heart rate 
zones for the chosen age.

The application includes:

- Its build with [shinydashboardPlus](https://github.com/RinteRface/shinydashboardPlus) library
- Tab menus
- Slider inputs for age, minimum and maximum intensiy
- A short documentation

This app is hosted at https://jletteboer.shinyapps.io/calculate_maximum_heartrate/

The code can be found at https://github.com/jletteboer/Coursera/tree/master/09%20Developing%20Data%20Products

Application widgets Used
========================================================
This application uses the listed widgets below.

- widgetUserBox, This box is where the author is mentioned
- gradientBox, These boxes contains the sliderInputs for age, minimum and maximum intensity
- sliderInput, Used for 3 inputs, for age (years), minimum (%) and maximum (%) intensity
- valueBoxOutput, Output bix for showing the results

<div align="center">
  <img src="profile.png" width=50% height=50%>
  <img src="sliders.png" width=50% height=50%>
  <img src="outputs.png" width=50% height=50%>
</div>

Operations in the App
========================================================
What is happening inside the app, here is a simple example. 

### Calculation of maximum heart rate

```r
input_age <- 45
hrmax <- 220 - input_age
hrmax
```

```
[1] 175
```

### Calculation of Target HR Zone

```r
input_age <- 45
input_minimum_intensity <- 50
input_maximum_intensity <- 70
minimum_intensity <- 220 - input_age * input_minimum_intensity/100
maximum_intensity <- 220 - input_age * input_maximum_intensity/100
paste0("Target HR Zone of ", input_minimum_intensity, "-", 
       input_maximum_intensity, "% is between ", minimum_intensity, " and ",
       maximum_intensity, " for ", input_age, " years old.")
```

```
[1] "Target HR Zone of 50-70% is between 197.5 and 188.5 for 45 years old."
```

Documentation in the App
========================================================
There is adocumentation area in the app. It can be accessed via the menu.

### Usage
Fill in your age, minimum and maximum intensity with the sliders and see what your maximum and target heart rates are. 
