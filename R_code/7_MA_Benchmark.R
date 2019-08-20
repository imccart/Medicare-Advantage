##############################################################################
## Read in MA Benchmark Rates (apply to each county) */
##############################################################################

## Assign yearly file paths
bench.path.2007=paste(path.data.ma,"\\MA Benchmarks\\ratebook2007\\countyrate2007.csv",sep="")
bench.path.2008=paste(path.data.ma,"\\MA Benchmarks\\ratebook2008\\countyrate2008.csv",sep="")
bench.path.2009=paste(path.data.ma,"\\MA Benchmarks\\ratebook2009\\countyrate2009.csv",sep="")
bench.path.2010=paste(path.data.ma,"\\MA Benchmarks\\ratebook2010\\CountyRate2010.csv",sep="")
bench.path.2011=paste(path.data.ma,"\\MA Benchmarks\\ratebook2011\\CountyRate2011.csv",sep="")
bench.path.2012=paste(path.data.ma,"\\MA Benchmarks\\ratebook2012\\CountyRate2012.csv",sep="")
bench.path.2013=paste(path.data.ma,"\\MA Benchmarks\\ratebook2013\\CountyRate2013.csv",sep="")
bench.path.2014=paste(path.data.ma,"\\MA Benchmarks\\ratebook2014\\CountyRate2014.csv",sep="")
bench.path.2015=paste(path.data.ma,"\\MA Benchmarks\\ratebook2015\\CSV\\CountyRate2015.csv",sep="")

for (y in 2007:2011){
  bench.data=read.csv(get(paste("bench.path.",y,sep="")),skip=9,row.names=NULL,
                      col.names=c("ssa","state","county_name","aged_parta",
                                  "aged_partb","disabled_parta","disabled_partb",
                                  "esrd_ab","risk_ab","blank"))
  
  bench.data = bench.data %>%
    mutate(aged_parta=as.numeric(aged_parta),
           aged_partb=as.numeric(aged_partb),
           disabled_parta=as.numeric(disabled_parta),
           disabled_partb=as.numeric(disabled_partb),
           esrd_ab=as.numeric(esrd_ab),
           risk_ab=as.numeric(risk_ab)) %>%
    select(ssa,aged_parta,aged_partb,risk_ab)
  
  assign(paste("bench.data.",y,sep=""),bench.data)
}

bench.data=read.csv(bench.path.2012,skip=6)

for (y in 2012:2014){
  bench.data=read.csv(get(paste("bench.path.",y,sep="")),skip=9,row.names=NULL,
                      col.names=c("ssa","state","county_name","risk_star5",
                                  "risk_star45","risk_star4","risk_star35",
                                  "risk_star3","risk_star25","esrd_ab"))
  bench.data = bench.data %>%
    mutate(risk_star5=as.numeric(risk_star5),
           risk_star45=as.numeric(risk_star45),
           risk_star4=as.numeric(risk_star4),
           risk_star35=as.numeric(risk_star35),
           risk_star3=as.numeric(risk_star3),
           risk_star25=as.numeric(risk_star25)) %>%
    select(ssa,risk_star5,risk_star45,risk_star4,risk_star35,risk_star3,risk_star25)
  
  assign(paste("bench.data.",y,sep=""),bench.data)
}

mutate(risk_star5=as.numeric(str_replace_all(risk_star5,' ','')))



risk.rebate.final=rbind(risk.rebate.2006,risk.rebate.2007,risk.rebate.2008,
                        risk.rebate.2009,risk.rebate.2010,risk.rebate.2011,
                        risk.rebate.2012,risk.rebate.2013,risk.rebate.2014,
                        risk.rebate.2015)
write_tsv(risk.rebate.final,path=paste(path.data.final,"\\Risk_Rebate.txt",sep=""),
          append=FALSE,col_names=TRUE)
