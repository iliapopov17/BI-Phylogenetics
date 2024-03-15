#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly=TRUE)

library(ggtree)
tr <- read.tree(args[1]) ##SUP35_raxml.raxml.bestTree
ggtree(tr) + geom_tiplab() + xlim(0,2) + 
  geom_treescale()

ggsave(args[2])