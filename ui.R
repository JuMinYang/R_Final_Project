library("shiny")
library("leaflet")

shinyUI(fluidPage(

  # Application title
  titlePanel("Difference between each Counties in Taiwan"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("feature_id", "Features", names(getData[1,5:9])),
      selectInput("years_id", "Years",
                  choices = list("2011", "2012", "2013", "2014", "2015", "2011-2015" = "avg"),
                  selected = "2011-2015"),
      selectInput("counties_id", "please select counties:",
                  choices = list("基隆市" = "KeeLung", "台北市" = "Taipei", "新北市" = "NewTaipei",
                                 "桃園市" = "TaoYuan", "新竹市" = "HsinChu2", "新竹縣" = "HsinChu",
                                 "苗栗縣" = "MioaLi", "台中市" = "TaiChung", "彰化縣" = "ChangHua",
                                 "雲林縣" = "YunLin", "嘉義縣" = "Chiayi", "嘉義市" = "Chiayi2",
                                 "台南市" = "Tainan", "高雄市" = "KoaShiung", "屏東縣" = "PingTung",
                                 "台東縣" = "TaiTung", "花蓮縣" = "HuaLien", "宜蘭縣" = "YiLan",
                                 "南投縣" = "NanTou", "澎湖縣" = "PengHu", "金門縣" = "KinMen", "連江縣" = "LineChiang"),
                  selected = list("Taipei","TaiChung","ChangHua","Tainan"), multiple = TRUE),
      
      sliderInput("zoom", "Zoom", min = 5, max = 15, value = 7)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("showMap"),
      tableOutput("showCounties"),
      textOutput("showDebug")
    )
  )
))
