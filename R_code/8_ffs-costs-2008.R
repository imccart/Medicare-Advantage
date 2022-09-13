
# Import data -------------------------------------------------------------

ffs.data=read_csv("data/input/cms-ffs-costs/Extracted Data/Aged Only/AGED08.csv",
                  skip=4,
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
  mutate(year=2008)