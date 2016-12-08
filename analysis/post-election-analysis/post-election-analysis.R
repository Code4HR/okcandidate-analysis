# post-election-analysis.R
# Copyright (c) 2016 Code for Hampton Roads (Norfolk/Virginia Beach)

options(stringsAsFactors = FALSE)

suppressWarnings(suppressPackageStartupMessages(library(RPostgreSQL)))
suppressWarnings(suppressPackageStartupMessages(library(ggplot2)))
suppressWarnings(suppressPackageStartupMessages(library(magrittr)))
suppressWarnings(suppressPackageStartupMessages(library(dplyr)))
suppressWarnings(suppressPackageStartupMessages(library(lubridate)))
suppressWarnings(suppressPackageStartupMessages(library(stringr)))

source('./lib/survey-response-lib.R')


# load data -------------------------------------------------------------------------------------------------------

#queryOKCDB()

survey_responses <- read.csv('./data/survey-responses.csv')


# calc summary stats -------------------------------------------------------------------------------------------------------

#hist(survey_responses$intensity)

cat_summary <- survey_responses %>% 
  group_by(category_name) %>%
  summarize(n=n(), 
            intensity_mean=mean(intensity),
            intensity_sd=sd(intensity)) %>%
  arrange(desc(intensity_sd))


# avg intensity by category ---------------------------------------------------------------------------
  
# refactor the levels to arrange in ascending orders
cat_summary %<>%
  mutate(category_name_fac = factor(category_name, 
                                    levels = cat_summary %>% 
                                      arrange(desc(intensity_mean)) %>% 
                                      .$category_name))

plot_title <- 'avg_intensity_by_question_category'
p <- ggplot(cat_summary, 
            aes(x=category_name_fac,
                y=intensity_mean, 
                fill=category_name_fac)) +
  geom_bar(position=position_dodge(), 
           stat="identity", 
           colour='black') +
  geom_errorbar(aes(ymin=intensity_mean - intensity_sd, 
                ymax=intensity_mean + intensity_sd), 
                width=.2, 
                position=position_dodge(.9)) + 
  scale_x_discrete(name='Category', 
                   labels = function(x) str_wrap(x, width = 20)) + 
  scale_fill_discrete("Category") + 
  scale_y_continuous(name='Avg. Intensity') + 
  ggtitle(format_col_names(plot_title)) + 
  theme(plot.title = element_text(color="#666666", face="bold", size=28, hjust=0)) +
  theme(axis.title = element_text(color="#666666", face="bold", size=22)) 

ggsave(filename=file.path('./graphs', 
                          sprintf('%s.png', plot_title)), 
       plot=p)


# std dev intensity by category ---------------------------------------------------------------------------

# refactor the levels to arrange in ascending order
cat_summary %<>%
  mutate(category_name_fac = factor(category_name, 
                                    levels = cat_summary %>% 
                                      arrange(desc(intensity_sd)) %>% 
                                      .$category_name))

plot_title <- 'std_dev_intensity_by_question_category'
p <- ggplot(cat_summary, 
       aes(x=category_name_fac,
           y=intensity_sd, 
           fill=category_name_fac)) +
  geom_bar(position=position_dodge(), 
           stat="identity", 
           colour='black') + 
  scale_x_discrete(name='Category', labels = function(x) str_wrap(x, width = 10)) + 
  scale_fill_discrete("Category") + 
  scale_y_continuous(name='Std. Dev. Intensity') +
  ggtitle(str_wrap(format_col_names(plot_title), width = 20)) + 
  theme(plot.title = element_text(color="#666666", face="bold", size=28, hjust=0)) +
  theme(axis.title = element_text(color="#666666", face="bold", size=22)) 

ggsave(filename=file.path('./graphs', 
                          sprintf('%s.png', plot_title)), 
       plot=p)


# avg intensity by category ---------------------------------------------------------------------------

plot_title <- 'intensity_distribution_by_question_category'
p <- ggplot(survey_responses, 
       aes(x=as.factor(intensity), 
           fill=as.factor(intensity))) + 
  geom_bar() + 
  facet_grid( ~ category_name, labeller=labeller(category_name = label_wrap_gen(10))) + 
  scale_fill_discrete("Intensity") +
  scale_x_discrete(name="Intensity") + 
  scale_y_continuous(name='Count') + 
  ggtitle(str_wrap(format_col_names(plot_title), width = 20)) + 
  theme(plot.title = element_text(color="#666666", face="bold", size=28, hjust=0)) +
  theme(axis.title = element_text(color="#666666", face="bold", size=22))

ggsave(filename=file.path('./graphs', 
                          sprintf('%s.png', plot_title)), 
       plot=p)

