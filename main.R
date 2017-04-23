library("rtweet")
library("dplyr")
library("magick")
library("httr")
library("stringr")
library("purrr")

trump_data <- search_tweets(q= '#americafirst OR #presidenttrump OR #maga',
                      n = 10000,
                      usr = T)
trump_users <- users_data(trump_data)

hillary_data <- search_tweets(q= '#imwithher OR #presidentclinton',
                            n = 10000,
                            usr = T)
hillary_users <- users_data(hillary_data)

df_trump <- tbl_df(data.frame(name=trump_users$name,
                   msg=trump_data$text)) %>%
    mutate(
        name.flag = str_detect(string = .$name,pattern = '\\U0001f1fa\\U0001f1f8'),
        msg.flag = str_detect(string = .$msg,pattern = '\\U0001f1fa\\U0001f1f8')

    )
...........................
df_trump %>% distinct() -> df_trump_distinct


df_trump_distinct %>% dim

df_hillary <- tbl_df(hillary_users$name) %>%
    mutate(
        flag = str_detect(string = .$value,pattern = '\\U0001f1fa\\U0001f1f8')
    )

df_hillary %>% distinct() -> df_hillary_distinct


df_hillary_distinct %>% dim

intersect(df_hillary_distinct$value,df_trump_distinct$value) %>% length()

table(df_trump_distinct$flag) %>% prop.table
table(df_hillary_distinct$flag) %>% prop.table
