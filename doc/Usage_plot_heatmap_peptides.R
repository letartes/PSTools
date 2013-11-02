# Load some data
setwd("~/Dropbox/code/git/PSTools")
peptides.df <- read.csv("data/enolase_runs.csv")
fasta <- read.table("data/eno1.fasta", sep="\t", header=TRUE)
eno <- as.character(fasta[1,1])

# Load the function and run it
source("code/plot_heatmap_peptides.R")
p <- plot.heatmap.peptide(peptides.df, eno)
p
ggsave(p, file="figures/barchart_aa.png", width = 12, height = 7)


