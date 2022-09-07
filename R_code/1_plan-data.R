
# Set month lists ---------------------------------------------------------

#########################################################################
## Set local "month lists" to identify different files relevant for each year
## Month lists differ by year just in case you work with data that are only available
## in a fraction of a year, which often happens for new data as new monthly releases
## are made. Some data sources are also only available in certain years.
#########################################################################

if (y==2006) {
  monthlist <- c("07", "08", "09", "10", "11", "12")
} else {
  monthlist <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")  
}

# Import monthly data -----------------------------------------------------
step <- 0
for (m in monthlist) {
  step <- step+1
    
  ## Basic contract/plan information
  ma.path <- paste0("data/input/enrollment/Extracted Data/CPSC_Contract_Info_",y,"_",m,".csv")
  contract.info <- read_csv(ma.path,
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

  contract.info <- contract.info %>%
    group_by(contractid, planid) %>%
    mutate(id_count=row_number())
    
  contract.info <- contract.info %>%
    filter(id_count==1) %>%
    select(-id_count)
    
  ## Enrollments per plan
  ma.path <- paste0("data/input/enrollment/Extracted Data/CPSC_Enrollment_Info_",y,"_",m,".csv")    
  enroll.info <- read_csv(ma.path,
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
  plan.data <- contract.info %>%
    left_join(enroll.info, by=c("contractid", "planid")) %>%
    mutate(month=as.numeric(m),year=y)

  if (step==1) {
    plan.year <- plan.data
  } else {
    plan.year <- rbind(plan.year,plan.data)
  }
} 

## Fill in missing fips codes (by state and county)
plan.year <- plan.year %>%
  group_by(state, county) %>%
  fill(fips)

## Fill in missing plan characteristics by contract and plan id
plan.year <- plan.year %>%
  group_by(contractid, planid) %>%
  fill(plan_type, partd, snp, eghp, plan_name)
  
## Fill in missing contract characteristics by contractid
plan.year <- plan.year %>%
  group_by(contractid) %>%
  fill(org_type,org_name,org_marketing_name,parent_org)
    
## Collapse from monthly data to yearly
final.plans <- plan.year %>%
  group_by(contractid, planid, fips, year) %>%
  arrange(contractid, planid, fips, month) %>%
  summarize(avg_enrollment=mean(enrollment),sd_enrollment=sd(enrollment),
            min_enrollment=min(enrollment),max_enrollment=max(enrollment),
            first_enrollment=first(enrollment),last_enrollment=last(enrollment),
            state=last(state),county=last(county),org_type=last(org_type),
            plan_type=last(plan_type),partd=last(partd),snp=last(snp),
            eghp=last(eghp),org_name=last(org_name),org_marketing_name=last(org_marketing_name),
            plan_name=last(plan_name),parent_org=last(parent_org),contract_date=last(contract_date),
            year=last(year))
