##############################################################################
## Read in Average Fee-for-Service Costs per County */
##############################################################################

## Assign yearly file paths
ffs.path.2007=paste0(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\Aged07.csv")
ffs.path.2008=paste0(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\AGED08.csv")
ffs.path.2009=paste0(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged09.csv")
ffs.path.2010=paste0(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged10.csv")
ffs.path.2011=paste0(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged11.csv")
ffs.path.2012=paste0(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged12.csv")
ffs.path.2013=paste0(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged13.csv")
ffs.path.2014=paste0(path.data.ffs,"\\FFS Costs\\Extracted Data\\Aged Only\\aged14.csv")
ffs.path.2015=paste0(path.data.ffs,"\\FFS Costs\\Extracted Data\\FFS15.xlsx")

drops=array(dim=c(9,2))
drops[,1]=c(2007:2015)
drops[,2]=c(5,4,7,7,2,2,2,2,2)


## Years 2007-2008
for (y in 2007:2008){
  d=drops[which(drops[,1]==y),2]
  ffs.data=read_csv(get(paste0("ffs.path.",y)),skip=d,
                    col_names=c("state","ssa","county_name","parta_enroll",
                                "parta_reimb","parta_percap","parta_reimb_unadj",
                                "parta_percap_unadj","parta_ime","parta_dsh",
                                "parta_gme","parta_demo","partb_enroll",
                                "partb_reimb","partb_percap","partb_demo",
                                "mean_risk"),
                    col_types = cols(
                      state = col_character(),
                      ssa = col_double(),
                      county_name = col_character(),
                      parta_enroll = col_number(),
                      parta_reimb = col_number(),
                      parta_percap = col_number(),
                      parta_reimb_unadj = col_number(),
                      parta_percap_unadj = col_number(),
                      parta_ime = col_number(),
                      parta_dsh = col_number(),
                      parta_gme = col_number(),
                      parta_demo = col_number(),
                      partb_enroll = col_number(),
                      partb_reimb = col_number(),
                      partb_percap = col_number(),
                      partb_demo = col_number(),
                      mean_risk = col_number()
                    ), na="*")
                    
                    
  ffs.costs <- ffs.data %>%
    select(ssa,state,county_name,parta_enroll,parta_reimb,
           partb_enroll,partb_reimb,mean_risk) %>%
    mutate(year=y)
  
  assign(paste0("ffs.costs.",y),ffs.costs)
  
}

## Years 2009-2014
for (y in 2009:2014){
  d=drops[which(drops[,1]==y),2]
  ffs.data=read_csv(get(paste0("ffs.path.",y)),
                    skip=d,
                    col_names=FALSE, na="*")
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
    mutate(year=y,
           ssa=as.numeric(ssa)) %>%
    mutate_at(vars(parta_enroll, parta_reimb, partb_enroll, partb_reimb, mean_risk),~str_replace_all(.,",",""))  %>%      
    mutate_at(vars(parta_enroll, parta_reimb, partb_enroll, partb_reimb, mean_risk),as.numeric)
  
  assign(paste("ffs.costs.",y,sep=""),ffs.costs)
  
}

## 2015
d=drops[which(drops[,1]==2015),2]
ffs.data=read_xlsx(get(paste0("ffs.path.",2015)),
                   skip=d,
                   col_names=c("ssa","state","county_name","parta_enroll",
                               "parta_reimb","parta_percap","parta_reimb_unadj",
                               "parta_percap_unadj","parta_ime","parta_dsh",
                               "parta_gme","partb_enroll",
                               "partb_reimb","partb_percap",
                               "mean_risk"), na="*")

                  
ffs.costs <- ffs.data %>%
  select(ssa,state,county_name,parta_enroll,parta_reimb,
         partb_enroll,partb_reimb,mean_risk) %>%
  mutate(year=2015,
         ssa=as.numeric(ssa)) %>%
  mutate_at(vars(parta_enroll, parta_reimb, partb_enroll, partb_reimb, mean_risk),~str_replace_all(.,",",""))  %>%  
  mutate_at(vars(parta_enroll, parta_reimb, partb_enroll, partb_reimb, mean_risk),as.numeric)  

assign(paste("ffs.costs.",2015,sep=""),ffs.costs)

ffs.costs.final=rbind(ffs.costs.2007, ffs.costs.2008, ffs.costs.2009,
                      ffs.costs.2010, ffs.costs.2011, ffs.costs.2012,
                      ffs.costs.2013, ffs.costs.2014, ffs.costs.2015)

write_tsv(ffs.costs.final,path=paste(path.data.final,"\\FFS_Costs.txt",sep=""),
          append=FALSE,col_names=TRUE)
write_rds(ffs.costs.final,paste(path.data.final,"\\ffs_costs.rds",sep=""))