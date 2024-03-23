library(tidyverse)
library(naniar)
library(readxl)


# load population excel file into variables
# data source: 
target <- read_excel("14100DO0001_2011-23.xlsx", sheet = 2)
# remove redundant rows
target <- target[6:23278, ]
# changes label name
colnames(target) <- target[1, ]

target <- target[2:23272, ]

# filter only necessary SA2 target code
target <- target%>%filter(target$Code == 206041506 
                          |target$Code ==  210011231 
                          |target$Code == 209011203 
                          |target$Code == 211051282)

# mutate with area parameter 
target <- target%>%mutate(`Area(sqm)` = case_when(Code == 206041506~ 242.5*0.01,
                                                  Code == 210011231~ 414.4*0.01,
                                                  Code == 209011203~ 1023.8*0.01,
                                                  Code == 211051282~ 8189.9*0.01))


# saved as csv 
write_csv(target, "C:/Users/wutth/OneDrive/Documents/population_SA2_revised_with_Area.csv")


