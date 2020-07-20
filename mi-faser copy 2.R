############################################################################################
#----------------------------mi-faser: functional annotation-------------------------------#
############################################################################################

#here we format mi-faser output for use in WEKA 
#downloaded output files as .csv from https://services.bromberglab.org/mifaser/myresults
##first manually add sample name and metadata as new columns in all excel files


setwd("~/Documents/AMR_Brazil")


#import and create giant table with all mi-faser data

S1 <- read.csv("G527_1_P1A11_feces_S1.csv")  #S1 is Sample 1
all = rbind(S1, read.csv("G527_2_P1A13_feces_S2.csv"))
all = rbind(all, read.csv("G527_3_P1A14_feces_S3.csv"))
all = rbind(all, read.csv("G527_4_P1A19_feces_S4.csv"))
all = rbind(all, read.csv("G527_5_P1A2_feces_S5.csv"))
all = rbind(all, read.csv("G527_6_P1A20_feces_S6.csv"))
all = rbind(all, read.csv("G527_7_P1A22_feces_S7.csv"))
all = rbind(all, read.csv("G527_8_P1A24_feces_S8.csv"))
all = rbind(all, read.csv("G527_9_P1A25_feces_S9.csv"))
all = rbind(all, read.csv("G527_10_P1A26_feces_S10.csv"))
all = rbind(all, read.csv("G527_11_P1A28_feces_S11.csv"))
all = rbind(all, read.csv("G527_12_P1A29_feces_S12.csv"))
all = rbind(all, read.csv("G527_13_P1A4_feces_S13.csv"))
all = rbind(all, read.csv("G527_14_P1A7_feces_S14.csv"))
all = rbind(all, read.csv("G527_15_P1_A8_feces_S15.csv"))
all = rbind(all, read.csv("G527_16_P1A9_feces_S16.csv"))
all = rbind(all, read.csv("G527_17_P1A11_rumen_S17.csv"))
all = rbind(all, read.csv("G527_18_P1A13_rumen_S18.csv"))
all = rbind(all, read.csv("G527_19_P1A14_rumen_S19.csv"))
all = rbind(all, read.csv("G527_20_P1A19_rumen_S20.csv"))
all = rbind(all, read.csv("G527_21_P1A2_rumen_S21.csv"))
all = rbind(all, read.csv("G527_22_P1A20_rumen_S22_.csv"))
all = rbind(all, read.csv("G527_23_P1A218_rumen_S23.csv"))
all = rbind(all, read.csv("G527_24_P1A22_rumen_S24.csv"))
all = rbind(all, read.csv("G527_25_P1A24_rumen_S25.csv"))
all = rbind(all, read.csv("G527_26_P1A25_rumen_S26.csv"))
all = rbind(all, read.csv("G527_27_P1A26_rumen_S27.csv"))
all = rbind(all, read.csv("G527_28_P1A29_rumen_S28.csv"))
all = rbind(all, read.csv("G527_29_P1A4_rumen_S29.csv"))
all = rbind(all, read.csv("G527_30_P1A7_rumen_S30.csv"))
all = rbind(all, read.csv("G527_31_P1A8_rumen_S31.csv"))
all = rbind(all, read.csv("G527_32_P1A9_rumen_S32.csv"))
all = rbind(all, read.csv("G527_33_P1A11_SNP_S33.csv"))
all = rbind(all, read.csv("G527_34_P1A13_SNP_S34.csv"))
all = rbind(all, read.csv("G527_35_P1A14_SNP_S35.csv"))
all = rbind(all, read.csv("G527_36_P1A19_SNP_S36.csv"))
all = rbind(all, read.csv("G527_37_P1A2_SNP_S37.csv"))
all = rbind(all, read.csv("G527_38_P1A20_SNP_S38.csv"))
all = rbind(all, read.csv("G527_39_P1A22_ANP_S39.csv"))
all = rbind(all, read.csv("G527_40_P1A24_SNP_S40.csv"))
all = rbind(all, read.csv("G527_41_P1A25_SNP_S41.csv"))
all = rbind(all, read.csv("G527_42_P1A26_SNP_S42.csv"))
all = rbind(all, read.csv("G527_43_P1A28_SNP_S43.csv"))
all = rbind(all, read.csv("G527_44_P1A29_SNP_S44.csv"))
all = rbind(all, read.csv("G527_45_P1A4_SNP_S45.csv"))
all = rbind(all, read.csv("G527_46_P1A7_SNP_S46.csv"))
all = rbind(all, read.csv("G527_47_P1A8_SNP_S47.csv"))
all = rbind(all, read.csv("G527_48_P1A9_SNP_S48.csv"))
all = rbind(all, read.csv("G527_50_P2A1_feces_S50.csv"))
all = rbind(all, read.csv("G527_51_P2A10_feces_S51.csv"))
all = rbind(all, read.csv("G527_52_P2A14_feces_S52.csv"))
all = rbind(all, read.csv("G527_53_P2A16_feces_S53.csv"))
all = rbind(all, read.csv("G527_54_P2A18_feces_S54.csv"))
all = rbind(all, read.csv("G527_55_P2A19_feces_S55.csv"))
all = rbind(all, read.csv("G527_56_P2A20_feces_S56.csv"))
all = rbind(all, read.csv("G527_57_P2A21_feces_S57.csv"))
all = rbind(all, read.csv("G527_58_P2A22_feces_S58.csv"))
all = rbind(all, read.csv("G527_59_P2A26_feces_S59.csv"))
all = rbind(all, read.csv("G527_60_P2A27_feces_S60.csv"))
all = rbind(all, read.csv("G527_61_P2A28_feces_S61.csv"))
all = rbind(all, read.csv("G527_62_P2A29_feces_S62.csv"))
all = rbind(all, read.csv("G527_63_P2A7_feces_S63.csv"))
all = rbind(all, read.csv("G527_64_P2A9_feces_S64.csv"))
all = rbind(all, read.csv("G527_65_P2A1_rumen_S65.csv"))
all = rbind(all, read.csv("G527_66_P2A10_rumen_S66.csv"))
all = rbind(all, read.csv("G527_67_P2A14_rumen_S67.csv"))
all = rbind(all, read.csv("G527_68_P2A16_rumen_S68.csv"))
all = rbind(all, read.csv("G527_69_P2A18_rumen_S69.csv"))
all = rbind(all, read.csv("G527_70_P2A19_rumen_S70.csv"))
all = rbind(all, read.csv("G527_71_P2A20_rumen_S71.csv"))
all = rbind(all, read.csv("G527_72_P2A21_rumen_S72.csv"))
all = rbind(all, read.csv("G527_73_P2A22_rumen_S73.csv"))
all = rbind(all, read.csv("G527_74_P2A26_rumen_S74.csv"))
all = rbind(all, read.csv("G527_75_P2A27_rumen_S75.csv"))
all = rbind(all, read.csv("G527_76_P2A28_rumen_S76.csv"))
all = rbind(all, read.csv("G527_77_P2A29_rumen_S77.csv"))
all = rbind(all, read.csv("G527_78_P2A1_SNP_S78.csv"))
all = rbind(all, read.csv("G527_79_P2A10_SNP_S79.csv"))
all = rbind(all, read.csv("G527_80_P2A14_SNP_S80.csv"))
all = rbind(all, read.csv("G527_81_P2A16_SNP_S81.csv"))
all = rbind(all, read.csv("G527_82_P2A18_SNP_S82.csv"))
all = rbind(all, read.csv("G527_83_P2A19_SNP_S83.csv"))
all = rbind(all, read.csv("G527_84_P2A20_SNP_S84.csv"))
all = rbind(all, read.csv("G527_85_P2A21_SNP_S85.csv"))
all = rbind(all, read.csv("G527_86_P2A22_SNP_S86.csv"))
all = rbind(all, read.csv("G527_87_P2A26_SNP_S87.csv"))
all = rbind(all, read.csv("G527_88_P2A27_SNP_S88.csv"))
all = rbind(all, read.csv("G527_89_P2A28_SNP_S89.csv"))
all = rbind(all, read.csv("G527_90_P2A29_SNP_S90.csv"))
all = rbind(all, read.csv("G527_91_P2A7_SNP_S91.csv"))
all = rbind(all, read.csv("G527_92_P2A9_SNP_S92.csv"))

