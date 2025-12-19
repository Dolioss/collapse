library(tidyverse)
library(igraph)
library(rgexf)

edges <- read_csv("edges.csv")
nodes <- read_csv("nodes.csv")

escape_xml <- function(x) {
  x %>%
    gsub("&", "&amp;", ., fixed = TRUE) %>%
    gsub("<", "&lt;",  ., fixed = TRUE) %>%
    gsub(">", "&gt;",  ., fixed = TRUE)
}

nodes_gexf <- nodes %>%
  transmute(
    id     = escape_xml(level2),
    label  = escape_xml(level2),
    freq   = as.numeric(freq),
    level1 = escape_xml(level1)
  )

edges_gexf <- edges %>%
  transmute(
    source = escape_xml(from),
    target = escape_xml(to),
    weight = as.numeric(weight)
  )

library(rgexf)

write.gexf(
  nodes = nodes_gexf[, c("id", "label")],  
  edges = edges_gexf[, c("source", "target")],
  
  nodesAtt = nodes_gexf[, c("freq", "level1")],
  edgesWeight = edges_gexf$weight,
  
  output = "network.gexf"
)

