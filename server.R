library("shiny")
library("leaflet")
library("maps")
source("source.R")

getData <- read.csv("married.csv")
getLocation <- read.csv("location.csv")

shinyServer(function(input, output) {
  
  
  output$showMap <- renderLeaflet({
    getId = which(getLocation$counties %in% input$counties_id)
    lng = getLocation$longitude[10]
    lat = getLocation$latitude[10]
    zoom = input$zoom
    
    #standardization
    getChosenData = which(getData$year == input$years_id & getData$place %in% input$counties_id)
    range <- max(getData[getChosenData, input$feature_id]) - min(getData[getChosenData, input$feature_id])
    standMatrix <- ((getData[getChosenData, input$feature_id] - min(getData[getChosenData, input$feature_id]))/range)*10+5
    
    getmap <- leaflet() %>% addTiles() %>% setView(lng, lat, zoom)
    if(!is.null(input$counties_id))
      addCircleMarkers(getmap, lng=getLocation$longitude[getId], lat=getLocation$latitude[getId],
         radius = standMatrix,
         color = "#03f",
         stroke = FALSE, fillOpacity = 0.5)
  })
  
  output$showCounties <- renderTable({
    getId = which(getData$year == input$years_id & getData$place %in% input$counties_id)
    getChosenData = which(getData$year == input$years_id & getData$place %in% input$counties_id)
    range <- max(getData[getChosenData, input$feature_id]) - min(getData[getChosenData, input$feature_id])
    standMatrix <- ((getData[getChosenData, input$feature_id] - min(getData[getChosenData, input$feature_id]))/range)*10+5
    Rank <- as.integer(length(standMatrix) - rank(standMatrix) + 1)
    showMatrix <- (getData[getId,c("place", "year", input$feature_id)])
    showMatrix <- cbind(showMatrix,Rank)
    print(showMatrix)
  })

})
