# Medicare Advantage
This describes all of my primary Medicare Advantage (MA) datasets and code files. Project-specific uses of these data are treated as their own repositories and will be cited here over time. As always, this is a living document and changes regularly.

# Raw Data Sources
All of the raw data are publicly available from the Centers for Medicare and Medicaid Services (CMS) website, although navigating the different pages can be cumbersome. There is more information available than what I discuss here, but this is sufficient to create a panel of MA plans/contracts/insurers by county over several years, complete with plan characteristics, quality ratings, and plan enrollments.

Below, I introduce files in the order in which I've found things to be easiest to work with, but there's no magic order that needs to be followed. 

1. [Service Area Files](https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/MCRAdvPartDEnrolData/MA-Contract-Service-Area-by-State-County.html)

   The MA Contract Service Area files provide a list of contracts and the counties in which the contracts are approved to operate. The files are available monthly. I typically use the January files to identify the set of contracts approved as of the start of the calendar year.

