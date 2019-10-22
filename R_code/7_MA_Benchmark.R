##############################################################################
## Read in MA Benchmark Rates (apply to each county) */
##############################################################################

## Assign yearly file paths
bench.path.2007=paste0(path.data.ma,"\\MA Benchmarks\\ratebook2007\\countyrate2007.csv")
bench.path.2008=paste0(path.data.ma,"\\MA Benchmarks\\ratebook2008\\countyrate2008.csv")
bench.path.2009=paste0(path.data.ma,"\\MA Benchmarks\\ratebook2009\\countyrate2009.csv")
bench.path.2010=paste0(path.data.ma,"\\MA Benchmarks\\ratebook2010\\CountyRate2010.csv")
bench.path.2011=paste0(path.data.ma,"\\MA Benchmarks\\ratebook2011\\CountyRate2011.csv")
bench.path.2012=paste0(path.data.ma,"\\MA Benchmarks\\ratebook2012\\CountyRate2012.csv")
bench.path.2013=paste0(path.data.ma,"\\MA Benchmarks\\ratebook2013\\CountyRate2013.csv")
bench.path.2014=paste0(path.data.ma,"\\MA Benchmarks\\ratebook2014\\CountyRate2014.csv")
bench.path.2015=paste0(path.data.ma,"\\MA Benchmarks\\ratebook2015\\CSV\\CountyRate2015.csv")

## Assign number of rows to drop in each CSV (they are all different because why not :))
drops=array(dim=c(9,2))
drops[,1]=c(2007:2015)
drops[,2]=c(9,10,7,5,7,5,4,2,3)

## Years 2007-2011
for (y in 2007:2011){
  d=drops[which(drops[,1]==y),2]
  bench.data=read_csv(get(paste0("bench.path.",y)),
                      skip=d,
                      col_names=c("ssa","state","county_name","aged_parta",
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
  
  ## create missing variables for future rbind with other years
  bench.data = bench.data %>%
    mutate(risk_star5=NA, risk_star45=NA, risk_star4=NA,
           risk_star35=NA, risk_star3=NA, risk_star25=NA,
           risk_bonus5=NA, risk_bonus35=NA, risk_bonus0=NA,
           Year=y)
  
  assign(paste0("bench.data.",y),bench.data)
}


## Years 2012-2014
for (y in 2012:2014){
    d=drops[which(drops[,1]==y),2]
    bench.data=read_csv(get(paste0("bench.path.",y)),
                        skip=d,
                        col_names=c("ssa","state","county_name","risk_star5",
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
  
  bench.data = bench.data %>%
    mutate(aged_parta=NA, aged_partb=NA, risk_ab=NA,
           risk_bonus5=NA, risk_bonus35=NA, risk_bonus0=NA,
           Year=y)
  
  assign(paste0("bench.data.",y),bench.data)
}

## Year 2015
d=drops[which(drops[,1]==2015),2]
bench.data=read_csv(bench.path.2015,
                    skip=d,
                    col_names=c("ssa","state","county_name",
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
         aged_parta=NA, aged_partb=NA, risk_ab=NA,
         Year=2015)


benchmark.final=rbind(bench.data.2007, bench.data.2008, bench.data.2009,
                      bench.data.2010, bench.data.2011, bench.data.2012,
                      bench.data.2013, bench.data.2014, bench.data.2015)
write_tsv(benchmark.final,path=paste(path.data.final,"\\MA_Benchmark.txt",sep=""),
          append=FALSE,col_names=TRUE)
write_rds(benchmark.final,paste(path.data.final,"\\ma_benchmark.rds",sep=""))
