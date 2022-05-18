shinyServer(function(input, output) {
  
  #Barchat product category product to amount transaction
  output$plot_product_qty <- renderPlotly({
    
    sales_count_qty <- sales_clean %>% 
      group_by(Product.line) %>% 
      summarise(count_qty=sum(Quantity)) %>% 
      ungroup() %>% 
      arrange(-count_qty)%>% 
      mutate(label = glue(
        "Category: {Product.line}
        Count: {count_qty}"
      ))
    
    plot_product_qty <- ggplot(data = sales_count_qty, aes(x = count_qty, 
                                                           y = reorder(Product.line, count_qty), # reorder(A, berdasarkan B)
                                                           text = label)) + 
      geom_col(aes(fill = count_qty)) +
      scale_fill_gradient(low="#00a951", high="black") +
      labs(
           x = "Count of Sold",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none") 
    
    
    ggplotly(plot_product_qty, tooltip = "text")
    
  })
  
  #Barchat product category product to value of cash  
  output$plot_product_money <- renderPlotly({
    
    sales_count_money <- sales_clean %>% 
      group_by(Product.line) %>% 
      summarise(count_qty=sum(Total)) %>% 
      ungroup() %>% 
      arrange(-count_qty)%>% 
      mutate(label = glue(
        "Category: {Product.line}
        Count: {label_dolar(count_qty)}"
      ))
    
    plot_product_money <- ggplot(sales_count_money, aes(x = count_qty, 
                                           y = reorder(Product.line, count_qty), # reorder(A, berdasarkan B)
                                           text = label)) + 
      geom_col(aes(fill = count_qty)) +
      scale_fill_gradient(low="red", high="black") +
      labs(x = "Value Of Money",
           y = NULL) +
      scale_x_continuous(labels = dollar,limits = c(0, 60000))+
      theme_minimal() +
      theme(legend.position = "none") 
    
    
    ggplotly(plot_product_money, tooltip = "text")
    
  })
  
  #Barchat product category product to value of cash  
  output$plot_product_money <- renderPlotly({
    
    sales_count_money <- sales_clean %>% 
      group_by(Product.line) %>% 
      summarise(count_qty=sum(Total)) %>% 
      ungroup() %>% 
      arrange(-count_qty)%>% 
      mutate(label = glue(
        "Category: {Product.line}
        Count: {label_dolar(count_qty)}"
      ))
    
    plot_product_money <- ggplot(sales_count_money, aes(x = count_qty, 
                                                        y = reorder(Product.line, count_qty), # reorder(A, berdasarkan B)
                                                        text = label)) + 
      geom_col(aes(fill = count_qty)) +
      scale_fill_gradient(low="red", high="black") +
      labs(x = "Value Of Money",
           y = NULL) +
      scale_x_continuous(labels = dollar,limits = c(0, 60000))+
      theme_minimal() +
      theme(legend.position = "none") 
    
    
    ggplotly(plot_product_money, tooltip = "text")
    
  })
  
  #Piechart product category product to value of cash  
  output$pie_qty_payment <- renderHighchart({
    
    
    hc_payment <- groupby_payment %>% 
      hchart("pie", hcaes(x = Payment, y = count_qty),) %>% 
      hc_tooltip(pointFormat = paste('{point.y} items<br/><b>{point.percentage:.1f}%</b>'))
    
  })
  
  
  #Piechart Transaction By Payment 
  output$pie_qty_payment <- renderHighchart({
    
    
    hc_payment <- groupby_payment %>% 
      hchart("pie", hcaes(x = Payment, y = count_qty),) %>% 
      hc_tooltip(pointFormat = paste('{point.y} items<br/><b>{point.percentage:.1f}%</b>'))
    
  })
  
  
  #Piechart Transaction By Payment 
  output$pie_qty_city <- renderHighchart({
    
    hc_city <- groupby_city %>% 
      hchart("pie", hcaes(x = City, y = count_qty),) %>%
      hc_tooltip(pointFormat = paste('{point.y} items<br/><b>{point.percentage:.1f}%</b>'))
      
    
  })
  
  
  
  #Piechart Transaction By Members 
  output$pie_qty_members <- renderHighchart({
    
    hc_member <- groupby_member %>% 
      hchart("pie", hcaes(x = Customer.type, y = count_qty),) %>%
      hc_tooltip(pointFormat = paste('{point.y} items<br/><b>{point.percentage:.1f}%</b>')) 
  })
  
  #Piechart Transaction By Gender 
  output$pie_qty_gender <- renderHighchart({
    
    hc_gender <- groupby_gender %>% 
      hchart("pie", hcaes(x = Gender, y = count_qty),) %>%
      hc_tooltip(pointFormat = paste('{point.y} items<br/><b>{point.percentage:.1f}%</b>')) 
    
    
  })
  
  #Barchat product category x city
  output$plot_product_city <- renderPlotly({
  
    if(input$input_city == "")
    {
        sales_qty_city <- sales_clean %>% 
            group_by(Product.line, City) %>%
            filter() %>% 
            summarise(count_qty=sum(Quantity)) %>% 
            arrange(-count_qty) %>% 
            mutate(label = glue(
              "Category: {Product.line} 
               City: {City} 
               Count: {count_qty}"))
        
        plot_product_city <- ggplot(data = sales_qty_city, mapping = aes(x = count_qty, y = reorder(Product.line, count_qty),text = label)) +
          geom_col(mapping = aes(fill = City), position = "stack") +
          labs(x = "Quantity Of Sales", y = NULL,
               fill = NULL,
               title = "Category Products with Highest Quantity Of Sales By City") +
          scale_fill_brewer(palette = "Blues") +
          theme_minimal() +
          theme(legend.position = "none")
        
        
        ggplotly(plot_product_city, tooltip = "text")
    }
    else
    {
      
      sales_qty_city <- sales_clean %>% 
        filter(City==input$input_city) %>% 
        group_by(Product.line, City) %>%
        filter() %>% 
        summarise(count_qty=sum(Quantity)) %>% 
        arrange(-count_qty) %>% 
        mutate(label = glue(
          "Category: {Product.line} 
               City: {City} 
               Count: {count_qty}"))
      
      plot_product_city <- ggplot(data = sales_qty_city, mapping = aes(x = count_qty, y = reorder(Product.line, count_qty),text = label)) +
        geom_col(mapping = aes(fill = City), position = "stack") +
        labs(x = "Quantity Of Sales", y = NULL,
             fill = NULL,
             title = glue("Category Products with Highest Quantity Of Sales By {input$input_city} City")) +
        if(input$input_city == "Yangon")
        {
          scale_fill_manual(values = "#0084c2") 
        }
        else if(input$input_city == "Mandalay")
        {
          scale_fill_manual(values = "#aab4bb") 
        }
        else if(input$input_city == "Naypyitaw")
        {
          scale_fill_manual(values = "#92cce4") 
        }
        
        theme_minimal() +
        theme(legend.position = "none")
      
      
      ggplotly(plot_product_city, tooltip = "text")
        
    }
    
  })
  
  
  #Barchat product category x payment
  output$plot_product_payment <- renderPlotly({
    
    if(input$input_payment == "")
    {
      sales_qty_payment <- sales_clean %>% 
          group_by(Product.line, Payment) %>%
          summarise(count_qty=sum(Quantity)) %>% 
          arrange(-count_qty) %>% 
          mutate(label = glue(
            "Category: {Product.line} 
             Payment: {Payment} 
             Count: {count_qty}"))
      
      plot_product_payment <- ggplot(sales_qty_payment, mapping = aes(x = count_qty, y = reorder(Product.line, count_qty),text = label)) +
        geom_col(mapping = aes(fill = Payment), position = "stack") +
        labs(x = "Quantity Of Sales", y = NULL,
             fill = NULL,
             title = "Category Products with Highest Quantity Of Sales By Payment") +
        scale_fill_brewer(palette = "PuBu") +
        theme_minimal() +
        theme(legend.position = "none")
      
      
      ggplotly(plot_product_payment, tooltip = "text")
    }
    else
    {
      sales_qty_payment <- sales_clean %>% 
        filter(Payment==input$input_payment) %>% 
        group_by(Product.line, Payment) %>%
        summarise(count_qty=sum(Quantity)) %>% 
        arrange(-count_qty) %>% 
        mutate(label = glue(
          "Category: {Product.line} 
             Payment: {Payment} 
             Count: {count_qty}"))
      
      plot_product_payment <- ggplot(sales_qty_payment, mapping = aes(x = count_qty, y = reorder(Product.line, count_qty),text = label)) +
        geom_col(mapping = aes(fill = Payment), position = "stack") +
        labs(x = "Quantity Of Sales", y = NULL,
             fill = NULL,
             title = gleu("Category Products with Highest Quantity Of Sales By {input$input_payment} Payment")) +
          if(input$input_payment == "Cash")
          {
            scale_fill_manual(values = "#c4afda") 
          }
          else if(input$input_payment == "Ewallet")
          {
            scale_fill_manual(values = "#008ec3") 
          }
          else if(input$input_payment == "Credit card")
          {
            scale_fill_manual(values = "#a0bede") 
          }
        
        theme_minimal() +
        theme(legend.position = "none")
      
      
      ggplotly(plot_product_payment, tooltip = "text")
      
    }
    
  })
  
  
  
  #Barchat product category x gender
  output$plot_product_gender <- renderPlotly({
    
    if(input$input_gender == "")
    {
      sales_qty_sex <- sales_clean %>% 
        group_by(Product.line, Gender) %>%
        summarise(count_qty=sum(Quantity)) %>% 
        arrange(-count_qty) %>% 
        mutate(label = glue(
          "Category: {Product.line} 
           Gender: {Gender} 
           Count: {count_qty}"))
      
      plot_product_sex <- ggplot(sales_qty_sex, mapping = aes(x = count_qty, y = reorder(Product.line, count_qty),text = label)) +
        geom_col(mapping = aes(fill = Gender), position = "stack") +
        labs(x = "Quantity Of Sales", y = NULL,
             fill = NULL,
             title = "Category Products with Highest Quantity Of Sales By Gender") +
        scale_fill_brewer(palette = "Greens") +
        theme_minimal() +
        theme(legend.position = "none")
      
      
        ggplotly(plot_product_sex, tooltip = "text")
    }
    else
    {
      
      sales_qty_sex <- sales_clean %>% 
        filter(Gender==input$input_gender) %>% 
        group_by(Product.line, Gender) %>%
        summarise(count_qty=sum(Quantity)) %>% 
        arrange(-count_qty) %>% 
        mutate(label = glue(
          "Category: {Product.line} 
           Gender: {Gender} 
           Count: {count_qty}"))
      
      plot_product_sex <- ggplot(sales_qty_sex, mapping = aes(x = count_qty, y = reorder(Product.line, count_qty),text = label)) +
        geom_col(mapping = aes(fill = Gender), position = "stack") +
        labs(x = "Quantity Of Sales", y = NULL,
             fill = NULL,
             title = glue("Category Products with Highest Quantity Of Sales By {input$input_gender} Gender"))+
        if(input$input_gender == "Male")
        {
          scale_fill_manual(values = "#73a676") 
        }
        else if(input$input_gender == "Female")
        {
          scale_fill_manual(values = "#aab9a9") 
        }
        theme_minimal() +
        theme(legend.position = "none")
        
        ggplotly(plot_product_sex, tooltip = "text")
      
    }
    
  })
  
  
  #Barchat product category x member
  output$plot_product_member <- renderPlotly({
    
    if(input$input_member == "")
    {
      sales_qty_members <- sales_clean %>% 
        group_by(Product.line, Customer.type) %>%
        summarise(count_qty=sum(Quantity)) %>% 
        arrange(-count_qty) %>% 
        mutate(label = glue(
          "Category: {Product.line} 
           Customer Type: {Customer.type} 
           Count: {count_qty}"))
      
      plot_product_members <- ggplot(sales_qty_members, mapping = aes(x = count_qty, y = reorder(Product.line, count_qty),text = label)) +
        geom_col(mapping = aes(fill = Customer.type), position = "stack") +
        labs(x = "Quantity Of Sales", y = NULL,
             fill = NULL,
             title = "Category Products with Highest Quantity Of Sales By Member") +
        scale_fill_brewer(palette = "GnBu") +
        theme_minimal() +
        theme(legend.position = "none")
      
      
      ggplotly(plot_product_members, tooltip = "text")
    }
    else
    {
      
        sales_qty_members <- sales_clean %>% 
          filter(Customer.type==input$input_member) %>% 
          group_by(Product.line, Customer.type) %>%
          summarise(count_qty=sum(Quantity)) %>% 
          arrange(-count_qty) %>% 
          mutate(label = glue(
            "Category: {Product.line} 
             Customer Type: {Customer.type} 
             Count: {count_qty}"))
      
      plot_product_members <- ggplot(sales_qty_members, mapping = aes(x = count_qty, y = reorder(Product.line, count_qty),text = label)) +
        geom_col(mapping = aes(fill = Customer.type), position = "stack") +
        labs(x = "Quantity Of Sales", y = NULL,
             fill = NULL,
             title = glue("Category Products with Highest Quantity Of Sales By {input$input_member} type")) +
        if(input$input_member == "Normal")
        {
          scale_fill_manual(values = "#79a98a") 
        }
        else if(input$input_member == "Member")
        {
          scale_fill_manual(values = "#a7b8a4") 
        }
        theme_minimal() +
        theme(legend.position = "none")
      
      
      ggplotly(plot_product_members, tooltip = "text")
      
    }
    
  })
  
  output$data_table_sales <- DT::renderDataTable({
    sales
  },options = list(scrollX = T)
  
  ) 
  
  
})
