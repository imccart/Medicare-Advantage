#########################################################################
## Read in enrollment data
#########################################################################
## Set local "month lists" to identify different files relevant for each year
## Month lists differ by year just in case you work with data that are only available
## in a fraction of a year, which often happens for new data as new monthly releases
## are made. Some data sources are also only available in certain years.
#########################################################################

monthlist_2006=c("07", "08", "09", "10", "11", "12")
monthlist_2007=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2008=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2009=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2010=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2011=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2012=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2013=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2014=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2015=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")


for (y in 2006:2015) {
  monthlist=get(paste0("monthlist_",y))
  for (m in monthlist) {
    
    ## Basic contract/plan information
    ma.path=paste0(path.data.ma,"/Monthly MA and PDP Enrollment by CPSC/Monthly MA and PDP Enrollment by CPSC/Extracted Data/CPSC_Contract_Info_",y,"_",m,".csv")
    contract.info=read_csv(ma.path,
                           skip=1,
                           col_names = c("contractid","planid","org_type","plan_type",
                                         "partd","snp","eghp","org_name","org_marketing_name",
                                         "plan_name","parent_org","contract_date"),
                           col_types = cols(
                             contractid = col_character(),
                             planid = col_double(),
                             org_type = col_character(),
                             plan_type = col_character(),
                             partd = col_character(),
                             snp = col_character(),
                             eghp = col_character(),
                             org_name = col_character(),
                             org_marketing_name = col_character(),
                             plan_name = col_character(),
                             parent_org = col_character(),
                             contract_date = col_character()
                           ))

    contract.info = contract.info %>%
      group_by(contractid, planid) %>%
      mutate(id_count=row_number())
    
    contract.info = contract.info %>%
      filter(id_count==1) %>%
      select(-id_count)
    
    ## Enrollments per plan
    ma.path=paste0(path.data.ma,"/Monthly MA and PDP Enrollment by CPSC/Monthly MA and PDP Enrollment by CPSC/Extracted Data/CPSC_Enrollment_Info_",y,"_",m,".csv")    
    enroll.info=read_csv(ma.path,
                         skip=1,
                         col_names = c("contractid","planid","ssa","fips","state","county","enrollment"),
                         col_types = cols(
                           contractid = col_character(),
                           planid = col_double(),
                           ssa = col_double(),
                           fips = col_double(),
                           state = col_character(),
                           county = col_character(),
                           enrollment = col_double()
                         ),na="*")
    

    ## Merge contract info with enrollment info
    plan.data = contract.info %>%
      left_join(enroll.info, by=c("contractid", "planid")) %>%
      mutate(month=as.numeric(m),year=y)
    
    assign(paste0("plan.data.",m),plan.data)
  }
  
  ## Append monthly enrollment info for each year
  if (y==2006) {
    plan.month=rbind(plan.data.07, plan.data.08, plan.data.09, plan.data.10,
                     plan.data.11, plan.data.12)
  } else {
    plan.month=rbind(plan.data.01, plan.data.02, plan.data.03, plan.data.04,
                     plan.data.05, plan.data.06, plan.data.07, plan.data.08, 
                     plan.data.09, plan.data.10, plan.data.11, plan.data.12)
  }
  
  ## Fill in missing fips codes (by state and county)
  plan.month = plan.month %>%
    group_by(state, county) %>%
    fill(fips)

  ## Fill in missing plan characteristics by contract and plan id
  plan.month = plan.month %>%
    group_by(contractid, planid) %>%
    fill(plan_type, partd, snp, eghp, plan_name)
  
  ## Fill in missing contract characteristics by contractid
  plan.month = plan.month %>%
    group_by(contractid) %>%
    fill(org_type,org_name,org_marketing_name,parent_org)
    
  ## Collapse from monthly data to yearly
  plan.year = plan.month %>%
    group_by(contractid, planid, fips) %>%
    arrange(contractid,planid,fips,month) %>%
    summarize(avg_enrollment=mean(enrollment),sd_enrollment=sd(enrollment),
              min_enrollment=min(enrollment),max_enrollment=max(enrollment),
              first_enrollment=first(enrollment),last_enrollment=last(enrollment),
              state=last(state),county=last(county),org_type=last(org_type),
              plan_type=last(plan_type),partd=last(partd),snp=last(snp),
              eghp=last(eghp),org_name=last(org_name),org_marketing_name=last(org_marketing_name),
              plan_name=last(plan_name),parent_org=last(parent_org),contract_date=last(contract_date),
              year=last(year))
  
  write_rds(plan.year,paste0(path.data.final,"/ma_data_",y,".rds"))
}

full.ma.data <- readRDS(paste0(path.data.final,"/ma_data_2006.rds"))
for (y in 2007:2015) {
  full.ma.data <- rbind(full.ma.data, paste0(path.data.final,"/ma_data_",y,".rds"))
}

write_tsv(full.ma.data,path=paste(path.data.final,"/Full_Contract_Plan_County.txt",sep=""),append=FALSE,col_names=TRUE)
write_rds(full.ma.data,paste(path.data.final,"/full_ma_data.rds",sep=""))
