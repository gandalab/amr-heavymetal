# Working script; DeSeq2 on OTU at genus level


## get data
require(tidyverse)
require(DESeq2)
require(phyloseq)
set.seed(123)

# there are 3 text files for each anatomial site
dns <- read.table("./data/OTU_genus_DNS_nominitable.txt", header = TRUE, sep = "\t") %>% 
  pivot_longer(cols = 2:last_col(), names_to = "G", values_to = "count")

fec <- read.table("./data/OTU_genus_feces.txt", header = TRUE, sep = "\t") %>% 
  pivot_longer(cols = 2:last_col(), names_to = "G", values_to = "count")

rum <- read.table("./data/OTU_genus_rumen.txt", header = TRUE, sep = "\t") %>% 
  pivot_longer(cols = 2:last_col(), names_to = "G", values_to = "count")

both <- rbind(fec, dns, rum) %>% 
  pivot_wider(names_from = G, values_from = count, values_fill = 0) 

# need genus on rows and samples in columns
df <- dns %>% 
  pivot_longer(cols = 2:last_col(), names_to = "G", values_to = "count") %>% 
  pivot_wider(names_from = genus, values_from = count, values_fill = 0) %>% 
  drop_na() %>% 
  column_to_rownames(var = "G")

dfm <- as.matrix(df)

# need metadata matrix with farm info
meta <- both %>% 
  select(genus) %>% 
  rename(genus = "sample") %>% 
  mutate(farm = str_extract(sample, "P(\\d)")) %>% 
  mutate(farm = factor(case_when(
    farm %in% "P1" ~ "A",
    farm %in% "P2" ~ "B"
  ) )) %>% 
  column_to_rownames(var = "sample") 
meta$farm <- relevel(meta$farm, ref = "B")

metam <- as.matrix(meta)



# because DESeq2 was written by morons, the names have to be in THE EXACT ORDER
all(colnames(df)[2:ncol(df)] == meta$sample)

# make DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = dfm,
                              colData = metam,
                              design = ~ farm)
dds

# perform DeSeq testing
de <- DESeq(dds, test = "Wald", fitType = "mean")  # fit type should be non-para

# get results
res = results(de, cooksCutoff = FALSE)
alpha = 0.05
sigtab = res[which(res$padj < alpha), ]
head(sigtab)

# sort by log2fold change
sigtab <- sigtab[order(sigtab$log2FoldChange), ]

# make dataframe to save as text table
tab <- as.data.frame(sigtab) %>% 
  rownames_to_column(var = "Genus")

# write results to file
write.table(tab, file = "./data/DESeq-results-genus.txt", sep = "\t", row.names = FALSE)
