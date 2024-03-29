
# Import data -------------------------------------------------------------

ffs.data=read_xlsx("data/input/cms-ffs-costs/Extracted Data/FFS2018/FFS18.xlsx",
                  skip=2,
                  col_names=c("ssa","state","county_name","parta_enroll",
                              "parta_reimb","parta_percap","parta_reimb_unadj",
                              "parta_percap_unadj","parta_ime","parta_dsh",
                              "parta_gme","partb_enroll",
                              "partb_reimb","partb_percap"), na="*")


final.ffs.costs <- ffs.data %>%
  select(ssa,state,county_name,parta_enroll,parta_reimb,
         partb_enroll,partb_reimb) %>%
  mutate(year=2018,
         ssa=as.numeric(ssa),
         mean_risk=NA) %>%
  mutate_at(vars(parta_enroll, parta_reimb, partb_enroll, partb_reimb, mean_risk),~str_replace_all(.,",",""))  %>%  
  mutate_at(vars(parta_enroll, parta_reimb, partb_enroll, partb_reimb, mean_risk),as.numeric)  
