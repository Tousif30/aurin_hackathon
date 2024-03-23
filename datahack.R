rm(list = ls())
gc()
options(scipen = 999)

library(plm)
library(tidyverse)
library(readxl)
library(broom)

aurin_path <- 'C:/Users/maxim/Documents/AURIN-datahack/'

alldata <- readRDS(file.path(aurin_path,
                  'plm_last.RDS'))

#1. trends -----

trend_temp <- alldata %>%
  group_by(sa2_name) %>%
  do(model = lm(temp ~ year, data = .))

trend_temp %>%
  mutate(tidy = map(model, broom::tidy)) %>%
  unnest(tidy) %>%
  filter(term == 'year') %>%
  select(sa2_name, estimate)

#2. one-way fixed effects panel data

oneway_within_plm <- plm(log(temp) ~ log(vegetation) + log(pop_density),
                         data = alldata,
                         index = c('sa2_name', 'year'),
                         model = 'within')

summary(oneway_within_plm)


