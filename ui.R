
library(shiny)
library(dplyr)
library(tidytext)
library(textrank)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Text Summarization Shiny App"),
    
    # Sidebar with a slider input for number of bins
    sidebarPanel(
            
            fileInput("file", "Upload text file"),
            h4("Universal Part-of-Speech tags"),
            checkboxInput("ADJ", "Adjective", TRUE),
            checkboxInput("NOUN", "Noun", TRUE),
            checkboxInput("PROPN", "Proper Noun", TRUE),
            checkboxInput("ADV", "Adverb", FALSE),
            checkboxInput("VERB", "Verb", FALSE)
            
        ),
    
    mainPanel(
            
            tabsetPanel(type = "tabs",
                        
                    tabPanel("Overview",h4(p("A Shiny App around the UDPipe NLP workflow")),
                             
                       p(HTML("This shinyapp can read any text file using the upload functionality you see on left of your screen.
                       Once a file is loaded, you can tick mark which univeral part of speech (upos) in the uploaded file
                       you are interested in analysing. Internally, this app uses the UDPiple NLP workflow to do part of speech recognition.
                       Apart from annotation of the uploaded file, you can also see the Cooccurence graph of different upos. This app also shows
                       you a word cloud of all the verbs and nouns in the document.
                       For ease of navigation, this app is divided into following tabs:</br></br>
                         1. The first tab from where you are reading this description called <b>Overview</b>.</br>
                         2. Next is the Annotated document tab called <b>Article tagging </b> which describles the document you have uploaded.</br>
                         3. Tnen comes the <b>WordCloud</b> tab, which, as the name suggests, contaions the 
                         word clouds for verbs and nouns in the text.</br>
                         4. Last is the <b>COOG</b> tab which shows the cooccurence graph for various upos selected. </br></br>
                        
                        Thanks</br>
                        Prateek Bhardwaj</br>
                        Student id :- 11915037</br>
                        Email id :- prateek_bhardwaj_cba2020s@isb.edu</br></br>      
                        Rohit Kumar </br>
                        Student id :- 11915060 </br>
                        Email id : rohit_kumar_cba2020s@isb.edu </br></br>
                        Chirag Gupta </br>
                        Student id :- 11915053 </br>
                        Email id :- chirag_gupta_cba2020s@isb.edu
                        
                              "), align = "justify",
                         style="white-space: normal;
                        color: #091418; 
                        background-color:#f5f5f5;
                        border: 1px solid #e3e3e3;
                        height:90%px;
                        width:100%;
                        font-size: 13px;
                        border-radius: 4px;
                        padding:19px;
                        box-shadow: inset 0 1px 1px rgba(0,0,0,.05);")),
        

                    tabPanel("Article tagging",
                             h4(p("Annotated document")),
                             # Button
                             downloadButton("downloadCSV", "Download as csv"),
                             tableOutput("article_tags")),
                    
                    tabPanel("WordCloud",
                             h4(p("WordCloud for Nouns and Verbs")),
                             fluidRow(
                                 fixedRow(
                                     column(6, wellPanel(tags$b("Wordcloud of Nouns"),plotOutput(outputId="WordCloudNoun"))),
                                     column(6, wellPanel(tags$b("Wordcloud of Verbs"),plotOutput(outputId="WordCloudVerb"))))
                             
                                 )),
                    
                    tabPanel("COOG",
                             h4(p("Coocurence Graph")),
                             plotOutput("coog"))

                    )  # tabSetPanel closes
        
        )  # mainPanel closes
    
)
)  # fluidPage() & ShinyUI() close
