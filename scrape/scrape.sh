#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)

pb heroku/title

pb rclone/login
pb rclone
pb grep
pb reddit

rcloud reddit
rclogin reddit sia imasubreddit

cd
mkdir data
touch data/"$REDDIT.txt"

echo "getting submissions"
rdsubmissions "$REDDIT"
rdid push.txt submissions.txt
rm push.txt

echo "scraping"

while :; do
    if ! test -e data; then
        break
    fi
    tail -1 data/"$REDDIT.txt"
    wc -l data/"$REDDIT.txt"
    sleep 20
done &

python3 redditscraper.py >data/"$REDDIT.txt"
echo "done scraping, uploading"
DATE=$(date +%Y%m%d_%H%M%S)
mv data "$DATE"
rupl "$DATE"
rm -rf $DATE
echo "exited"
sleep 5m