#remove the metadata columns except index or "spread" evidently won't work....
all1 = all[,-c(3, 5, 6, 7)]   

#transpose data so rows are unique samples, columns are EC, and values are reads
library("tidyr")
allTable = spread(all1, "Enzyme.E.C..", "Read.Count", fill = 0, convert = TRUE)

#normalize reads according to the total read count in each metagenome 
k = length(allTable[,1])
j = length(allTable[1,])-1
for(i in 1:k){
  allTable[i,][2:j] <- (allTable[i,][2:j]/sum(allTable[i,][2:j]))*100000
}

#now we'll go back and append metadata to this new table by sample ID
met <- all[!duplicated(all$Sample),]
met = met[,-c(2,3, 4)]
allTable1 <- merge(met, allTable, by = "Sample")
head(allTable1[1:6])

#export table
write.table(allTable1, file="BZ-AMR_mi-faser_WEKA.csv", row.names=FALSE, 
            col.names=TRUE, sep=",", quote = FALSE)

#use WEKA from here-------------------------------------------------------------------------#
#create Farm by Site variable (CID) using =CONCATENATE in excel
#open WEKA explorer
#Under Preprocess, import BZ-AMR_mi-faser_WEKA.csv
#Go to Select Attributes, choose InfoGainAttributeEval and Ranker search method
#Run algorithm 3 times against nominal classes of "Farm", "Farm by Site", and "Site" alone



