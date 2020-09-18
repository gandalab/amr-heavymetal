# remove samples 66 and 67 from rumen

df <- as.data.frame(rum)

grep("G527_66", colnames(rum))
grep("G527_67", colnames(rum))

new <- df %>% 
  dplyr::select(-starts_with("G527_66")) %>% 
  select(-starts_with("G527_67"))



# get vector of sample names
samp <- colnames(as.data.frame(new)) 

# turn this into a 1-column dataframe to add farm info
df <- as.data.frame(samp)

# add farm info that is stored in sample names
meta <- df %>% 
  # get string for farm
  mutate(farm = str_extract(samp, "P(\\d)")) %>% 
  # change to farm A and B
  mutate(farm = factor(case_when(
    farm %in% "P1" ~ "A",
    farm %in% "P2" ~ "B"
  ) )) %>% 
  # make into rownames
  column_to_rownames(var = "samp") 

# DESeq requires the reference level to be set 
meta$farm <- relevel(meta$farm, ref = "B")

# and it needs to be in matrix format
metam <- as.matrix(meta)



# because DESeq2 is janky,  the names have to be in THE EXACT ORDER
all(colnames(new) == meta$sample)

# make DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = new,
                              colData = metam,
                              design = ~ farm)
dds 

# perform DeSeq testing
de <- DESeq(dds, test = "Wald", fitType = "mean")  # fit type should be non-para

# get results
res = results(de, cooksCutoff = FALSE, contrast = c("farm", "A", "B"))
# get only significant results
sigtab = res[which(res$padj < alpha), ]

# sort by log2fold change
sigtab <- sigtab[order(sigtab$log2FoldChange), ]

# make dataframe to save as text table
tab <- as.data.frame(sigtab) %>% 
  rownames_to_column(var = "Genus")
