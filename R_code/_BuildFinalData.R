# Meta --------------------------------------------------------------------
## Author:        Ian McCarthy
## Date Created:  7/8/2019
## Date Edited:   1/9/2023
## Notes:         R file to build Medicare Advantage dataset


# Preliminaries -----------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stringr, readxl, data.table, gdata)

## functions
source("R_code/fn_plan_characteristics.R")
source("R_code/rating_variables.R")


for (y in 2008:2018) {
  
  # Import data -------------------------------------------------------------
  source("R_code/1_plan-data.R")   
  source("R_code/2_service-area.R")
  source(paste0("R_code/3_plan-characteristics-",y,".R"))
  source("R_code/4_penetration.R")  
  source(paste0("R_code/5_star-ratings-",y,".R"))  
  source(paste0("R_code/6_risk-rebates-",y,".R"))
  source(paste0("R_code/7_benchmarks-",y,".R"))
  source(paste0("R_code/8_ffs-costs-",y,".R"))

  
  # Tidy data ---------------------------------------------------------------  
  final.ma <- final.plans %>%
    inner_join(final.service.area %>% 
               select(contractid, fips, year), 
             by=c("contractid", "fips", "year")) %>%
    filter(!state %in% c("VI","PR","MP","GU","AS","") &
             snp == "No" &
             (planid < 800 | planid >= 900) &
             !is.na(planid) & !is.na(fips))
 
  final.ma <- final.ma %>%
    left_join(final.star.ratings, 
               by=c("contractid", "year")) %>%
    left_join(final.penetration %>% ungroup() %>%
                 rename(state_long=state, county_long=county), 
               by=c("fips", "year"))
  
  final.state <- final.ma %>% 
    group_by(state) %>% 
    summarize(state_name=last(state_long, na.rm=TRUE))
  
  final.ma <- final.ma %>%
    left_join(final.state, by=c("state"))
  
  
  final.ma <- final.ma %>%
    left_join(final.landscape,
               by=c("contractid","planid","state_name"="state","county","year")) %>%
    left_join(final.risk.rebate %>%
                 select(-contract_name, -plan_type),
               by=c("contractid","planid","year")) %>%
    left_join(final.benchmark %>% mutate(ssa=as.numeric(ssa)),
               by=c("ssa","year"))
  
  
  ## calculate star rating (Part C rating if plan doesn't offer part D, otherwise Part D rating if available)
  final.ma <- final.ma %>%
    mutate(Star_Rating = 
             case_when(
               partd == "No" ~ partc_score,
               partd == "Yes" & is.na(partcd_score) ~ partc_score,
               partd == "Yes" & !is.na(partcd_score) ~ partcd_score,
               TRUE ~ NA_real_
             ))
  
  ## calculate relevant benchmark rate based on star rating
  final.ma <- final.ma %>%
    mutate(ma_rate =
             case_when(
               year<2012 ~ risk_ab,
               year>=2012 & year<2015 & Star_Rating == 5 ~ risk_star5,
               year>=2012 & year<2015 & Star_Rating == 4.5 ~ risk_star45,
               year>=2012 & year<2015 & Star_Rating == 4 ~ risk_star4,
               year>=2012 & year<2015 & Star_Rating == 3.5 ~ risk_star35,
               year>=2012 & year<2015 & Star_Rating == 3 ~ risk_star3,
               year>=2012 & year<2015 & Star_Rating < 3 ~ risk_star25,
               year>=2012 & year<2015 & is.na(Star_Rating) ~ risk_star35,
               year>=2015 & Star_Rating >= 4 ~ risk_bonus5,
               year>=2015 & Star_Rating < 4 ~ risk_bonus0,
               year>=2015 & is.na(Star_Rating) ~ risk_bonus35,
               TRUE ~ NA_real_
             ))
  
  ## final premium and bid variables
  final.ma <- final.ma %>%
    mutate(basic_premium=
             case_when(
               rebate_partc>0 ~ 0,
               partd == "No" & !is.na(premium) & is.na(premium_partc) ~ premium,
               TRUE ~ premium_partc
             ),
           bid=
             case_when(
               rebate_partc == 0 & basic_premium > 0 ~ (payment_partc + basic_premium)/riskscore_partc,
               rebate_partc > 0 | basic_premium == 0 ~ payment_partc/riskscore_partc,
               TRUE ~ NA_real_
             ))
  
  ## incorporate ffs cost data by ssa
  final.ma <- final.ma %>%
    left_join(final.ffs.costs %>%
                 select(-state), 
               by=c("ssa","year")) %>%
    mutate(avg_ffscost = case_when(
      parta_enroll==0 & partb_enroll==0 ~ 0,
      parta_enroll==0 & partb_enroll>0 ~ partb_reimb/partb_enroll,
      parta_enroll>0 & partb_enroll==0 ~ parta_reimb/parta_enroll,
      parta_enroll>0 & partb_enroll>0 ~ (parta_reimb/parta_enroll) + (partb_reimb/partb_enroll),
      TRUE ~ NA_real_
    ))
  
  write_tsv(final.ma,file=paste0("data/output/ma_data_",y,".txt"), append=FALSE)

  if (y==2008) {
    final.ma.full <- final.ma
  } else {
    final.ma.full <- rbind(final.ma.full, final.ma)
  }
    
}


write_tsv(final.ma.full,file="data/output/ma_data_full.txt", append=FALSE)