#HEAT MAPS----------------------------------------------------------------------------------#
#show how represented these top 10 informative ECs are by farm and site---------------------#

#InfoGain against nominal class "Farm" only##################################################
#(these ECs provide most information in predicting Farm)

keep.FARM <- c("Sample", "Farm", "Site", "1.1.1.49", "2.7.7.7", "2.8.4.3", "6.3.5.5", 
               "2.5.1.7", "2.1.1.74", "3.1.3.16", "2.3.1.191", "2.7.7.8", "2.4.2.14")

#reduce dataset to include only informative ECs and metadata
IG.FARM <- allTable1[keep.FARM]

#stack data such that "variable" is EC and "value" is read count
library(reshape2)
test <- melt(IG.FARM, id = c("Sample", "Farm", "Site"))
head(test)

library(ggplot2)
test1 <- test
test1$value = as.numeric(test1$value)

#change the order the ECs are listed (by mean read count per EC, heatmap will be prettier)
test1$variable <- reorder(test1$variable, test1$value, FUN=mean)

p <- ggplot(test1, aes(x=Sample, y=variable, fill=value))
p
p + geom_tile() + scale_fill_gradient(low="white", high="red") + 
  theme_classic() + geom_vline(xintercept=c(16.5,32.5,48.5,64.5,77.5), 
                               linetype="dashed", color = "grey") + 
  scale_x_continuous(breaks=c(8, 24, 40, 55, 70, 84), 
                     labels=c("feces", "rumen", "DNS", "feces", "rumen", "DNS")) + 
  theme(axis.ticks = element_blank()) + xlab("Individual Metagenome") + 
  ylab("Informative E.C.s") 

ggsave("heat-FARM.png", width = 18, height = 5, unit = "cm", dpi=300)




#InfoGain against nominal class "Site" only##################################################
#(these ECs provide most information in predicting Farm)

