---
title: "Developing Data Products - Week 2"
author: "John Letteboer"
date: "16/02/2019"
output: html_document
---



## Visualising my running track with R and Leaflet


```r
# Load libraries
if (!require(leaflet)) install.packages('leaflet','rgdal')
library(leaflet)
library(rgdal)

# Load GPX file
gpx_file <- "activity_1062102506.gpx"
track <- readOGR(gpx_file, layer = "tracks", verbose = FALSE)
track_coords <- readOGR(gpx_file, layer = "track_points", verbose = FALSE)
first <- head(coordinates(track_coords),1)
last <- tail(coordinates(track_coords),1)

map <- leaflet() %>% 
  # Add tiles
  addProviderTiles("OpenStreetMap.Mapnik", group = "Road map") %>%
  addProviderTiles("Esri.WorldImagery", group = "Satellite") %>%
  
  # Add markers
  addMarkers(first[1], first[2]) %>%
  addMarkers(last[1], last[2]) %>%
    
  # Add legend
  addLegend(position = 'bottomright',opacity = 0.4, 
            colors = 'blue', 
            labels = track$name) %>%
  
  # Layers control
  addLayersControl(position = 'bottomright',
    baseGroups = c("Road map", "Satellite"),
    overlayGroups = c("Running route"),
    options = layersControlOptions(collapsed = FALSE)) %>%

  # Add polylines
  addPolylines(data=track, group='Running route')

map
```

```
## Error in loadNamespace(name): there is no package called 'webshot'
```

