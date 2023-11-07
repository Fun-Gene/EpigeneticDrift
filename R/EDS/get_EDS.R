get_EDS <- function(cpgdata){
  #### load data
  coef=readRDS('NSPT_lmresult_for_calculation.rds')
  para=readRDS('NSPT_meanvar_for_calculation.rds')
  zscore=readRDS('NSPT_cpgscore_for_calculation.rds')
  #### check cpgs
  cpg_offset=setdiff(colnames(para),colnames(cpgdata))
  cpg_overlap=intersect(colnames(para),colnames(cpgdata))
  #### calculate cpg zscore
  cpgdata=cpgdata[,cpg_overlap]
  cpgdata_zscore=c()
  for (i in 1:ncol(cpgdata)){cpgdata_zscore=cbind(cpgdata_zscore,abs(cpgdata[,colnames(cpgdata)[i]]-para[1,colnames(cpgdata)[i]])/para[2,colnames(cpgdata)[i]])}
  cpgdata_zscore=as.data.frame(cpgdata_zscore);colnames(cpgdata_zscore)=colnames(cpgdata);rownames(cpgdata_zscore)=rownames(cpgdata)
  #### add nspt result if needed
  if (length(cpg_offset>0)){
    zscore=zscore[cpg_offset,]
    zscore=as.data.frame(apply(zscore,1,function(x){rep(x,nrow(cpgdata))}))
    rownames(zscore)=rownames(cpgdata)
    cpgdata_zscore=cbind(cpgdata_zscore,zscore)
  }
  #### calculate EDS
  cpgdata_zscore=cpgdata_zscore[,coef$cpg]
  EDS <- as.data.frame(apply(cpgdata_zscore,1,function(x){sum(x * coef$b)}))
  colnames(EDS)='EDS'
  EDS$EDS=(EDS$EDS-57.5140)/(527.5312-57.5140)
  
  return(EDS)
}