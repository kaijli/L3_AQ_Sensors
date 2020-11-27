library(tidyverse)

tues <- read.csv("tuesday_data.csv")
thur <- read.csv("thursday_data.csv")

tues <- tues %>%
  mutate(day = "Tuesday")
  
thur <- thur %>%
  mutate(day = "Thursday")

aq_data1 <- bind_rows(tues, thur) %>%
  mutate(sen = case_when((sensor == 3) ~ "03",
                       (sensor == 5) ~ "05",
                       (sensor == 9) ~ "09",
                       (sensor == 10) ~ "10",
                       (sensor == 11) ~ "11",
                       (sensor == 14) ~ "14",
                       (sensor == 18) ~ "18",
                       (sensor == 19) ~ "19",
                       (sensor == 21) ~ "21"))



aq_data_1 <- aq_data1 %>%
  select(-pm_25, -pm_10) %>%
  mutate(pm = "pm_1") %>%
  rename(reading = pm_1)

aq_data_25 <- aq_data1 %>%
  select(-pm_1, -pm_10) %>%
  mutate(pm = "pm_2.5") %>%
  rename(reading = pm_25)

aq_data_10 <- aq_data1 %>%
  select(-pm_25, -pm_1) %>%
  mutate(pm = "pm_10") %>%
  rename(reading = pm_10)

aq_data2 <- bind_rows(aq_data_1, aq_data_25, aq_data_10) 


## remodled/built after 2000 = newer
#creating a north south line passing through the rugby field andpassing through the PAB entrance. 19, 11, 5, 10 are west. 3, 18, 21, 9, 14 are east.

aq_data3 <- aq_data2 %>% 
  mutate( build_age = case_when((sensor=="18"| sensor== "21"| sensor =="9" |sensor =="19" |sensor =="11") ~ "old",   
                                (sensor=="5"| sensor== "10"| sensor=="3"  | sensor =="14") ~ "new")) %>%
  mutate(direction = case_when((sensor=="5"| sensor== "10"| sensor=="19"  | sensor =="11") ~ "west",
                               (sensor=="18"| sensor== "14"| sensor=="9"  | sensor =="3" | sensor=="21") ~ "east"))

aq_data4 <- aq_data3 %>%
  select(sen, reading, day, location, pm, build_age, direction) %>%
  rename(sensor = sen)

write.csv(aq_data4, "On_Campus_AQ_Data.csv")



aq_data5 <- aq_data1 %>% 
  mutate( build_age = case_when((sensor=="18"| sensor== "21"| sensor =="9" |sensor =="19" |sensor =="11") ~ "old",   
                                (sensor=="5"| sensor== "10"| sensor=="3"  | sensor =="14") ~ "new")) %>%
  mutate(direction = case_when((sensor=="5"| sensor== "10"| sensor=="19"  | sensor =="11") ~ "west",
                               (sensor=="18"| sensor== "14"| sensor=="9"  | sensor =="3" | sensor=="21") ~ "east"))


write.csv(aq_data5, "Tues_Thur_Data.csv")
