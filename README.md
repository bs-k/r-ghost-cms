# GHOST-R-CMS

Publish posts on your [Ghost CMS](https://ghost.org) powered blog by sending messages via Gmail.

# PRE REQUIREMENTS

1. Valid Gmail account (to which you will send your posts)
2. Google Cloud app with authorized OAuth credentials (key & secret)
3. Nginx server with R/RStudio instance and working Cron
4. Running instance of Ghost CMS

# EMAIL STRUCTURE (BODY / EMAIL TEXT) - SAMPLE

Url: https://samplesite.com/sample-news;
Title: Sample post title;
Img: https://samplesite.com/sample.img;
Description: sample description placed in your posts body;
Status: published

# HOW TO BLOG

1. Create new directory on your Nginx server
2. Place both files in it (ghost-api.py & main.R)
3. Configure both files
4. Run CronR (see main.R details)
5. Edit crontab as below (scheduled .py job every minute):
* */1 * * * * /usr/bin/python3 "/YOUR-WORKING-DIRECTORY/ghost-api.py" ; rm /YOUR-WORKING-DIRECTORY/json.json > /YOUR-WORKING-DIRECTORY/cron.log

# JUST BLOG!

If you configured everything properly, every post with the correct structure will be posted to your Ghost CMS page automatically. Enjoy!