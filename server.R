  # Prateek Bhardwaj
  # Student id :- 11915037
  # Email id :- prateek_bhardwaj_cba2020s@isb.edu      
  # Rohit Kumar 
  # Student id :- 11915060 
  # Email id : rohit_kumar_cba2020s@isb.edu 
  # Chirag Gupta 
  # Student id :- 11915053 
  # Email id :- chirag_gupta_cba2020s@isb.edu

library(shiny)
require(dplyr)
require(magrittr)
require(tidytext)
require(udpipe)
require(stringr)
library(igraph)
library(ggraph)
library(ggplot2)
library(wordcloud)

udpipeEnglish <-"C:/ISB CBA/Text Analytics/Lecture 4/english-ewt-ud-2.4-190531.udpipe"

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  #A common functio to create a udpipe dataframe
  udpipeDataFrame <- function(){
    text=dataset()
    english_model <- udpipe_load_model(udpipeEnglish)
    x <- udpipe_annotate(english_model, x=text )
    x <- as.data.frame(x)
    return(x)
  }
    
#return the data from inported file    
    dataset <- reactive({
        inFile<-input$file
        if (is.null(inFile)) {return(NULL)}
        else {
            
            dataset = readLines(inFile$datapath)
            dataset = str_replace_all(dataset, "<.*?>", "")
            return(dataset)}
    })

    
    
#annotate article into upos
    article_tags <- reactive({
        
            filter<-c()
            x <- udpipeDataFrame()
            x$sentence<-NULL #dropping sentence
            if(input$NOUN){filter<-c(filter,'NOUN')}
            if(input$ADJ){filter<-c(filter,'ADJ')}
            if(input$PROPN){filter<-c(filter,'PROPN')}
            if(input$ADV){filter<-c(filter,'ADV')}
            if(input$VERB){filter<-c(filter,'VERB')}
            x<- subset(x,upos %in% filter)
        
            return(x[c(1:100), ]) #Show only fist 100 rows
    })
    
    #All_Tags=article_tags()
    output$article_tags <- renderTable({ article_tags() })
    
    
#Co-occurence graph   
    output$coog <-renderPlot({
        text_cooc <- cooccurrence(
            x = article_tags(),
            term = "lemma", 
            group = c("doc_id", "paragraph_id", "sentence_id"))
        
        wordnetwork <- head(text_cooc, 50)
        wordnetwork <- igraph::graph_from_data_frame(wordnetwork)
        
        ggraph(wordnetwork, layout = "fr") +  
            geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "orange") +  
            geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
            theme_graph(base_family = "Arial Narrow") +  
            theme(legend.position = "none") +
            labs(title = "Cooccurrences within 3 words distance", subtitle = "Nouns & Adjective")
    })

#Wordcloud for Nouns
    output$WordCloudNoun <-renderPlot({
        x <- udpipeDataFrame()
        nouns = subset(x,upos %in% 'NOUN')
        top_nouns = txt_freq(nouns$lemma)
        wordcloud(words = top_nouns$key,
                  freq = top_nouns$freq,
                  min.freq = 2,
                  max.words =  100,
                  random.order = FALSE,
                  colors = brewer.pal(6, "Dark2"))

    })

#WordCloud for Verbs    
    output$WordCloudVerb <-renderPlot({
      x <- udpipeDataFrame()
      verbs = subset(x,upos %in% 'VERB')
      top_verbs = txt_freq(verbs$lemma)
      wordcloud(words = top_verbs$key,
                freq = top_verbs$freq,
                min.freq = 2,
                max.words =  100,
                random.order = FALSE,
                colors = brewer.pal(6, "Dark2"))
      
    })
    
    
    #Download data as csv
    output$downloadCSV <- downloadHandler(
      filename = function() {
        paste(input$dataset, ".csv", sep = "DataFromShiny.csv")
      },
      content = function(file) {
        write.csv(article_tags(), file, row.names = FALSE)
      }
    )
    
})