keep.SITE <- c("Sample", "Farm", "Site", "1.5.1.43", "3.1.1.73", "1.1.1.271", "5.4.2.11", 
          "5.1.3.11", "1.1.1.192", "3.2.1.80", "2.5.1.47", "4.2.1.45", "1.11.1.22")

#reduce dataset to include only informative ECs
IG.SITE <- allTable1[keep.SITE]

#stack data such that "variable" is EC and "value" is read count
library(reshape2)
test <- melt(IG.SITE, id = c("Sample", "Farm", "Site"))
head(test)

library(ggplot2)
test1 <- test
test1$value = as.numeric(test1$value)

#change the order the ECs are listed (by mean read count per EC, heatmap will be prettier)
test1$variable <- reorder(test1$variable, test1$value, FUN=mean)

p <- ggplot(test1, aes(x=Sample, y=variable, fill=value))
p
p + geom_tile() + scale_fill_gradient(low="white", high="blue") + 
  theme_classic() + geom_vline(xintercept=c(16.5,32.5,48.5,64.5,77.5), 
                               linetype="dashed", color = "grey") + 
  scale_x_continuous(breaks=c(8, 24, 40, 55, 70, 84), 
                     labels=c("feces", "rumen", "DNS", "feces", "rumen", "DNS")) + 
  theme(axis.ticks = element_blank()) + xlab("Individual Metagenome") + 
  ylab("Informative E.C.s") 

ggsave("heat-SITE.png", width = 18, height = 5, unit = "cm", dpi=300)



#InfoGain against nominal class "Farm-Site"##################################################
#(these ECs provide most information in predicting Farm)

keep.FS <- c("Sample", "Farm", "Site", "1.4.7.1", "6.5.1.2", "6.3.5.4", "3.6.1.27", 
             "2.7.1.162", "4.2.2.23", "3.2.1.156", "3.4.21.116", "1.5.1.43", "3.1.1.96")

#reduce dataset to include only informative ECs
IG.FS <- allTable1[keep.FS]

#stack data such that "variable" is EC and "value" is read count
library(reshape2)
test <- melt(IG.FS, id = c("Sample", "Farm", "Site"))
head(test)

library(ggplot2)
test1 <- test
test1$value = as.numeric(test1$value)

#change the order the ECs are listed (by mean read count per EC, heatmap will be prettier)
test1$variable <- reorder(test1$variable, test1$value, FUN=mean)

p <- ggplot(test1, aes(x=Sample, y=variable, fill=value))
p
p + geom_tile() + scale_fill_gradient(low="white", high="darkgreen") + 
  theme_classic() + geom_vline(xintercept=c(16.5,32.5,48.5,64.5,77.5), 
                               linetype="dashed", color = "grey") + 
  scale_x_continuous(breaks=c(8, 24, 40, 57, 71, 85), 
                     labels=c("feces", "rumen", "DNS", "feces", "rumen", "DNS")) + 
  theme(axis.ticks = element_blank()) + xlab("Individual Metagenome") + 
  ylab("Informative E.C.s") 

ggsave("heat-FS.png", width = 18, height = 5, unit = "cm", dpi=300)




#STRATIFIED READ COUNTS---------------------------------------------------------------------#
#are these informative ECs overrepresented in any nominal level?----------------------------#

#for WEKA ranked ECs against FARM############################################################
IGF.A <- IG.FARM[which(IG.FARM$Farm==1),]
IGF.B <- IG.FARM[which(IG.FARM$Farm==2),]

summary(IGF.A$`1.1.1.49`)
summary(IGF.B$`1.1.1.49`)

summary(IGF.A$`2.7.7.7`)
summary(IGF.B$`2.7.7.7`)

summary(IGF.A$`2.8.4.3`)
summary(IGF.B$`2.8.4.3`)

summary(IGF.A$`6.3.5.5`)
summary(IGF.B$`6.3.5.5`)

summary(IGF.A$`2.5.1.7`)
summary(IGF.B$`2.5.1.7`)

