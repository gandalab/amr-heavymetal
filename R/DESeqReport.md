DESeq
================
Emily Bean
9/14/2020

## Differential abundance analysis at the genus level

This script reads in OTU tables generated in MG-RAST for farm A and farm
B in fecal, rumen fluid, and DNS samples. Differential abundance
analysis is performed at the genus level for differences between farms
at each body site.

``` r
## get data
require(tidyverse)
```

    ## Loading required package: tidyverse

    ## ── Attaching packages ────────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
    ## ✓ tibble  3.0.1     ✓ dplyr   1.0.0
    ## ✓ tidyr   1.1.0     ✓ stringr 1.4.0
    ## ✓ readr   1.3.1     ✓ forcats 0.5.0

    ## ── Conflicts ───────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
require(DESeq2)
```

    ## Loading required package: DESeq2

    ## Loading required package: S4Vectors

    ## Loading required package: stats4

    ## Loading required package: BiocGenerics

    ## Loading required package: parallel

    ## 
    ## Attaching package: 'BiocGenerics'

    ## The following objects are masked from 'package:parallel':
    ## 
    ##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
    ##     clusterExport, clusterMap, parApply, parCapply, parLapply,
    ##     parLapplyLB, parRapply, parSapply, parSapplyLB

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     combine, intersect, setdiff, union

    ## The following objects are masked from 'package:stats':
    ## 
    ##     IQR, mad, sd, var, xtabs

    ## The following objects are masked from 'package:base':
    ## 
    ##     anyDuplicated, append, as.data.frame, basename, cbind, colnames,
    ##     dirname, do.call, duplicated, eval, evalq, Filter, Find, get, grep,
    ##     grepl, intersect, is.unsorted, lapply, Map, mapply, match, mget,
    ##     order, paste, pmax, pmax.int, pmin, pmin.int, Position, rank,
    ##     rbind, Reduce, rownames, sapply, setdiff, sort, table, tapply,
    ##     union, unique, unsplit, which, which.max, which.min

    ## 
    ## Attaching package: 'S4Vectors'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     first, rename

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     expand

    ## The following object is masked from 'package:base':
    ## 
    ##     expand.grid

    ## Loading required package: IRanges

    ## 
    ## Attaching package: 'IRanges'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     collapse, desc, slice

    ## The following object is masked from 'package:purrr':
    ## 
    ##     reduce

    ## Loading required package: GenomicRanges

    ## Loading required package: GenomeInfoDb

    ## Loading required package: SummarizedExperiment

    ## Loading required package: Biobase

    ## Welcome to Bioconductor
    ## 
    ##     Vignettes contain introductory material; view with
    ##     'browseVignettes()'. To cite Bioconductor, see
    ##     'citation("Biobase")', and for packages 'citation("pkgname")'.

    ## Loading required package: DelayedArray

    ## Loading required package: matrixStats

    ## 
    ## Attaching package: 'matrixStats'

    ## The following objects are masked from 'package:Biobase':
    ## 
    ##     anyMissing, rowMedians

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     count

    ## 
    ## Attaching package: 'DelayedArray'

    ## The following objects are masked from 'package:matrixStats':
    ## 
    ##     colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges

    ## The following object is masked from 'package:purrr':
    ## 
    ##     simplify

    ## The following objects are masked from 'package:base':
    ## 
    ##     aperm, apply, rowsum

``` r
require(phyloseq)
```

    ## Loading required package: phyloseq

    ## 
    ## Attaching package: 'phyloseq'

    ## The following object is masked from 'package:SummarizedExperiment':
    ## 
    ##     distance

    ## The following object is masked from 'package:Biobase':
    ## 
    ##     sampleNames

    ## The following object is masked from 'package:GenomicRanges':
    ## 
    ##     distance

    ## The following object is masked from 'package:IRanges':
    ## 
    ##     distance

``` r
set.seed(123)

# set alpha
alpha = 0.05

# there are 3 text files, one for each anatomical site
# for DEseq format, need genus on rows and samples in columns

dns <- read.table("./data/OTU_genus_DNS.txt", header = TRUE, sep = "\t") %>% 
  # pivot long by genus
  pivot_longer(cols = 2:last_col(), names_to = "G", values_to = "count") %>%
  # spread back out by sample name
  pivot_wider(names_from = genus, values_from = count, values_fill = 0) %>% 
  # get rid of NA
  drop_na() %>% 
  # make genus into rownames for DESeq
  column_to_rownames(var = "G")

