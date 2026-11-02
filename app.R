library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "App",
  theme = bs_theme(bootswatch = "darkly"),
  
  # --- Sidebar Navigation ---
  sidebar = sidebar(
    title = "Menu",
    uiOutput("sidebar_nav")
  ),
  
  # --- Main Content Area ---
  card(
    
    navset_hidden(
      id = "main_tabs",
      nav_panel("Page 1", h3("Page 1 Content")),
      nav_panel("Page 2", h3("Page 2 Content")),
      nav_panel("Page 3", h3("Page 3 Content"))
    )
  )
)

server <- function(input, output, session) {
  
  active_tab <- reactiveVal("Page 11")
  
  output$sidebar_nav <- renderUI({
    curr <- active_tab()
    div(
      class = "d-grid gap-2",
      actionButton("btn_p1", "Overview", class = if(curr == "Page 1") "btn-primary text-start" else "btn-outline-light text-start"),
      actionButton("btn_p2", "Player Profiles", class = if(curr == "Page 2") "btn-primary text-start" else "btn-outline-light text-start"),
      actionButton("btn_p3", "Page 3", class = if(curr == "Page 3") "btn-primary text-start" else "btn-outline-light text-start")
    )
  })
  
  observeEvent(input$btn_p1, {
    active_tab("Page 1")
    nav_select("main_tabs", "Page 1")
  })
  
  observeEvent(input$btn_p2, {
    active_tab("Page 2")
    nav_select("main_tabs", "Page 2")
  })
  
  observeEvent(input$btn_p3, {
    active_tab("Page 3")
    nav_select("main_tabs", "Page 3")
  })
}

shinyApp(ui, server)