summary(IGF.A$`2.1.1.74`)
summary(IGF.B$`2.1.1.74`)

summary(IGF.A$`3.1.3.16`)
summary(IGF.B$`3.1.3.16`)

summary(IGF.A$`2.3.1.191`)
summary(IGF.B$`2.3.1.191`)

summary(IGF.A$`2.7.7.8`)
summary(IGF.B$`2.7.7.8`)

summary(IGF.A$`2.4.2.14`)
summary(IGF.B$`2.4.2.14`)

#for WEKA ranked ECs against SITE############################################################
IGS.F <- IG.SITE[which(IG.SITE$Site=="feces"),]
IGS.R <- IG.SITE[which(IG.SITE$Site=="rumen"),]
IGS.DNS <- IG.SITE[which(IG.SITE$Site=="SNP"),]

summary(IGS.F$`1.5.1.43`)
summary(IGS.R$`1.5.1.43`)
summary(IGS.DNS$`1.5.1.43`)

summary(IGS.F$`3.1.1.73`)
summary(IGS.R$`3.1.1.73`)
summary(IGS.DNS$`3.1.1.73`)

summary(IGS.F$`1.1.1.271`)
summary(IGS.R$`1.1.1.271`)
summary(IGS.DNS$`1.1.1.271`)

summary(IGS.F$`5.4.2.11`)
summary(IGS.R$`5.4.2.11`)
summary(IGS.DNS$`5.4.2.11`)

summary(IGS.F$`5.1.3.11`)
summary(IGS.R$`5.1.3.11`)
summary(IGS.DNS$`5.1.3.11`)

summary(IGS.F$`1.1.1.192`)
summary(IGS.R$`1.1.1.192`)
summary(IGS.DNS$`1.1.1.192`)

summary(IGS.F$`3.2.1.80`)
summary(IGS.R$`3.2.1.80`)
summary(IGS.DNS$`3.2.1.80`)

summary(IGS.F$`2.5.1.47`)
summary(IGS.R$`2.5.1.47`)
summary(IGS.DNS$`2.5.1.47`)

summary(IGS.F$`4.2.1.45`)
summary(IGS.R$`4.2.1.45`)
summary(IGS.DNS$`4.2.1.45`)

summary(IGS.F$`1.11.1.22`)
summary(IGS.R$`1.11.1.22`)
summary(IGS.DNS$`1.11.1.22`)


#for WEKA ranked ECs against FARM & SITE#####################################################

IGFS.AF <- IG.FS[which(IG.FS$Farm==1 & IG.FS$Site=="feces"),]
IGFS.AR <- IG.FS[which(IG.FS$Farm==1 & IG.FS$Site=="rumen"),]
IGFS.ADNS <- IG.FS[which(IG.FS$Farm==1 & IG.FS$Site=="SNP"),]

IGFS.BF <- IG.FS[which(IG.FS$Farm==2 & IG.FS$Site=="feces"),]
IGFS.BR <- IG.FS[which(IG.FS$Farm==2 & IG.FS$Site=="rumen"),]
IGFS.BDNS <- IG.FS[which(IG.FS$Farm==2 & IG.FS$Site=="SNP"),]

summary(IGFS.AF$`1.4.7.1`)
summary(IGFS.AR$`1.4.7.1`)
summary(IGFS.ADNS$`1.4.7.1`)

summary(IGFS.BF$`1.4.7.1`)
summary(IGFS.BR$`1.4.7.1`)
summary(IGFS.BDNS$`1.4.7.1`)

summary(IGFS.AF$`6.5.1.2`)
summary(IGFS.AR$`6.5.1.2`)
summary(IGFS.ADNS$`6.5.1.2`)

summary(IGFS.BF$`6.5.1.2`)
summary(IGFS.BR$`6.5.1.2`)
summary(IGFS.BDNS$`6.5.1.2`)

