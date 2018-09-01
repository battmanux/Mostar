
library(shiny)
library(whisker)
library(shinyjs)

# UI STATICS ####

ui <- fluidPage(id="root", useShinyjs())

l_templates_names <- gsub(pattern = ".html$", "", 
     list.files(path = "w3client/html", full.names = F))

ui_templates <- lapply(
  l_templates_names,
  function(f) paste0(readLines(
    con = paste0("w3client/html/", f, ".html"),
    ok = T, warn = F), collapse = "\n")
)

names(ui_templates) <- l_templates_names

# SERVER ####
server <- function(input, output, session) {

  ui_page_main <- list(HTML(
    whisker::whisker.render(
      template = "{{>screen-main-list}}",
      partials = ui_templates, 
      data = list(`mostar-main-name`=44 ) ) )
  )

  htmltools::htmlDependencies(ui_page_main) <- htmltools::htmlDependency("font-awesome", 
                                              "4.7.0", c(href = "shared/font-awesome"), stylesheet = "css/font-awesome.min.css")

  insertUI(selector = "head", where = "beforeEnd", session = session, immediate = T, 
           ui = list(includeCSS(path = "w3client/style/main.css") ) )
  insertUI(selector = "#root", where = "afterBegin", session = session, immediate = T,
           ui = ui_page_main) 
  
  shinyjs::runjs(
    "$('[mostar-click-data]').click(
        function(){ 
          Shiny.onInputChange('click', 
            {data: $(this).attr('mostar-click-data'),
             hb: Math.random()
            } )
        }
      )"
  )
  
  observeEvent(input$click, {
    
    l_data <- input$click$data
    
    removeUI(selector = "#root > *", multiple = T, immediate = T, session = session)
    
    if  (grepl(pattern = "^[0-9]*$", x = l_data)) {
      
      # Load a group by its ID
      insertUI(selector = "#root", where = "afterBegin", session = session, immediate = T,
               ui = div("une page:", l_data, `mostar-click-data`='main') )
  
    } else if ( l_data %in% "user" ) {
  
      insertUI(selector = "#root", where = "afterBegin", session = session, immediate = T,
               ui = div("user ", `mostar-click-data`=4454) )
    
    } else {
    
      insertUI(selector = "#root", where = "afterBegin", session = session, immediate = T,
               ui =  ui_page_main)
    
    }

    
    shinyjs::runjs(
      "$('[mostar-click-data]').click(
      function(){ 
      Shiny.onInputChange('click', 
      {data: $(this).attr('mostar-click-data'),
      hb: Math.random()
      } )
      }
    )"
  )
    
    })
  
    
}

# RUN ####

shinyApp(ui = ui, server = server)

