if (!require(shiny)) {install.packages("shiny")}
if (!require(dplyr)) {install.packages("dplyr")}
if (!require(tidytext)) {install.packages("tidytext")}
if (!require(textrank)) {install.packages("textrank")}
if (!require(ggplot2)) {install.packages("ggplot2")}
if (!require(igraph)) {install.packages("igraph")}
if (!require(ggraph)) {install.packages("ggraph")}
if (!require(wordcloud)) {install.packages("wordcloud")}
if (!require(magrittr)) {install.packages("magrittr")}
if (!require(udpipe)) {install.packages("udpipe")}
if (!require(stringr)) {install.packages("stringr")}

library(shiny)
library(igraph)
library(ggraph)
library(ggplot2)
library(wordcloud)
library(dplyr)
library(tidytext)
library(magrittr)
library(udpipe)
library(stringr)