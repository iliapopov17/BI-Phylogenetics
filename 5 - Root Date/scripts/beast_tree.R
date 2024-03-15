library(ggtree)
#if (!require("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("treeio")

library(treeio)

felidae2percentTree <- read.beast("felidae_2percent-felidae_cytb.tree")
ggtree(felidae2percentTree) + 
  geom_tiplab() +
  xlim(0, 25) + 
  theme_tree2()
