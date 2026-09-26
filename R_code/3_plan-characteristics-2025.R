
# Import data -------------------------------------------------------------

landscape <- read_csv("data/input/ma/landscape/Extracted Data/CY2025_Landscape_202506.1.csv",
                      col_types = cols(.default = col_character())) %>%
  mutate(across(matches("Premium|Deductible"), ~str_replace_all(str_replace_all(., "[(]", "-"), "[)]", ""))) %>%
  filter(`Contract Category Type` %in% c("MA","MA-PD","SNP")) %>%
  transmute(state = `State Name`,
            county = `County Name`,
            contractid = `Contract ID`,
            planid = as.numeric(`Plan ID`),
            premium = coalesce(parse_number(`Monthly Consolidated Premium (Part C + D)`), parse_number(`Part C Premium`)),
            premium_partc = parse_number(`Part C Premium`),
            premium_partd_basic = parse_number(`Part D Basic Premium`),
            premium_partd_supp = parse_number(`Part D Supplemental Premium`),
            premium_partd_total = parse_number(`Part D Total Premium`),
            partd_deductible = parse_number(`Annual Part D Deductible Amount`))

ma.data <- landscape %>%
  select(contractid, planid, state, county, premium)

mapd.data <- landscape %>%
  select(contractid, planid, state, county, premium_partc, premium_partd_basic,
         premium_partd_supp, premium_partd_total, partd_deductible)

final.landscape <- mapd.clean.merge(ma.data=ma.data, mapd.data=mapd.data, y)
