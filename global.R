library(shiny)
library(shinydashboard)

library(tidyverse)
library(ggpubr)
library(scales)
library(glue)
library(plotly)
library(lubridate)
library(highcharter)

library(DT)

# Sumber data : https://www.kaggle.com/datasets/aungpyaeap/supermarket-sales


#Read Data
sales <- read.csv("supermarket_sales.csv", stringsAsFactors = T) 

#Cleansing Data 
sales_clean <- sales %>% 
  mutate(
    DateTime = mdy_hm(paste(Date,Time))
  )%>% 
  select(-c(gross.margin.percentage,gross.income,Rating, Date, Time))

#summary data
qty_all <- sales_clean %>% 
  summarise(sum_qty = sum(Quantity), sum_total = sum(Total))


#function dollar
label_dolar <- label_dollar(
  accuracy = NULL,
  scale = 1,
  prefix = "$ ",
  suffix = "",
  big.mark = ",",
  decimal.mark = ".",
  trim = TRUE)



groupby_payment <- sales_clean %>% 
  group_by(Payment) %>% 
  summarise(count_qty=n()) %>% 
  ungroup()  %>% 
  arrange(-count_qty)


groupby_city <- sales_clean %>% 
  group_by(City) %>% 
  summarise(count_qty=n()) %>% 
  ungroup() %>% 
  arrange(-count_qty)

groupby_member <- sales_clean %>% 
  group_by(Customer.type) %>% 
  summarise(count_qty=n()) %>% 
  ungroup() %>% 
  arrange(-count_qty)

groupby_gender <- sales_clean %>% 
  group_by(Gender) %>% 
  summarise(count_qty=n()) %>% 
  ungroup() %>% 
  arrange(-count_qty)