# also needs to be in matrix format
dns <- as.matrix(dns)

fec <- read.table("./data/OTU_genus_feces.txt", header = TRUE, sep = "\t") %>% 
  # pivot long by genus
  pivot_longer(cols = 2:last_col(), names_to = "G", values_to = "count") %>%
  # spread back out by sample name
  pivot_wider(names_from = genus, values_from = count, values_fill = 0) %>% 
  # get rid of NA
  drop_na() %>% 
  # make genus into rownames for DESeq
  column_to_rownames(var = "G")

# also needs to be in matrix format
fec <- as.matrix(fec)

rum <- read.table("./data/OTU_genus_rumen.txt", header = TRUE, sep = "\t")  %>% 
# pivot long by genus
  pivot_longer(cols = 2:last_col(), names_to = "G", values_to = "count") %>%
  # spread back out by sample name
  pivot_wider(names_from = genus, values_from = count, values_fill = 0) %>% 
  # get rid of NA
  drop_na() %>% 
  # make genus into rownames for DESeq
  column_to_rownames(var = "G")

# also needs to be in matrix format
rum <- as.matrix(rum)
```

### DNS

DESeq requires a separate matrix with metadata (categorical information)
and it needs to be structured properly for the janky software to work
properly.

``` r
# get vector of sample names
samp <- colnames(as.data.frame(dns)) 

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
```

The DEseq protocol runs in the chunk below.

``` r
# because DESeq2 is janky,  the names have to be in THE EXACT ORDER
all(colnames(dns) == meta$sample)
```

    ## [1] TRUE

``` r
# make DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = dns,
                              colData = metam,
                              design = ~ farm)
dds 
```

    ## class: DESeqDataSet 
    ## dim: 594 30 
    ## metadata(1): version
    ## assays(1): counts
    ## rownames(594): Abiotrophia Acaryochloris ...
    ##   unclassified..derived.from.Vibrionaceae.
    ##   unclassified..derived.from.Vibrionales.
    ## rowData names(0):
    ## colnames(30): G527_33_P1A11_SNP_S33_R G527_34_P1A13_SNP_S34_R ...
    ##   G527_90_P2A29_SNP_S90_R G527_91_P2A7_SNP_S91_R
    ## colData names(1): farm

``` r
# perform DeSeq testing
de <- DESeq(dds, test = "Wald", fitType = "mean")  # fit type should be non-para
```

    ## estimating size factors

    ## estimating dispersions

    ## gene-wise dispersion estimates

    ## mean-dispersion relationship

    ## final dispersion estimates

    ## fitting model and testing

    ## -- replacing outliers and refitting for 61 genes
    ## -- DESeq argument 'minReplicatesForReplace' = 7 
    ## -- original counts are preserved in counts(dds)

    ## estimating dispersions

    ## fitting model and testing

``` r
# get results
res = results(de, cooksCutoff = FALSE, contrast = c("farm", "A", "B"))
# get only significant results
sigtab = res[which(res$padj < alpha), ]

# sort by log2fold change
sigtab <- sigtab[order(sigtab$log2FoldChange), ]

# make dataframe to save as text table
tab <- as.data.frame(sigtab) %>% 
  rownames_to_column(var = "Genus")

# write results to file
write.table(tab, file = "./data/DESeq-results-DNS.txt", sep = "\t", row.names = FALSE)

# get only top and bottom 25 to visualize

top <- rbind(tab %>% slice_head(n = 25),
             tab %>% slice_tail(n = 25))

write.table(top, file = "./data/DESeq-results-DNS-top.txt", sep = "\t", row.names = FALSE)
```

There are 297 significant genuses (geni?) out of 593 total in the DNS
swabs between farm A and B.

### Rumen

DESeq requires a separate matrix with metadata (categorical information)
and it needs to be structured properly for the janky software to work
properly.

``` r
# get vector of sample names
samp <- colnames(as.data.frame(rum)) 

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
```

The DEseq protocol runs in the chunk below.

``` r
# because DESeq2 is janky,  the names have to be in THE EXACT ORDER
all(colnames(rum) == meta$sample)
```

    ## [1] TRUE

``` r
# make DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = rum,
                              colData = metam,
                              design = ~ farm)
