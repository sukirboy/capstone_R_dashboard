dashboardPage(
  skin = "green",
  
  dashboardHeader(
    title = "Sales Supermarket"
    
  ),
  
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Detail", tabName = "detail", icon = icon("th")),
      menuItem("Dataset", tabName = "dataset", icon = icon("database")),
      menuItem("About", tabName = "about", icon = icon("info"))
    )
    
  ),
  
  
  dashboardBody(
    
    tabItems(
      
      tabItem(
        tabName = "dashboard",
        fluidRow(
          valueBox(glue("{comma(qty_all$sum_qty)}"), 
                   "Total Transaction", 
                   icon = icon("receipt"),
                   width = 6,
                   color = "green"),
          
          valueBox(glue("$ {comma(qty_all$sum_total)}"),
                   "Total Cash Value in Transaction",
                   icon = icon("money"),
                   width = 6,
                   color = "red"),
          
        ),
        
        fluidRow(
          box(title = "Trending Product Categories sold in supermarkets in Triwulan 1 - 2019", 
              width = 12, 
              plotlyOutput("plot_product_qty")),
          
        ),
        
        fluidRow(
          
          box(title = "Trending Value of Money from product category in supermarket in Triwulan 1 - 2019", 
              width = 12, 
              plotlyOutput("plot_product_money")),
          
        ),
        
        fluidRow(
          box(title = "Transaction (invoice.ID) by Type of Payment", 
              width = 6, 
              highchartOutput(outputId = "pie_qty_payment")),
          
          box(title = "Transaction (invoice.ID) by City", 
              width = 6, 
              highchartOutput(outputId = "pie_qty_city")),
        ),
        
        fluidRow(
          box(title = "Transaction (invoice.ID) by Members", 
              width = 6, 
              highchartOutput(outputId = "pie_qty_members")),
          
          box(title = "Transaction (invoice.ID) by Gender", 
              width = 6, 
              highchartOutput(outputId = "pie_qty_gender")),
        ),
        
      ),
      
      tabItem(
        tabName = "detail",
        fluidRow(
          box(width = 12,
              selectInput(
                inputId = "input_city",
                label = "Choose City",
                choices = sales_clean$City,
                selected = NULL)
          ),
          
          box(width = 12,
              plotlyOutput("plot_product_city")), 
          
        ),
        
        fluidRow(
          
          box(width = 12,
              selectInput(
                inputId = "input_payment",
                label = "Choose Payment",
                choices = sales_clean$Payment,
                selected = NULL)
          ),
          
          box(width = 12,
              plotlyOutput("plot_product_payment")), 
          
        ),
        
        
        fluidRow(
          box(width = 12,
              selectInput(
                inputId = "input_gender",
                label = "Choose Gender",
                choices = sales_clean$Gender,
                selected = NULL)
          ),
          
          box(width = 12,
              plotlyOutput("plot_product_gender")), 
          
        ),
        
        fluidRow(
          box(width = 12,
              selectInput(
                inputId = "input_member",
                label = "Choose Type Customer",
                choices = sales_clean$Customer.type,
                selected = NULL)
          ),
          box(width = 12,
              plotlyOutput("plot_product_member")), 
          
        ),
        
        
        
      ),
      
      tabItem(
        tabName = "dataset",
        fluidRow(
          box(width = 12,
              title = "Supermarket Sales Data Triwulan 1 - 2019",
              dataTableOutput("data_table_sales"))
        )
        
      ),
      
      tabItem(
        tabName = "about",
        h2("Supermarket Sales Data Triwulan 1 - 2019"),
        p("By Sukirman"),
        h2("Dataset"),
        p("The dataset is one of the historical 
          sales of supermarket company which has recorded in 3 different city for 3 months data."),
        h2("Attribute Information"),
        p("- Invoice id: Computer generated sales slip invoice identification number"),
        p("- Branch: Branch of supercenter (3 branches are available identified by A, B and C)."),
        p("- City: Location of supercenters"),
        p("- Customer type: Type of customers, recorded by Members for customers using member card and Normal for without member card."),
        p("- Gender: Gender type of customer"),
        p("- Product line: General item categorization groups - Electronic accessories, Fashion accessories, Food and beverages, Health and beauty, Home and lifestyle, Sports and travel"),
        p("- Unit price: Price of each product in $"),
        p("- Total: Total price including tax"),
        p("- Date: Date of purchase (Record available from January 2019 to March 2019)"),
        p("- Quantity: Number of products purchased by customer"),
        p("- Tax: 5% tax fee for customer buying"),
        p("- Time: Purchase time (10am to 9pm)"),
        p("- Payment: Payment used by customer for purchase (3 methods are available – Cash, Credit card and Ewallet)"),
        p("- COGS: Cost of goods sold"),
        p("- Gross margin percentage: Gross margin percentage"),
        p("- Gross income: Gross income"),
        p("- Rating: Customer stratification rating on their overall shopping experience (On a scale of 1 to 10)"),
        p("Data Source : "),
        code("https://www.kaggle.com/datasets/aungpyaeap/supermarket-sales")
        
        
      )
      
    )
    
  )
)