summary(IGFS.AF$`6.3.5.4`)
summary(IGFS.AR$`6.3.5.4`)
summary(IGFS.ADNS$`6.3.5.4`)

summary(IGFS.BF$`6.3.5.4`)
summary(IGFS.BR$`6.3.5.4`)
summary(IGFS.BDNS$`6.3.5.4`)

summary(IGFS.AF$`3.6.1.27`)
summary(IGFS.AR$`3.6.1.27`)
summary(IGFS.ADNS$`3.6.1.27`)

summary(IGFS.BF$`3.6.1.27`)
summary(IGFS.BR$`3.6.1.27`)
summary(IGFS.BDNS$`3.6.1.27`)

summary(IGFS.AF$`2.7.1.162`)
summary(IGFS.AR$`2.7.1.162`)
summary(IGFS.ADNS$`2.7.1.162`)

summary(IGFS.BF$`2.7.1.162`)
summary(IGFS.BR$`2.7.1.162`)
summary(IGFS.BDNS$`2.7.1.162`)

summary(IGFS.AF$`4.2.2.23`)
summary(IGFS.AR$`4.2.2.23`)
summary(IGFS.ADNS$`4.2.2.23`)

summary(IGFS.BF$`4.2.2.23`)
summary(IGFS.BR$`4.2.2.23`)
summary(IGFS.BDNS$`4.2.2.23`)

summary(IGFS.AF$`3.2.1.156`)
summary(IGFS.AR$`3.2.1.156`)
summary(IGFS.ADNS$`3.2.1.156`)

summary(IGFS.BF$`3.2.1.156`)
summary(IGFS.BR$`3.2.1.156`)
summary(IGFS.BDNS$`3.2.1.156`)

summary(IGFS.AF$`3.4.21.116`)
summary(IGFS.AR$`3.4.21.116`)
summary(IGFS.ADNS$`3.4.21.116`)

summary(IGFS.BF$`3.4.21.116`)
summary(IGFS.BR$`3.4.21.116`)
summary(IGFS.BDNS$`3.4.21.116`)

summary(IGFS.AF$`1.5.1.43`)
summary(IGFS.AR$`1.5.1.43`)
summary(IGFS.ADNS$`1.5.1.43`)

summary(IGFS.BF$`1.5.1.43`)
summary(IGFS.BR$`1.5.1.43`)
summary(IGFS.BDNS$`1.5.1.43`)

summary(IGFS.AF$`3.1.1.96`)
summary(IGFS.AR$`3.1.1.96`)
summary(IGFS.ADNS$`3.1.1.96`)

summary(IGFS.BF$`3.1.1.96`)
summary(IGFS.BR$`3.1.1.96`)
summary(IGFS.BDNS$`3.1.1.96`)


#unique functions--------------------------------------------------------------------------#
#from mi-faser job summaries, number of unique functions identified per metagenome---------#

#these numbers were found online under mi-faser "My Jobs", easier to manually input
FA.f <- c(1037, 673, 925, 970, 837, 600, 547, 766, 779, 528, 757, 984, 743, 718, 765, 777)
FA.r <- c(721, 943, 704, 685, 698, 665, 673, 503, 865, 822, 666, 891, 594, 638, 689, 749)
FA.n <- c(432, 130, 96, 265, 121, 40, 188, 64, 94, 79, 790, 7, 80, 144, 98, 292) #DNS = n

FB.f <- c(1024, 714, 832, 832, 930, 985, 830, 1027, 979, 647, 922, 986, 705, 916, 1025)
FB.r <- c(794, 157, 123, 739, 57, 703, 559, 767, 785, 611, 663, 736, 790)
FB.n <- c(97, 711, 745, 187, 164, 94, 518, 727, 158, 504, 137, 273, 102, 40, 139)

shapiro.test(FA.f)  #normal
median(FA.f)
IQR(FA.f)

shapiro.test(FA.r)  #normal
median(FA.r)
IQR(FA.r)

