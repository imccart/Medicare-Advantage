##############################################################################
## Read in Average Fee-for-Service Costs per County */
##############################################################################

## Assign yearly file paths
ffs.path.2007=paste(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\Aged07.csv",sep="")
ffs.path.2008=paste(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\AGED08.csv",sep="")
ffs.path.2009=paste(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged09.csv",sep="")
ffs.path.2010=paste(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged10.csv",sep="")
ffs.path.2011=paste(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged11.csv",sep="")
ffs.path.2012=paste(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged12.csv",sep="")
ffs.path.2013=paste(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged13.csv",sep="")
ffs.path.2014=paste(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged14.csv",sep="")
ffs.path.2015=paste(path.data.ffs,"\\FFS Costs\\Extracted Data\\FFS15.xlsx",sep="")

ffs.data=read.csv(ffs.path.2007,skip=3,row.names=NULL,header=TRUE)

## Years 2007-2014
## bring back the drops array
for (y in 2007:2011){
  ffs.data=read.csv(get(paste("ffs.path.",y,sep="")),row.names=NULL,skip=...,
                      col.names=c("state","ssa","county_name","parta_enroll",
                                  "parta_reimb","parta_percap","parta_reimb_unadj",
                                  "parta_percap_unadj","parta_ime","parta_dsh",
                                  "parta_gme","parta_demo","partb_enroll",
                                  "partb_reimb","partb_percap","partb_demo",
                                  "mean_risk")

    
  bench.data = bench.data %>%
    mutate(aged_parta=as.numeric(aged_parta),
           aged_partb=as.numeric(aged_partb),
           disabled_parta=as.numeric(disabled_parta),
           disabled_partb=as.numeric(disabled_partb),
           esrd_ab=as.numeric(esrd_ab),
           risk_ab=as.numeric(risk_ab)) %>%
    select(ssa,aged_parta,aged_partb,risk_ab)
  
  ## create missing variables for future rbind with other years
  bench.data = bench.data %>%
    mutate(risk_star5=NA, risk_star45=NA, risk_star4=NA,
           risk_star35=NA, risk_star3=NA, risk_star25=NA,
           risk_bonus5=NA, risk_bonus35=NA, risk_bonus0=NA)
  
  assign(paste("bench.data.",y,sep=""),bench.data)
}



## Year 2015
bench.data=read.csv(bench.path.2015,skip=d,row.names=NULL,
                    col.names=c("ssa","state","county_name",
                                "risk_bonus5","risk_bonus35",
                                "risk_bonus0","esrd_ab"))
bench.data.2015 = bench.data %>%
  mutate(risk_bonus5=as.numeric(risk_bonus5),
         risk_bonus35=as.numeric(risk_bonus35),
         risk_bonus0=as.numeric(risk_bonus0)) %>%
  select(ssa,risk_bonus5,risk_bonus35,risk_bonus0)

bench.data.2015 = bench.data.2015 %>%
  mutate(risk_star5=NA, risk_star45=NA, risk_star4=NA,
         risk_star35=NA, risk_star3=NA, risk_star25=NA,
         aged_parta=NA, aged_partb=NA, risk_ab=NA)


benchmark.final=rbind(bench.data.2007, bench.data.2008, bench.data.2009,
                      bench.data.2010, bench.data.2011, bench.data.2012,
                      bench.data.2013, bench.data.2014, bench.data.2015)
write_tsv(benchmark.final,path=paste(path.data.final,"\\MA_Benchmark.txt",sep=""),
          append=FALSE,col_names=TRUE)
