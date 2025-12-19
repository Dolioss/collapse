set.seed(99)
setwd(getwd())

df <- read.csv("r_collapse_posts.csv")

df_clean <- df[
  !is.na(df$selftext) &
    df$selftext != "" &
    df$selftext != "[removed]" &
    df$selftext != "[deleted]",
]

sampled_rows <- df_clean[sample(nrow(df_clean), 200), ]

output <- sampled_rows[, c("id", "selftext")]

write.csv(output, "sampled_texts2.csv")

head(output)