shapiro.test(FA.n)  #not normal
median(FA.n)
IQR(FA.n)

shapiro.test(FB.f)  #normal
median(FB.f)
IQR(FB.f)

shapiro.test(FB.r)  #not normal
median(FB.r)
IQR(FB.r)

shapiro.test(FB.n)  #normal
median(FB.n)
IQR(FB.n)

wilcox.test(FA.f, FB.f)   #p = 0.05036
wilcox.test(FA.r, FB.r)   #p = 0.4231
wilcox.test(FA.n, FB.n)   #p = 0.0929












#trash code, didn't use---------------------------------------------------------------------#

#read sample data in individually
S2 <- read.csv("G527_2_P1A13_feces_S2.csv")
S3 <- read.csv("G527_3_P1A14_feces_S3.csv")
S4 <- read.csv("G527_4_P1A19_feces_S4.csv")
S5 <- read.csv("G527_5_P1A2_feces_S5.csv")
S6 <- read.csv("G527_6_P1A20_feces_S6.csv")
S7 <- read.csv("G527_7_P1A22_feces_S7.csv")
S8 <- read.csv("G527_8_P1A24_feces_S8.csv")
S9 <- read.csv("G527_9_P1A25_feces_S9.csv")
S10 <- read.csv("G527_10_P1A26_feces_S10.csv")
S11 <- read.csv("G527_11_P1A28_feces_S11.csv")
S12 <- read.csv("G527_12_P1A29_feces_S12.csv")
S13 <- read.csv("G527_13_P1A4_feces_S13.csv")
S14 <- read.csv("G527_14_P1A7_feces_S14.csv")
S15 <- read.csv("G527_15_P1_A8_feces_S15.csv")
S16 <- read.csv("G527_16_P1A9_feces_S16.csv")
S17 <- read.csv("G527_17_P1A11_rumen_S17.csv")
S18 <- read.csv("G527_18_P1A13_rumen_S18.csv")
S19 <- read.csv("G527_19_P1A14_rumen_S19.csv")
S20 <- read.csv("G527_20_P1A19_rumen_S20.csv")
S21 <- read.csv("G527_21_P1A2_rumen_S21.csv")
S22 <- read.csv("G527_22_P1A20_rumen_S22_.csv")
S23 <- read.csv("G527_23_P1A218_rumen_S23.csv")
S24 <- read.csv("G527_24_P1A22_rumen_S24.csv")
S25 <- read.csv("G527_25_P1A24_rumen_S25.csv")
S26 <- read.csv("G527_26_P1A25_rumen_S26.csv")
S27 <- read.csv("G527_27_P1A26_rumen_S27.csv")
S28 <- read.csv("G527_28_P1A29_rumen_S28.csv")
S29 <- read.csv("G527_29_P1A4_rumen_S29.csv")
S30 <- read.csv("G527_30_P1A7_rumen_S30.csv")
S31 <- read.csv("G527_31_P1A8_rumen_S31.csv")
S32 <- read.csv("G527_32_P1A9_rumen_S32.csv")
S33 <- read.csv("G527_33_P1A11_SNP_S33.csv")
S34 <- read.csv("G527_34_P1A13_SNP_S34.csv")
S35 <- read.csv("G527_35_P1A14_SNP_S35.csv")
S36 <- read.csv("G527_36_P1A19_SNP_S36.csv")
S37 <- read.csv("G527_37_P1A2_SNP_S37.csv")
S38 <- read.csv("G527_38_P1A20_SNP_S38.csv")
S39 <- read.csv("G527_39_P1A22_ANP_S39.csv")
S40 <- read.csv("G527_40_P1A24_SNP_S40.csv")
S41 <- read.csv("G527_41_P1A25_SNP_S41.csv")
S42 <- read.csv("G527_42_P1A26_SNP_S42.csv")
S43 <- read.csv("G527_43_P1A28_SNP_S43.csv")
S44 <- read.csv("G527_44_P1A29_SNP_S44.csv")
S45 <- read.csv("G527_45_P1A4_SNP_S45.csv")
S46 <- read.csv("G527_46_P1A7_SNP_S46.csv")
S47 <- read.csv("G527_47_P1A8_SNP_S47.csv")
S48 <- read.csv("G527_48_P1A9_SNP_S48.csv")
S50 <- read.csv("G527_50_P2A1_feces_S50.csv")
S51 <- read.csv("G527_51_P2A10_feces_S51.csv")
S52 <- read.csv("G527_52_P2A14_feces_S52.csv")
S53 <- read.csv("G527_53_P2A16_feces_S53.csv")
S54 <- read.csv("G527_54_P2A18_feces_S54.csv")
S55 <- read.csv("G527_55_P2A19_feces_S55.csv")
S56 <- read.csv("G527_56_P2A20_feces_S56.csv")
S57 <- read.csv("G527_57_P2A21_feces_S57.csv")
S58 <- read.csv("G527_58_P2A22_feces_S58.csv")
S59 <- read.csv("G527_59_P2A26_feces_S59.csv")
S60 <- read.csv("G527_60_P2A27_feces_S60.csv")
S61 <- read.csv("G527_61_P2A28_feces_S61.csv")
S62 <- read.csv("G527_62_P2A29_feces_S62.csv")
S63 <- read.csv("G527_63_P2A7_feces_S63.csv")
S64 <- read.csv("G527_64_P2A9_feces_S64.csv")
S65 <- read.csv("G527_65_P2A1_rumen_S65.csv")
S66 <- read.csv("G527_66_P2A10_rumen_S66.csv")
S67 <- read.csv("G527_67_P2A14_rumen_S67.csv")
S68 <- read.csv("G527_68_P2A16_rumen_S68.csv")
S69 <- read.csv("G527_69_P2A18_rumen_S69.csv")
S70 <- read.csv("G527_70_P2A19_rumen_S70.csv")
S71 <- read.csv("G527_71_P2A20_rumen_S71.csv")
S72 <- read.csv("G527_72_P2A21_rumen_S72.csv")
S73 <- read.csv("G527_73_P2A22_rumen_S73.csv")
S74 <- read.csv("G527_74_P2A26_rumen_S74.csv")
S75 <- read.csv("G527_75_P2A27_rumen_S75.csv")
S76 <- read.csv("G527_76_P2A28_rumen_S76.csv")
S77 <- read.csv("G527_77_P2A29_rumen_S77.csv")
S78 <- read.csv("G527_78_P2A1_SNP_S78.csv")
S79 <- read.csv("G527_79_P2A10_SNP_S79.csv")
S80 <- read.csv("G527_80_P2A14_SNP_S80.csv")
S81 <- read.csv("G527_81_P2A16_SNP_S81.csv")
S82 <- read.csv("G527_82_P2A18_SNP_S82.csv")
S83 <- read.csv("G527_83_P2A19_SNP_S83.csv")
S84 <- read.csv("G527_84_P2A20_SNP_S84.csv")
S85 <- read.csv("G527_85_P2A21_SNP_S85.csv")
S86 <- read.csv("G527_86_P2A22_SNP_S86.csv")
S87 <- read.csv("G527_87_P2A26_SNP_S87.csv")
S88 <- read.csv("G527_88_P2A27_SNP_S88.csv")
S89 <- read.csv("G527_89_P2A28_SNP_S89.csv")
S90 <- read.csv("G527_90_P2A29_SNP_S90.csv")
S91 <- read.csv("G527_91_P2A7_SNP_S91.csv")
S92 <- read.csv("G527_92_P2A9_SNP_S92.csv")


#maybe don't need this anymore.....
library(dplyr)
int.names = allTable %>% select_if(is.integer) %>% colnames()
print(int.names)
allTable[,int.names] = data.frame(sapply(allTable[int.names], as.numeric))
str(allTable[,int.names])
