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
#install.packages("censusapi")
library("censusapi")
#install.packages("tidycensus")
library("tidycensus")
library(tidyverse)
#install.packages("censusGeography")
library("censusGeography")
library("tigris")

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
  shinythemes::themeSelector(),
  
  # Title is centered with largest heading. Project code is underneath with h2 heading.
  titlePanel(h1(strong("Food Accessibility in Washington State:"), align ="center")),
                h2(strong("You Are What You Eat"), align = "center"),
  
  # Page break(s)
  tags$br(),
  tags$br(),
  tags$br(),
  div(img(src = "fresh_fruit.jpg", height = "450", width = "400"), style="text-align: center;"),
  tags$br(),
  tags$br(),
  tags$br(),
  tags$br(),
  
  mainPanel(
    
    h3(strong(align = "left", "Aim")),
    p("Our project investigated whether or not socio-economic factors such as income, distance 
       and transportation have an impact on accessibility to fresh and nutritious food in 
       Washington State. We addressed this issue by extracting, manipulating and wrangling 
       data from the United States Department of Agriculture Economic Research Service website.
       The direct stakeholders are Washington State residents who are heavily impacted by the 
       limitations to fresh food; while, the indirect stakeholders are other Washington State
       residents, grocery stores, co-ops, farmers markets, policymakers and public interest
       groups."),
    h3(strong(align = "left", "Background")),
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
        those underserved, stripping them access to nutritious food; Those that are indirectly
        affected all of us in some fashion. A
        well-informed public can lead to better solutions; thereby, prevent the problem from
        getting any bigger."),
    h3(strong("Research Questions:")),
    tags$ul(tags$li(em("1) In what ways does distance have an impact on food accessibility?")),
            tags$li(em("2) How does a lack of vehicle access contribute to food 
                           inaccessibility?")),
            tags$li(em("3) To what extent does the interplay of income and location have an 
                           effect on access to fresh and nutritious food?"))
    )
  )
)

# PAGE TWO - Interactive Visualization Plotly Plot:
page_two <- tabPanel(
  "Transportation" 
  # We can do either or (or both).
)

# PAGE THREE - Interactive Visualization Data Table:
page_three <- tabPanel("Income to Distance", # Implement an interactive data table
                       # Sidebar with a selectInput for the variable for analysis
                       
                       # Title of Page
                       titlePanel(h1(strong("To what extent does the interplay of income and 
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
                           dataTableOutput(outputId = "data_table")
                         )
                       )
                       
)

# PAGE FOUR - Interactive Visualization Leaflet Map:
page_four <- tabPanel(
  "Distance", #implement an interactive graph
  
  #Title of Page
  titlePanel(h1(strong("What is the accessibility to grocery outlet for each
                              ", tags$br(), "county within Washington state?"), align = "center")),
  
  # newline/adds separation between title and content below
  tags$br(),
  tags$br(),
  tags$br(),
  
  # data <- data %>%
  #   select(id_census, id_county, id_rural, id_urban, acc_ur_1to10, acc_ur_1to20,
  #          acc_tract1, acc_tract10, acc_tract20, acc_store1, acc_store10, acc_store20),
  # 
  #census_id <- data %>% na.omit() %>% select(id_census)
  
  # graph1 <- function(county) {
  #   data %>% na.omit() %>%
  #     group_by(id_county) %>%
  #     mutate(total_acc1 = sum(acc_store1)) %>%
  #     mutate(total_acc10 = sum(acc_store10)) %>%
  #     mutate(total_acc20 = sum(acc_store20)) %>%
  #     mutate(total_acc = total_acc1 + total_acc10 + total_acc20) %>%
  #     filter(id_county == county) %>%
  #     summarise(
  #       total_acc = min(total_acc),
  #       total_acc1 = min(total_acc1),
  #       total_acc10 = min(total_acc10),
  #       total_acc20 = min(total_acc20)
  #     )
  # }
  # 
  # graph1("King"), 
  

  # # Create a basic bar
  # pie = ggplot(data, aes(x="", y=share, fill=brand)) + geom_bar(stat="identity", width=1),
  # # 
  # # # Convert to pie (polar coordinates) and add labels
  # pie = pie + coord_polar("y", start=0) + geom_text(aes(label = paste0(round(value*100), "%")), position = position_stack(vjust = 0.5)),

  # # Add color scale (hex colors)
  # pie = pie + scale_fill_manual(values=c("#55DDE0", "#33658A", "#2F4858", "#F6AE2D", "#F26419", "#999999")) ,
  # 
  # # Remove labels and add title
  # pie = pie + labs(x = NULL, y = NULL, fill = NULL, title = "Phones - Market Share"),
  # 
  # # Tidy up the theme
  # pie = pie + theme_classic() + theme(axis.line = element_blank(),
  #                                     axis.text = element_blank(),
  #                                     axis.ticks = element_blank(),
  #                                     plot.title = element_text(hjust = 0.5, color = "#666666"))
  
  # pie_organizing <- data %>% 
  #   group_by(id_county) %>% 
  #   mutate(total_pop = sum(id_totalpop)) %>% 
  #   mutate(total_acc1 = sum(acc_store1)) %>% 
  #   mutate(total_acc10 = sum(acc_store10)) %>% 
  #   mutate(total_acc20 = sum(acc_store20)) %>% 
  #   mutate(total_acc = total_acc1 + total_acc10 + total_acc20)
  

    


    #group by county, then find total of population
    #acc1, 10, and 20 and add those up
  #Variables to use: id_census, id_county, acc_store1, acc_store10, acc_store20
  
  
  
  # rep_age <- function(name, state) {
  #   current_year <- 2019
  #   rep_birthyear <- rep_info(name, state) %>%
  #     select(results.date_of_birth) %>%
  #     mutate(birthdate = format(as.Date(results.date_of_birth))) %>%
  #     mutate(year = year(birthdate)) %>%
  #     pull(year)
  #   age = current_year - rep_birthyear 
  # }
  # data <- data %>% 
  #   select (id_census, id_county, )
)
  
# PAGE FIVE - Summary and Conclusion:
page_five <- tabPanel(
  "Conclusion", # Summary Table and Aggregated Data
  tabPanel("Conclusion",
           titlePanel(h1(strong("Conclusion"), align = "center")),
           tags$br(),
           p("According to the USDA, food insecurity is defined as \"a lack of consistent access
             to enough food for an active, healthy life.\" Because food insecurity affects a large population of people
             in the U.S., it is important to understand the factors that contribute to this problem. Therefore, we began
             collecting insights based on the three main factors below:"),
           p(strong("Income:")),
           p(strong("Distance:")("According to our visual graph that presents the income in each household based on their mile radius
                    from a grocery outlet, we found that the further away the household is from the grocery outlet, the more likely they
                    are to have a lower income. This data shows the bigger picture, which is that there is a reoccuring trend of those who 
                    have a lower income will therefore not have access to fresh and nutritious food, contributing to the problem of food
                    insecurity in the nation.")),
           p(strong("Transportation:")),
           p("Ultimately, we found that a households income is the factor that contributes to food insecurity more than the distance to
             a grocery store or access to a vehicle does.")
  )
)


# PAGE SIX - Additional Info: Citation, Tech Report Link and About Us:
more_menu <- navbarMenu("More",
                        tabPanel("Works Cited",
                                 titlePanel(h1(strong("Resources"), align = "center")),
                                 tags$br(),
                                 h3(strong("Technology Used")),
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
                                 h3(strong("Citations")),
                                 p("Ross, Michael and Joel Ross.", em("Programming Skills for
                                 Data Science: Start Writing Code to Wrangle, Analyze, and 
                                 Visualize Data with R"),", First Edition. Addison-Wesley 
                                 Professional, 2018. Online Textbook."),
                                 p("What Is Food Insecurity in America? (n.d.). 
                                   Retrieved from https://hungerandhealth.feedingamerica.org/understand-food-insecurity/.")
                                 ),
                                p("USDA. (n.d.). Retrieved from https://www.usda.gov/."),
                        tabPanel("Tech Report",
                                 # Title of Page
                                 titlePanel(h1(strong("Reports and Links"), align = "center")),
                                 tags$br(),
                                 h3(strong("Github")),
                                 p("The following takes you to our", a("Github",
                                 href = "https://github.com/lnqhoa/INFO-201-Final-Project"),
                                 "page where you can see proposal 1, illustrations and 
                                 the progress we made."),
                                 tags$br(),
                                 h3(strong("Technical Report")),
                                 p("A direct link to our technical report can be found", 
                                 a("here.",
                                 href = "https://github.com/lnqhoa/INFO-201-Final-Project/blob/master/GitHub%20Wiki/Technical%20Report.Rmd"),
                                 "It now only provides a complete description of our project, 
                                 but offers a little background about the team members."),
                                 tags$br(),
                                 h3(strong("Shiny App")),
                                 p("To demo our application and learn more about food accessibility, click ",
                                 a("here.",
                                   href = "https://richiea7uwinfo.shinyapps.io/Food_Accessibility/"),
                                 "Shinyapps.io is a web hosting site for Rstudio code.")
                                 ),
                        tabPanel("About Us",
                                 # Title of Page
                                 titlePanel(h1(strong("Who We Are"), align = "center")),
                                 tags$br(),
                                 setBackgroundImage(src = "about.png", shinydashboard = TRUE),
                                 h3(strong("Mission Statement")),
                                 p(em("To educate others on the issue of food accessibility 
                                 and serve those in need.")),
                                 tags$br(),
                                 h3(strong("Get to Know Us")),
                                 p(code("Richie"), "is a junior at the University of 
                                 Washington. He transferred from a community college, and 
                                 currently is a junior. As a non-traditional student, Richie
                                 is usually the oddball in the classroom, but he loves being 
                                 back in school. He aspires to become either a data scientist
                                 or data privacy advocate. Richie is taking Info 201 to satisfy
                                 a requirement, better his programming skills and learn the
                                 complexities of data science."),
                                 p(code("Hoa Le"), "is currently a senior in University of Washington majoring in Psychology.
                                     Her career goal is to be a behavioral therapist."),
                                 p(code("Anna"), "is a senior at the University of Washington majoring in Interdisciplinary
                                     Visual Arts and minoring in Informatics. She is passionate about design work and food politics."),
                                 p(code("Jess"), "is a junior at the University of Washington interested in Business Marketing and Informatics."),
                                 tags$br(),
                                 h3(strong("Affiliation")),
                                 h4("INFO-201A: Technical Foundations of Informatics"),
                                 h4("The Information School"),
                                 h4("University of Washington"),
                                 h4("Autumn 2019"),
                                 tags$br(),
                                 h3(strong("Learn More About Us: Why Did We Choose Food Acccessibility?")),
                                 p(code("Richie"), "firmly believes we all have the right
                                 to fresh and nutritious food."),
                                 p(code("Hoa Le"), "wanted to inquire about food trends in 
                                        Seattle. However, data showed something more revealing."),
                                 p(code("Anna"), "is intellectually curious about food insecurity."),
                                 p(code("Jess"), "loves food and wants to see change."),
                                 ))
                                 

# Multi-Page Layout Using NavbarPage
my_ui <- navbarPage("",
                    page_one,
                    page_two,
                    page_three,
                    page_four,
                    page_five,
                    more_menu
)

# Deploys the server
my_server <- function(input, output, session) {
 
  output$data_table <- renderDataTable({
  
  # Creates a new data table using the subset function
  dtable <- subset(df1, df1$id_county == input$analysis_var)
  
  # Creates a new data table with the following selected columns
  dtable_2 <- round(select(dtable, id_totalpop, idv_income1, idv_income10, idv_income20), 0)
  colnames(dtable_2) <- c("Total Population", "1 Mile Radius", "10 Radius", "20 Mile Radius")
  dtable_2 # Displays data table
  
  })
}


# Runs the application
shinyApp(ui = my_ui, server = my_server)