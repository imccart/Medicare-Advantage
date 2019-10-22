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

drops=array(dim=c(9,2))
drops[,1]=c(2007:2015)
drops[,2]=c(5,4,7,7,2,2,2,2,2)


## Years 2007-2008
for (y in 2007:2008){
  d=drops[which(drops[,1]==y),2]
  ffs.data=read_csv(get(paste("ffs.path.",y,sep="")),skip=d,
                      col_names=c("state","ssa","county_name","parta_enroll",
                                  "parta_reimb","parta_percap","parta_reimb_unadj",
                                  "parta_percap_unadj","parta_ime","parta_dsh",
                                  "parta_gme","parta_demo","partb_enroll",
                                  "partb_reimb","partb_percap","partb_demo",
                                  "mean_risk"))
  ffs.costs <- ffs.data %>%
    select(ssa,state,county_name,parta_enroll,parta_reimb,
           partb_enroll,partb_reimb,mean_risk) %>%
    mutate(year=y)
  
  assign(paste("ffs.costs.",y,sep=""),ffs.costs)
  
}

## Years 2009-2014
for (y in 2009:2014){
  d=drops[which(drops[,1]==y),2]
  ffs.data=read_csv(get(paste("ffs.path.",y,sep="")),col_names=FALSE,skip=d)
  ffs.data=ffs.data[,1:15]
  names(ffs.data) = c("ssa","state","county_name","parta_enroll",
              "parta_reimb","parta_percap","parta_reimb_unadj",
              "parta_percap_unadj","parta_ime","parta_dsh",
              "parta_gme","partb_enroll",
              "partb_reimb","partb_percap",
              "mean_risk")  
 
  ffs.costs <- ffs.data %>%
    select(ssa,state,county_name,parta_enroll,parta_reimb,
           partb_enroll,partb_reimb,mean_risk) %>%
    mutate(year=y)
  
  assign(paste("ffs.costs.",y,sep=""),ffs.costs)
  
}

## 2015
d=drops[which(drops[,1]==2015),2]
ffs.data=read_xlsx(get(paste("ffs.path.",2015,sep="")),skip=d,
                  col_names=c("ssa","state","county_name","parta_enroll",
                              "parta_reimb","parta_percap","parta_reimb_unadj",
                              "parta_percap_unadj","parta_ime","parta_dsh",
                              "parta_gme","partb_enroll",
                              "partb_reimb","partb_percap",
                              "mean_risk"))
                  
ffs.costs <- ffs.data %>%
  select(ssa,state,county_name,parta_enroll,parta_reimb,
         partb_enroll,partb_reimb,mean_risk) %>%
  mutate(year=2015)

assign(paste("ffs.costs.",2015,sep=""),ffs.costs)

ffs.costs.final=rbind(ffs.costs.2007, ffs.costs.2008, ffs.costs.2009,
                      ffs.costs.2010, ffs.costs.2011, ffs.costs.2012,
                      ffs.costs.2013, ffs.costs.2014, ffs.costs.2015)

# clean final data
ffs.costs.final <- ffs.costs.final %>%
  mutate(
    parta_enroll=str_replace_all(parta_enroll,"\\*",""),
    parta_reimb=str_replace_all(parta_reimb,"\\*",""),
    partb_enroll=str_replace_all(partb_enroll,"\\*",""),
    partb_reimb=str_replace_all(partb_reimb,"\\*",""),
    mean_risk=str_replace_all(mean_risk,"\\*","")
  ) %>%
  mutate(
    parta_enroll=str_replace_all(parta_enroll,".",""),
    parta_reimb=str_replace_all(parta_reimb,".",""),
    partb_enroll=str_replace_all(partb_enroll,".",""),
    partb_reimb=str_replace_all(partb_reimb,".",""),
    mean_risk=str_replace_all(mean_risk,".","")
  ) %>%  
  mutate(
    parta_enroll=as.numeric(str_replace_all(parta_enroll,",","")),
    parta_reimb=as.numeric(str_replace_all(parta_reimb,",","")),
    partb_enroll=as.numeric(str_replace_all(partb_enroll,",","")),
    partb_reimb=as.numeric(str_replace_all(partb_reimb,",","")),
    mean_risk=as.numeric(str_replace_all(mean_risk,",",""))
  )


write_tsv(ffs.costs.final,path=paste(path.data.final,"\\FFS_Costs.txt",sep=""),
          append=FALSE,col_names=TRUE)
write_rds(ffs.costs.final,paste(path.data.final,"\\ffs_costs.rds",sep=""))