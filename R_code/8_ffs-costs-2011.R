
# Import data -------------------------------------------------------------

ffs.data <- read_csv("data/input/ffs-costs/Extracted Data/Aged Only/aged11.csv",
                  skip=2,
                  col_names=FALSE, na="*")

ffs.data <- ffs.data[,1:15]
names(ffs.data) <- c("ssa","state","county_name","parta_enroll",
                    "parta_reimb","parta_percap","parta_reimb_unadj",
                    "parta_percap_unadj","parta_ime","parta_dsh",
                    "parta_gme","partb_enroll",
                    "partb_reimb","partb_percap",
                    "mean_risk")  

final.ffs.costs <- ffs.data %>%
  select(ssa,state,county_name,parta_enroll,parta_reimb,
         partb_enroll,partb_reimb,mean_risk) %>%
  mutate(year=2011,
         ssa=as.numeric(ssa)) %>%
  mutate(across(c(parta_enroll, parta_reimb, partb_enroll, partb_reimb, mean_risk),
              ~ parse_number(as.character(.))))
