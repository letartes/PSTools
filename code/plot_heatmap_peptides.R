plot.heatmap.peptide <- function(peptides.df, protein){
  # Plots heat map of peptide hits over the sequece of the protein.
  # Takes data frame with one column labeled peptide containing the peptides sequences.
  # and a character vector containing the sequence of the protein onto which
  # the peptides should be mapped. 
  
  require(ggplot2) 
  # if peptide header is called "sequence" make "peptide" column name
   if (sum(names(peptides.df)=="Sequence")>=1) {
       names(peptides.df)[names(peptides.df)=="Sequence"] <- "peptide"
   }
    
  # explode string into data frame
  protein.df<-data.frame(strsplit(protein, ""), position=1:nchar(protein))
  colnames(protein.df)[1] <- "aa"
  protein.df$aa <- as.character(protein.df$aa)
  
  # find beginning and end of each peptide
  for (i in 1:length(peptides.df$peptide)){
    pos <- regexpr(toupper(peptides.df$peptide[i]), protein)
    peptides.df$start[i] <- pos[1]
    peptides.df$end[i] <- peptides.df$start[i] + attr(pos,"match.length")
    }
  
  # initialize empty df
  protein.df$counts <- rep(0, nchar(protein))
  
  # add 1 to the counts when a a sequence is found
  for (i in 1:length(peptides.df$peptide)) {
    protein.df[peptides.df$start[i]:peptides.df$end[i], 3] <-  protein.df[peptides.df$start[i]:peptides.df$end[i], 3] + 1
  }
  protein.df <- protein.df[1:nchar(protein), ] 
  # prepare display
  length.of.display <- 50
  protein.length <- nchar(protein)
  nb.of.rows <- (nchar(protein) %/% length.of.display) + 1
  protein.df$row <- rep(nb.of.rows:1, each=length.of.display, len=protein.length)
  protein.df$col <- rep(1:length.of.display,  len=protein.length)
  
  ## plot heatmap
  p <- ggplot(protein.df, aes(x=col, y=row, fill=counts, label=aa)) + ggtitle("Cumulative Protein Coverage")
  p <- p + geom_tile(stat="identity") + geom_text(colour="black")
  p <- p + xlab("index") + ylab("position")
  p <- p + scale_y_continuous(breaks=seq(nb.of.rows, 1, by=-1), labels=seq(1, protein.length, by=length.of.display))
  p <- p + theme_bw() + scale_fill_gradient(low='white', high='red') 
  p
  # ggsave(p, file="figures/heatmap_aa.png", width=12, height=7)
  return(p) 
}
