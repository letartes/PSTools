Usng the plot_heatmap_peptides function
========================================================

Plots heat map of peptide hits over the sequece of the protein.
Takes data frame with one column labeled peptide containing the peptides sequences and a character vector containing the sequence of the protein onto which the peptides should be mapped. 

Let's load some data...


```r
# Load some data
library(ggplot2)
setwd("~/Dropbox/code/git/PSTools")
peptides.df <- read.csv("data/enolase_runs.csv")
fasta <- read.table("data/eno1.fasta", sep = "\t", header = TRUE)
eno <- as.character(fasta[1, 1])

# Load the function and run it
source("code/plot_heatmap_peptides.R")
p <- plot.heatmap.peptide(peptides.df, eno)
p
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 