dds 
```

    ## class: DESeqDataSet 
    ## dim: 600 28 
    ## metadata(1): version
    ## assays(1): counts
    ## rownames(600): Abiotrophia Acaryochloris ...
    ##   unclassified..derived.from.Vibrionaceae.
    ##   unclassified..derived.from.Vibrionales.
    ## rowData names(0):
    ## colnames(28): G527_17_P1A11_rumen_S17_R G527_18_P1A13_rumen_S18_R ...
    ##   G527_76_P2A28_rumen_S76_R G527_77_P2A29_rumen_S77_R
    ## colData names(1): farm

``` r
# perform DeSeq testing
de <- DESeq(dds, test = "Wald", fitType = "mean")  # fit type should be non-para
```

    ## estimating size factors

    ## estimating dispersions

    ## gene-wise dispersion estimates

    ## mean-dispersion relationship

    ## final dispersion estimates

    ## fitting model and testing

    ## -- replacing outliers and refitting for 89 genes
    ## -- DESeq argument 'minReplicatesForReplace' = 7 
    ## -- original counts are preserved in counts(dds)

    ## estimating dispersions

    ## fitting model and testing

``` r
# get results
res = results(de, cooksCutoff = FALSE, contrast = c("farm", "A", "B"))
# get only significant results
sigtab = res[which(res$padj < alpha), ]

# sort by log2fold change
sigtab <- sigtab[order(sigtab$log2FoldChange), ]

# make dataframe to save as text table
tab <- as.data.frame(sigtab) %>% 
  rownames_to_column(var = "Genus")

# write results to file
write.table(tab, file = "./data/DESeq-results-rumen.txt", sep = "\t", row.names = FALSE)

# get only top and bottom 25 to visualize

top <- rbind(tab %>% slice_head(n = 25),
             tab %>% slice_tail(n = 25))

write.table(top, file = "./data/DESeq-results-rumen-top.txt", sep = "\t", row.names = FALSE)
```

There are 50 significant genuses out of 600 in the rumen samples.

### Feces

DESeq requires a separate matrix with metadata (categorical information)
and it needs to be structured properly for the janky software to work
properly.

``` r
# get vector of sample names
samp <- colnames(as.data.frame(fec)) 

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
```

The DEseq protocol runs in the chunk below.

``` r
# because DESeq2 is janky,  the names have to be in THE EXACT ORDER
all(colnames(fec) == meta$sample)
```

    ## [1] TRUE

``` r
# make DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = fec,
                              colData = metam,
                              design = ~ farm)
dds 
```

    ## class: DESeqDataSet 
    ## dim: 600 31 
    ## metadata(1): version
    ## assays(1): counts
    ## rownames(600): Abiotrophia Acaryochloris ...
    ##   unclassified..derived.from.Vibrionaceae.
    ##   unclassified..derived.from.Vibrionales.
    ## rowData names(0):
    ## colnames(31): G527_1_P1A11_feces_S1_R G527_2_P1A13_feces_S2_R ...
    ##   G527_63_P2A7_feces_S63_R G527_64_P2A9_feces_S64_R
    ## colData names(1): farm

``` r
# perform DeSeq testing
de <- DESeq(dds, test = "Wald", fitType = "mean")  # fit type should be non-para
```

    ## estimating size factors

    ## estimating dispersions

    ## gene-wise dispersion estimates

    ## mean-dispersion relationship

    ## final dispersion estimates

    ## fitting model and testing

    ## -- replacing outliers and refitting for 30 genes
    ## -- DESeq argument 'minReplicatesForReplace' = 7 
    ## -- original counts are preserved in counts(dds)

    ## estimating dispersions

    ## fitting model and testing

``` r
# get results
res = results(de, cooksCutoff = FALSE, contrast = c("farm", "A", "B"))
# get only significant results
sigtab = res[which(res$padj < alpha), ]

# sort by log2fold change
sigtab <- sigtab[order(sigtab$log2FoldChange), ]

# make dataframe to save as text table
tab <- as.data.frame(sigtab) %>% 
  rownames_to_column(var = "Genus")

# write results to file
write.table(tab, file = "./data/DESeq-results-feces.txt", sep = "\t", row.names = FALSE)

# get only top and bottom 25 to visualize

top <- rbind(tab %>% slice_head(n = 25),
             tab %>% slice_tail(n = 25))

write.table(top, file = "./data/DESeq-results-feces-top.txt", sep = "\t", row.names = FALSE)
```

There are 220 significant genuses out of 600 in the fecal samples.
