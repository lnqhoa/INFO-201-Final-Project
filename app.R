#update.packages()
library("dplyr")
library("ggplot2")
#install.packages("shiny")
library("shiny")
library("leaflet")
library("maps")
library("rsconnect")
library("DT")
#install.packages("shinyWidgets")
library("shinyWidgets")
#install.packages("png")
library('png')
#install.packages("html")
#install.packages("shinythemes")
library("shinythemes")
#install.packages("tidycensus")
library("tidycensus")
#install.packages("plotly")
library("plotly")
library("hexbin")


source("./hoanna.r")

rsconnect::setAccountInfo(name='richiea7uwinfo',
                          token='25C67A5BBEE65C5BBBB1CF43A77EF6EF',
                          secret='JS5dyf9pVwhHl8p2zTplOooWUeixZyBVIvKw9wAw')

# Richie's Work Directory:
#setwd("/Desktop/project_shiny/Food_Availability")

# Hoa's Work Directory:
# ("C:/Users/HoaLe's/Desktop/INFO-201-Final-Project")

# Read .csv file
df1 <- read.csv("foodaccess_sub.csv", stringsAsFactors = FALSE)

# PAGE ONE - Intro + Research Questions:
page_one <- tabPanel(
  "Main Page",
  # Title is centered with largest heading. Project code is underneath with h2 heading.
  titlePanel(h2(strong("Food Accessibility in Washington State:"), align ="center")),
  h3(strong("You Are What You Eat"), align = "center"),
  
  # Page break(s)
  tags$br(),
  div(img(src = "fresh_fruit.jpg", height = "370", width = "320"), style="text-align: center;"),
  tags$br(),
  tags$br(),
  
  mainPanel(
    
    h4(strong(align = "left", "Objective")),
    p("Our project investigated whether or not socio-economic factors such as income, distance 
       and transportation have an impact on accessibility to fresh and nutritious food in 
       Washington State. We addressed this issue by extracting, manipulating and wrangling 
       data from the United States Department of Agriculture Economic Research Service website.
       The direct stakeholders are Washington State residents who are heavily impacted by the 
       limitations to fresh food; while, the indirect stakeholders are other Washington State
       residents, grocery stores, co-ops, farmers markets, policymakers and public interest
       groups."),
    h4(strong(align = "left", "Background")),
    p("According to the Dietary Guidelines from 2015 - 2020 published by
        health.gov, around three-fourths of Americans lack proper 
        nutrition. They do not eat a balanced diet that consists 
        of fresh produce, lean meat, dairy, whole grains and healthy
        fats. One reason behind this is the limited access and 
        sometimes, inavailability of grocery stores, farmers markets
        and health-food outlets. Whether it is due to a transportation barrier,
        low income or other socio-economic factor, 
        residents who have very little access to nutritious food, typically
        live in food deserts that tend to have a higher incidence of 
        health-related conditions such as diabetes, heart disease
        and obesity."), 
    p("Our health and overall quality of life are dependent on what what we consume. Without
        healthy and nutritious food, we cannot survive. Therefore, it is imperative to 
        acknowledge the ongoing issues related to food accessibility. It directly impacts 
        those underserved, stripping them access to nutritious food and indirectly
        affects all of us in some way."),
    h4(strong("Research Questions:")),
    tags$ul(tags$li(em("1) In what ways does distance have an impact on food accessibility?")),
            tags$li(em("2) How does a lack of vehicle access contribute to food 
                           inaccessibility?")),
            tags$li(em("3) To what extent does low income and location have an 
                           effect on access to fresh and nutritious food?"))
    )
  )
)

# PAGE TWO - Interactive Visualization Plotly Plot:
page_two <- tabPanel(
  "Transportation", titlePanel(h2(strong("How does a lack of vehicle access contribute to food 
                                          inaccessibility?"), align = "center")),
  # newline/adds separation between title and content below
  tags$br(),
  tags$br(),
  tags$br(),
  # Displays the table in the main panel
    mainPanel(
      plotlyOutput(outputId = "plot_tr"),
      tags$br(),
h4(strong("Insights")),
p("Again with low income as a common denominator, the bar chart measures how many tracts/areas in each county have little
  to no access to food. The Count measurement on the y-axis corresponds to the number of areas within a county that meet one
  of the following criteria: at least 100 households are located more than 1â2 mile from the nearest supermarket and have no
  vehicle access; or at   least 500 people or 33 percent of the population live more than 20 miles from the nearest supermarket,
  regardless of vehicle availability. Following on from this we can compare across each County to see their access to Food depending
  upon Transport. With King County topping the chart at 56, this means that there are 56 tracts/areas where people who live within that
  area have low access to food dependent upon Transportation. Futhermore we can use the graph to analyze which Counties are struggling
  and potentially offer solutions to help increase access to Food.")
    )
  )

# PAGE THREE - Interactive Visualization Data Table:
page_three <- tabPanel("Income to Distance", # Implement an interactive data table
                       # Sidebar with a selectInput for the variable for analysis
                       
                       # Title of Page
                       titlePanel(h2(strong("To what extent does low income and 
                                           location", tags$br(), "have an effect on access to 
                                           fresh and nutritious food?"), align = "center")),
                       
                       # newline/adds separation between title and content below
                       tags$br(),
                       tags$br(),
                       tags$br(),
                       
                       sidebarLayout(
                         sidebarPanel(helpText("Create a data table with information from 
                                             ers.usda.gov website."),
                                      selectInput(
                                        inputId = "analysis_var",
                                        label = em("Select a county from Washington State to Display"),
                                        choices = df1$id_county
                                      ),
                                      
                         ),
                         
                         
                         # Displays the table in the main panel
                         mainPanel(
                           tabsetPanel(
                             tabPanel("Data Table",dataTableOutput(outputId = "data_table"),
                                      dataTableOutput(outputId = "data_table_2")),
                             tabPanel("Annotation",
                                      h5(strong("No. of Individuals Within 1 Mile:")),
                                      p("Number of individuals in an urban tract with low 
                                        income and living more than 1 mile from the nearest 
                                         supermarket, supercenter, or large grocery store. 
                                         Low income is defined as annual family income at or 
                                         below 200 percent of the Federal poverty threshold 
                                         for family size."),
                                      h5(strong("No. of Individuals Within 10 Mile:")),
                                      p("Number of individuals in a rural tract with low 
                                      income and living more than 10 miles from the nearest 
                                      supermarket, supercenter, or large grocery store. Low 
                                      income is defined as annual family income at or below 
                                      200 percent of the Federal poverty threshold for family
                                      size."),
                                      h5(strong("No. of Individuals Within 20 Mile:")),
                                      p("Number of individuals in a rural tract with low 
                                      income and living more than 20 miles from the nearest
                                      supermarket, supercenter, or large grocery store. Low 
                                      income is defined as annual family income at or below
                                      200 percent of the Federal poverty threshold for family
                                      size."),
                                      p(em("Resource: ers.usda.gov"))
                             )
                           )
                         )
                         
                       )
)
# PAGE FOUR - Interactive Visualization Leaflet Map:
page_four <- tabPanel(title = "Distance", 
                      titlePanel(h2(strong("In what ways does the distance from the nearest grocery store have an impact on food accessibility?"),
                                    align = "center")),
                      tags$br(),
                      tags$br(),
                      tags$br(),
                      sidebarLayout(
                        sidebarPanel(
                          selectInput(inputId = "county",
                                      choices = county_choices,
                                      label = "Select a County")
                        ),
                        mainPanel(
                          plotlyOutput(outputId = "distance_store")
                        )))

# PAGE FIVE - Summary and Conclusion:
page_five <- tabPanel(
  "Conclusion", # Summary and Aggregated Data
  titlePanel(h2(strong("Summary"), align = "center")),
  tags$br(),
  p("According to the USDA, food insecurity is defined as \"a lack of consistent access
             to enough food for an active, healthy life.\" Because food insecurity affects a large population of people
             in the U.S., it is important to understand the factors that contribute to this problem. Therefore, we began
             collecting insights based on the three main factors below:"),
  tags$br(),
  h4(strong("Transportation")),
  p("Again with low income as a common denominator, the bar chart measures how many tracts/areas in each county have little
  to no access to food. The Count measurement on the y-axis corresponds to the number of areas within a county that meet one
  of the following criteria: at least 100 households are located more than 1???2 mile from the nearest supermarket and have no
  vehicle access; or at   least 500 people or 33 percent of the population live more than 20 miles from the nearest supermarket,
  regardless of vehicle availability. Following on from this we can compare across each County to see their access to Food depending
  upon Transport. With King County topping the chart at 56, this means that there are 56 tracts/areas where people who live within that
  area have low access to food dependent upon Transportation. Futhermore we can use the graph to analyze which Counties are struggling
  and potentially offer solutions to help increase access to Food.
"),
  tags$br(),
  h4(strong("Distance")),
  p("According to our visual graph that presents the income in each household based on their mile radius
  from a grocery outlet, we found that the further away the household is from the grocery outlet, the more likely they
  are to have a lower income. This data shows the bigger picture, which is that there is a reoccuring trend of those who 
  have a lower income will therefore not have access to fresh and nutritious food, contributing to the problem of food
  insecurity in the nation."),
  tags$br(),
  h4(strong("Income and Location")),
  p("With low income as a common denominator, the farther an individual lives to a grocery
     store, supercenter or health-food store, the less likely the person will have access to
     fresh and nutritious food. The findings confirmed our speculation that residents who live
     in a more rural part of the state that have an annual family income at or below 200
     percent of the Federal poverty threshold, are unfortunately, victims to the barrier of 
     distance. The data table under the income-to-distance tab substantiates our claim; as distance increases
     to and from a grocery store or supercenter, the percentage of residents within a particular
     county decreases. For example, at 1 mile, approximately 27% of residents in the designated
     census ID: 53039950100 of Klickitat county, has access to fresh and nutritious food. At 10
     miles, it reduces to 8%. Then at 20 miles, it goes down to 2%. This is the theme for all 
     counties in the state of Washington. Nevertheless, low income in itself is a huge barrier.
     Distance compounds the issue of food accessibility even more."),
  tags$br(),
  p("Ultimately, our findings led us to believe that the socio-economic factors listed above,
     play at role in the accessibility of fresh and nutritious food. Low income families that
     meet the federal poverty threshold, are the ones most affected. This is exacerbated by
     the lack of transporation. Additionally, the greater the distance to and from the nearest
     grocery store, the more likely someone becomes food insecure.")
)
# PAGE SIX - Additional Info: Citation, Tech Report Link and About Us:
more_menu <- navbarMenu("More",
                        tabPanel("Works Cited",
                                 titlePanel(h2(strong("Resources"), align = "center")),
                                 tags$br(),
                                 h4(strong("Technology Used")),
                                 p("We used the following to communicate, research
                                   and build our Shiny application."),
                                 tags$li("Microsoft Teams"),
                                 tags$li("Text Chat"),
                                 tags$li("Odegaard Library"),
                                 tags$li("Github"),
                                 tags$li("RStudio"),
                                 tags$li("Canvas"),
                                 tags$li("ShinyApps.io"),
                                 tags$br(),
                                 h4(strong("Citations")),
                                 p("Ross, Michael and Joel Ross. (2018).", 
                                   em("Programming Skills for Data Science: Start Writing Code 
                                 to Wrangle, Analyze, and Visualize Data with R. "),
                                   "Addison-Wesley Professional."),
                                 p("O'Neil, Cathy. (2016).", em("Weapons of Math Destruction. "),
                                   "New York City: Broadway Books."),
                                 p("Friedman, B., Nathan, L. P., Kane, S., and Lin, J. (2011).",
                                   em("Envisioning Cards. "), "Seattle: University of Washington"),
                                 p("U.S. Households by Food Security Status. (2018). Retrieved from 
                                   https://www.ers.usda.gov/webdocs/charts/80054/household.png?v=5890.com."),
                                 p("Average Food Insecurity Rate in the U.S. and the West Coast States: 
                                   2008. (2008). Retrieved from https://depts.washington.edu/wcpc/food-insecurity."),
                                 p("Washington County Map with County Seat Cities. Retrieved from 
                                   https://geology.com/county-map/washington.shtml.")
                        ),
                        tabPanel("Tech Report",
                                 # Title of Page
                                 titlePanel(h2(strong("Reports and Links"), align = "center")),
                                 tags$br(),
                                 h4(strong("Github")),
                                 p("The following takes you to our", a("Github",
                                                                       href = "https://github.com/lnqhoa/INFO-201-Final-Project"),
                                   "page where you can see proposal 1, illustrations and 
                                 the progress we made."),
                                 tags$br(),
                                 h4(strong("Technical Report")),
                                 p("A direct link to our technical report can be found", 
                                   a("here.",
                                     href = "https://github.com/lnqhoa/INFO-201-Final-Project/blob/master/GitHub%20Wiki/Technical%20Report.Rmd"),
                                   "It not only provides a complete description of our project, 
                                 but offers a little background about the team members."),
                                 tags$br(),
                                 h4(strong("Shiny App")),
                                 p("To demo our application and learn more about food accessibility, click ",
                                   a("here.",
                                     href = "https://richiea7uwinfo.shinyapps.io/Food_Accessibility/"),
                                   "Shinyapps.io is a web hosting site for Rstudio code.")
                        ),
                        tabPanel("About Us",
                                 # Title of Page
                                 titlePanel(h2(strong("Who We Are"), align = "center")),
                                 tags$br(),
                                 div(img(src = "group.jpg", height = "200", width = "250"), style="text-align: center;"),
                                 #setBackgroundImage(src = "about.png", shinydashboard = TRUE),
                                 tags$br(),
                                 tags$br(),
                                 h4(strong("Mission Statement")),
                                 p(em("To educate others on the issue of food accessibility 
                                 and serve those in need.")),
                                 tags$br(),
                                 h4(strong("Get to Know Us")),
                                 p(code("Richie"), "is a junior at the University of 
                                 Washington. He transferred from a community college. As a 
                                 non-traditional student, Richie
                                 is usually the oddball in the classroom, but he loves being 
                                 back in school. He aspires to become either a data scientist
                                 or data privacy advocate. Richie is taking Info 201 to satisfy
                                 a requirement, better his programming skills and learn the
                                 complexities of data science."),
                                 p(code("Hoa Le"), "is currently a senior in University of Washington majoring in Psychology.
                                     Her career goal is to be a behavioral therapist."),
                                 p(code("Anna"), "is a senior at the University of Washington majoring in Interdisciplinary
                                     Visual Arts and minoring in Informatics. She is passionate about design and food politics."),
                                 p(code("Jess"), "is a junior at the University of Washington interested in Business Marketing and Informatics."),
                                 tags$br(),
                                 h4(strong("Affiliation")),
                                 h5("INFO-201A: Technical Foundations of Informatics"),
                                 h5("The Information School"),
                                 h5("University of Washington"),
                                 h5("Autumn 2019"),
                                 tags$br(),
                                 h4(strong("Learn More About Us: Why Did We Choose Food Acccessibility?")),
                                 p(code("Richie"), "firmly believes we all have the right
                                 to fresh and nutritious food."),
                                 p(code("Hoa Le"), "wanted to inquire about food trends in 
                                        Seattle. However, data showed something more revealing."),
                                 p(code("Anna"), "is intellectually curious about food insecurity."),
                                 p(code("Jess"), "loves food and wants to see change."),
                        ))


# Multi-Page Layout Using NavbarPage with "Flatly" Shinytheme for a Little Pizzazz. 
my_ui <- navbarPage("", theme = shinytheme("flatly"),
                    page_one,
                    page_two,
                    page_three,
                    page_four,
                    page_five,
                    more_menu
)
# Deploys the server
my_server <- function(input, output, session) {
 
  output$plot_tr <- renderPlotly({
    counts_tr <- df1 %>%
      group_by(id_county) %>%
      summarize(sum = sum(id_vehacc)
      )
    plot_transport <- ggplotly(ggplot(data = counts_tr) +
                               geom_col(mapping = aes(x = id_county, y = sum, 
                               fill = id_county)) + labs(title = "Comparing Washington
                               Counties Access to Food   ",
                               x = "County",
                               y = "Count"
                                 )
    )
    plot_transport 
  })
  
  
  output$data_table <- renderDataTable({
  
  # Creates a new data table using the subset function
  dtable <- subset(df1, df1$id_county == input$analysis_var)
  
  # Creates a new data table with the following selected columns
  dtable <- mutate(dtable, idv_1 = ((idv_income1/id_totalpop)*100), 
                   idv_10 = ((idv_income10/id_totalpop)*100),
                   idv_20 = ((idv_income20/id_totalpop)*100))
  dtable_2 <- round(select(dtable, id_census, id_totalpop, idv_income1, idv_1, idv_income10, idv_10,
                 idv_income20, idv_20), 0)
  colnames(dtable_2) <- c("Census ID", "Total Population", "No. of Individuals Within 1 Mile",
                          "Percentage  of Individuals Within 1 Mile", 
                          "No. of Individuals Within 10 Miles", 
                          "Percentage  of Individuals Within 10 Mile",
                          "No. of Individuals Within 20 Miles", 
                          "Percentage of Individuals Within 20 Mile")
  dtable_2 # Displays data table
  
  })
  
  output$distance_store <- renderPlotly({
    graph1(input$county)
  })
}

# Runs the application
shinyApp(ui = my_ui, server = my_server)
