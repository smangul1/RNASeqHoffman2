#! /usr/bin/env Rscript

 


args <- commandArgs(trailingOnly = TRUE)
print(args[1])


#print "directory with the counts files"
#print "conditions 1"
#print "condition 2"



library('DESeq2')
directory<-args[1]


sampleFiles <- grep("counts",list.files(directory),value=TRUE)






print(sampleFiles)
print("-------sampleFiles--------")

sampleCondition <- c(args[2],args[2],args[3],args[3])
sampleTable<-data.frame(sampleName=sampleFiles, fileName=sampleFiles, condition=sampleCondition)
print(sampleTable)

ddsHTSeq<-DESeqDataSetFromHTSeqCount(sampleTable=sampleTable, directory=directory, design=~condition)

colData(ddsHTSeq)$condition<-factor(colData(ddsHTSeq)$condition, levels=c(args[2],args[3]))
dds<-DESeq(ddsHTSeq)
res<-results(dds)
res<-res[order(res$padj),]
head(res)

print("-------res--------")


#file to save
outMA<-paste(args[1],args[2], args[3],".pdf",sep="")
print(outMA)

pdf(outMA)
plotMA(dds,ylim=c(-2,2),main="DESeq2")
dev.off()

#write DE genes to csv
outcsv<-paste(args[1],args[2], args[3],".csv",sep="")
resSig <- res[ which(res$padj < .1), ]
write.csv(resSig, file = outcsv)


#make PCA plot
rld <- rlogTransformation(dds, blind=TRUE)
outPCA<-paste(args[1],args[2], args[3],"PCA.pdf",sep="")
pdf(outPCA)
plotPCA(rld, intgroup=c("condition"))
dev.off()




