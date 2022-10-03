#import libriaries
library('gmailr')
library('miniUI')
library('shiny')
library('shinyFiles')
library('gmailr')
library('cronR')

#define main objects
gmail_key='YOUR_KEY'
gmail_secret='YOUR_SECRET'
working_dir = getwd()

#Gmail API OAuth 
gm_auth_configure(gmail_key,gmail_secret)
gm_auth()

#import the newest message from Gmail
email_listing <- gm_threads(num_results = 1)
your_message <- gm_thread(gm_id(email_listing)[[1]])
message_id1 <- your_message$messages[[1]]

#delete message after importing to R
gm_delete_message(your_message$id, user_id = "me")

#message manipulation
x <- toString(gm_body(your_message))
mail <- strsplit(x, split = ";\r\n")

mail_url <- gsub(' <.*>',"",mail[[1]][1])
mail_url <- gsub("Url: ","",mail_url)
mail_title <- gsub('Title: ',"",mail[[1]][2])
mail_img <- gsub(' <.*>',"",mail[[1]][3])
mail_img <- gsub("Img: ","",mail_img)
mail_desc <- gsub("Description: ","",mail[[1]][4])
mail_stat <- gsub("Status: ","",mail[[1]][5])

#create json string and store in file for further actions - sampel post structure
html = paste0("<p><b>Link:</b> <a href='",mail_url,"'>Jump to source</a></p><p>",mail_desc,"</p>")
html <- toString(html)
json <- paste0('{"posts":[{"title":"',mail_title,'","status":"',mail_stat,'","html":"',html,'","feature_image":"',mail_img,'","custom_template":"custom-narrow-feature-image"}]}')
#--delete previous file
file.remove(paste0(working_dir,'/json.json'))
#--create new file
fileConn<-file(paste0(working_dir,'/json.json'))
writeLines(json, fileConn)
close(fileConn)

#create crontab schedule for this .R script using CronR - line 49 should be #### after CronR configuration
cronR::cron_rstudioaddin()