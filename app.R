update.packages()


#install.packages("dplyr")
library("dplyr")
#install.packages("ggplot2")
#library("ggplot2")
#install.packages("shiny")
library("shiny")
#install.packages("leaflet")
#library("leaflet")
#install.packages("maps")
#library("maps")


setwd("C:/Users/19254/Desktop/project_shiny/Food_Availability")
food_availability <- read.csv("foodaccess1.csv", stringsAsFactors = FALSE)

# Multi-Page Layout Using NavbarPage
my_ui <- navbarPage("", page_one, page_two, page_four, more_menu)

page_one <- tabPanel(
  "Main Page", 
  titlePanel(""),
  
  
  mainPanel(
    h2(align = "left", "Food Availability in Washington State"),
    p("This project investigates whether socio-economic factors 
      have an impact on the availability of nutritious and fresh 
      food in Washington State."),
    h3(align = "left", "Background"),
    img(src = "./project_shiny/Food_Availability/my_image.jpg", height = 100,
        width = 100, align = "center"),
    p("According to the Dietary Guidelines 2015-2020 published by
        health.gov, around three-fourths of Americans lack proper 
        nutrition. They do not eat a balanced diet that consists 
        of fresh produce, lean meat, dairy, whole grains and healthy
        fats. One reason behind this is the limited access and 
        sometimes, inavailability to grocery stores, farmers markets
        and health-food outlets. Whether it is a lack of income, 
        transportation barrier or other socio-economic factor, 
        residents who lack access to nutritious food that typically
        live in food deserts, tend to have a higher incidence of 
        health related conditions such as diabetes, heart disease
        and obesity."),
    h3("Research Questions:"),
    tags$ul(tags$li(em("What is the food and nutrient availability 
                      for consumption in Washington State, compared 
                      to the rest of the nation?")),
            tags$li(em("How do socio-economic factors (location, 
                      income, race, ethnicity, etc.) contribute to 
                      food accessibility?"))
    )
  )
)

page_two <- tabPanel(
  
  "Graphs and Plots" # We can do either or (or both).
)


page_four <- tabPanel(
  "Summary" # Summary Table and Aggregated Data
  
)

more_menu <- navbarMenu("More",
                        tabPanel("Resources"),
                        tabPanel("Technical Report",
                                 a("Link to our technical report",
                                   href = "https://github.com/lnqhoa/INFO-201-Final-Project")),
                        tabPanel("About Us",
                                 p(em("Richie", "is a non-traditional, transfer student completing his first
                                      year at University of Washington. His favorite classes are 
                                      math and programming related. Originally from Hawai'i, 
                                      ")),
                                 p("Hoa is"),
                                 p("Anna is"),
                                 p("Jesse is")))

# Work Citation and Other Info Goes in this Section

my_server <- function(input, output) {
  
} 

# Runs the application
shinyApp(ui = my_ui, server = my_server)