#install.packages("censusapi")
library(dplyr)
library(plotly)

data <- read.csv("./foodaccess_sub.csv")

data <- data %>%
  select(id_census, id_totalpop, id_county, id_rural, id_urban, acc_ur_1to10, acc_ur_1to20,
         acc_tract1, acc_tract10, acc_tract20, acc_store1, acc_store10, acc_store20)


county_choices <- data %>% select(id_county) %>%  unique()

graph1 <- function(county) {
  group_county <- data %>% na.omit() %>%
    group_by(id_county) %>%
    mutate(total_acc1 = sum(acc_store1)) %>%
             mutate(total_acc10 = sum(acc_store10)) %>%
             mutate(total_acc20 = sum(acc_store20)) %>%
             mutate(total_acc = total_acc1 + total_acc10 + total_acc20) %>%
             filter(id_county == county) %>%
             summarise(
               total_acc1 = min(total_acc1),
               total_acc10 = min(total_acc10),
               total_acc20 = min(total_acc20)
             )
  plot_ly(group_county, type = "bar", x = c(">= 20 miles away", ">= 10 miles away", ">= 1 mile away"),
          y = c(group_county$total_acc20, group_county$total_acc10, group_county$total_acc1),
          marker = list(color = c("red", "orange", "green"))) %>% 
    layout(title = "Accessibility to Grocery Outlets by County", xaxis = list(title = "Miles away from Grocery Outlets"), yaxis = list(title = 'Amount of Urban Tracts'), barmode = 'stack')
}