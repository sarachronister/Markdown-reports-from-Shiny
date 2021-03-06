# This goes in the server function of your Shiny app

  # Code for producing static report
  # From: https://shiny.rstudio.com/gallery/download-knitr-reports.html
  
  output$downloadReport <- downloadHandler(
    # Creates a file name with the correct extension based on user selection
    filename = function() {
      paste(paste("Daily File Check",input$parent_org,Sys.Date(),sep = " - "),
            switch(input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'),sep = ".")
    },
    
    content = function(file) {
      
      src <- normalizePath('~/test_reports.Rmd')
      
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'test_reports.Rmd', overwrite = TRUE)
      
      library(rmarkdown)
      out <- render('test_reports.Rmd', encoding = "utf-8",
             switch(input$format,
             PDF = pdf_document(), HTML = html_document(), Word = word_document(reference_docx = "~/RefDoc.docx")
      ))
      file.rename(out, file)

    }
  )



