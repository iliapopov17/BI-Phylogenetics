# Drawing Trees

## Part 1 - `R`

### Part 1.1 - `library(ape)`

1) Read tree `(((A,B),(C,D)),E);` from text into `simpletree` object

```r
simpletree <- read.tree(text = "(((A,B), (C,D)), E);")
```

2) Draw `simpletree` using standard function from `ape` package

```r
plot.phylo(simpletree)
```

3) Save this tree in raster format (png) and vector format (svg or pdf)

```r
png("simpletree.png")
plot.phylo(simpletree)
dev.off()

svg("simpletree.svg", width = 4, height = 4)
plot.phylo(simpletree)
dev.off()
```

4) Read the file https://www.jasondavies.com/tree-of-life/life.txt into the `treeoflife` object

```r
treeoflife <- read.tree("https://www.jasondavies.com/tree-of-life/life.txt")
```

5) Draw a `treeoflife` using a standard function from the `ape` package and save this tree in any format we like

```r
plot.phylo(treeoflife, cex = 0.2)

png(filename = "treeOfLife.png", width = 20, height = 20, units = "cm", res = 600)
plot.phylo(treeoflife, cex = 0.2)
dev.off()
```

6) Draw `treeoflife` unrooted or circular

```r
plot.phylo(treeoflife, type = "unrooted", no.margin = T, cex = 0.2)

plot.phylo(treeoflife, type = "radial", cex = 0.2)
```

### Part 1.2 - `library(ggtree)`

7) Draw treeoflife using ggtree with minimal settings

```r
treeoflife_text <- readLines("https://www.jasondavies.com/tree-of-life/life.txt")

treeoflife <- ggtree::read.tree(text = treeoflife_text)
ggtree(treeoflife)
```

8) Draw treeoflife with ggtree so that the inscriptions are readable

```r
ggtree(treeoflife) + geom_tiplab(size = 1)
```

9) Draw treeoflife in a circular shape with readable inscriptions.

```r
ggtree(treeoflife) + layout_circular() + geom_tiplab(size = 2)
```
   
10) Draw treeoflife with additional highlighting of some part of it.

```r
treeoflife <- groupOTU(treeoflife, c("Homo_sapiens", "Pan_troglodytes"))
ggtree(treeoflife) + layout_circular() +
  geom_tiplab2(size = 2) + geom_tippoint(aes(alpha = group), col = "red") +
  scale_color_manual(values = c(0,1), aesthetics = "alpha") +
  theme(legend.position = 'null')
```

## Part 2 - `Python`

### Part 2.1 - `Bio::Phylo`

```python
import random
from io import StringIO

import matplotlib
import requests
from Bio import Phylo
from ete3 import Tree, TreeStyle, NodeStyle
```
11) Read the tree https://www.jasondavies.com/tree-of-life/life.txt

```python
raw_tree = StringIO(requests.get('https://www.jasondavies.com/tree-of-life/life.txt').text) tree1 = Phylo.read(raw_tree, "newick")
```

12) Draw this tree with pseudo-graphics (draw_ascii)

```python
Phylo.draw_ascii(tree1)
```

13) Draw a tree with draw

```python
Phylo.draw(tree1, do_show = False)
```

14) Save the tree image in raster (png) and vector (svg/pdf) formats

```python
Phylo.draw(tree1, do_show = False)
matplotlib.pyplot.savefig("py_tree1_phylo.png")
matplotlib.pyplot.savefig("py_tree1_phylo.pdf")
```

15) Draw the tree in a more or less readable form

```python
matplotlib.rc('font', size=1) matplotlib.pyplot.figure(figsize=(24,12))
Phylo.draw(tree1, do_show = False) matplotlib.pyplot.savefig("py_tree1_phylo_enhanced.png", dpi=600)
```

### Part 2.2 - `Python: ETE (ETE3)`

16) Read a simple tree (((A,B),(C,D)),E) from the text

```python
simpletree = Tree("(((A,B), (C,D)), E);")
```

17) Save this tree to a file

```python
simpletree.render("simpletree.png", w=183, units="mm") ;
```

18) Read the tree https://www.jasondavies.com/tree-of-life/life.txt and draw this tree with default settings

```python
raw_tree = requests.get('https://www.jasondavies.com/tree-of-life/life.txt').text tree2 = Tree(raw_tree, format=1)
tree2.render("py_tree2_ete3.pdf") ;
```

19) Draw this tree circular

```python
circular_style = TreeStyle()
circular_style.mode = "c"
circular_style.scale = 20
tree2.render("py_tree2_ete3_circ.pdf", tree_style=circular_style) ;
```

20) Draw this treeoflife with additional highlighting of some part of your choice

```python
nst1 = NodeStyle()
nst1["bgcolor"] = "LightSteelBlue"
n1 = tree2.get_common_ancestor("Homo_sapiens", "Danio_rerio") n1.set_style(nst1)
tree2.render("py_tree2_ete3_vertebrates.png", tree_style=circular_style) ;
```
