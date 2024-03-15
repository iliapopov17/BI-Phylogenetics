args <- commandArgs(trailingOnly=TRUE)

library(ggtree)
tree_alrt_abayes_ufb <- read.tree(args[1])
ggtree(tree_alrt_abayes_ufb) + 
  geom_tiplab() + geom_nodelab() +
  geom_treescale() + xlim(0, 0.9)
# funny labels
label <- tree_alrt_abayes_ufb$node.label
alrt <- as.numeric(sapply(strsplit(label, "/"), FUN = "[", 1)) #sun
abayes <- as.numeric(sapply(strsplit(label, "/"), FUN = "[", 2)) #yin yang
ufb <- as.numeric(sapply(strsplit(label, "/"), FUN = "[", 3)) #star
large_alrt <- ifelse(alrt > 70, intToUtf8(9728), "")
large_abayes <- ifelse(abayes > 0.7, intToUtf8(9775), "")
large_ufb <- ifelse(ufb > 95, intToUtf8(9733), "")
newlabel <- paste0(large_alrt, large_abayes, large_ufb)
tree_alrt_abayes_ufb$node.label <- newlabel
ggtree(tree_alrt_abayes_ufb) + 
  geom_tiplab() + geom_nodelab(nudge_x = -.01, nudge_y = .1) +
  geom_treescale() + xlim(0, 0.9)

ggsave(args[2])