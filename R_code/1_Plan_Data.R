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
monthlist_2016=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2017=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2018=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")


for (y in 2006:2018) {
  monthlist=get(paste("monthlist_",y,sep=""))
  for (m in monthlist) {
    
    ## Basic contract/plan information
    ma.path=paste0(path.data.ma,"\\Monthly MA and PDP Enrollment by CPSC\\Monthly MA and PDP Enrollment by CPSC\\Extracted Data\\CPSC_Contract_Info_",y,"_",m,".csv")
    contract.info=read_csv(ma.path,col_names=c("contractid","planid","org_type","plan_type","partd","snp","eghp","org_name","org_marketing_name","plan_name","parent_org","contract_date"))

    contract.info = contract.info %>%
      group_by(contractid, planid) %>%
      mutate(id_count=row_number())
    
    contract.info = contract.info %>%
      filter(id_count==1) %>%
      select(-id_count)
    
    ## Enrollments per plan
    ma.path=paste0(path.data.ma,"\\Monthly MA and PDP Enrollment by CPSC\\Monthly MA and PDP Enrollment by CPSC\\Extracted Data\\CPSC_Enrollment_Info_",y,"_",m,".csv")    
    enroll.info=read_csv(ma.path,col.names=c("contractid","planid","ssa","fips","state","county","enrollment"))
    
    enroll.info = enroll.info %>%
      mutate(enrollment=replace(enrollment,enrollment=="*",NA)) %>%
      as.data.frame()
    
    enroll.info = enroll.info %>%
      mutate(enrollment=as.numeric(enrollment))

    ## Merge contract info with enrollment info
    plan.data = contract.info %>%
      left_join(enroll.info, by=c("contractid", "planid")) %>%
      mutate(month=as.numeric(m),year=y)
    
    assign(paste("plan.data.",y,".",m,sep=""),plan.data)
  }
  
  ## Append monthly enrollment info for each year
  step=0
  for (m in monthlist) {
    step=step+1
    assign(paste0("plan.month.",step),get(paste0("plan.data.",y,".",m)))
    if (step==1) {
      plan.month=plan.month.1
    } else {
      plan.month=rbind(plan.month,get(paste0("plan.month.",step)))
    }
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
    
  assign(paste0("plan.year.",y),plan.year)
}

full.ma.data=rbind(plan.year.2006,plan.year.2007,plan.year.2008,plan.year.2009,plan.year.2010,
                   plan.year.2011,plan.year.2012,plan.year.2013,plan.year.2014,plan.year.2015,
                   plan.year.2016,plan.year.2017,plan.year.2018)
write_tsv(full.ma.data,path=paste(path.data.final,"\\Full_Contract_Plan_County.txt",sep=""),append=FALSE,col_names=TRUE)
write_rds(full.ma.data,paste(path.data.final,"\\full_ma_data.rds",sep=""))
