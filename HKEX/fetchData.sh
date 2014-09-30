#!/bin/sh

SCRIPT_ROOT="/home/vincent/workspace/Random/HKEX/"
DROPBOX_UPLOADER="$SCRIPT_ROOT/dropbox_uploader.sh"
NOW=$(date +"%F")

cd $SCRIPT_ROOT
echo "Fetching Data"
lynx -dump http://www.hkex.com.hk/eng/ddp/Contract_Details.asp?PId=2 | sed -e '1,21d' -e 's/[ \t]*//' > HSI.txt
lynx -dump http://www.hkex.com.hk/eng/ddp/Contract_Details.asp?PId=6 |
sed -e '1,21d' -e 's/[ \t]*//' > HHI.txt

echo "Data Fetch Completed"

./format.rb "HSI"
./format.rb "HHI"

echo "Finisehd Formatting"

echo "Uploading files"
#moving files around
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader mkdir "$NOW" >> ~/log
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/HHI.csv" "$NOW/HHI.csv" >> ~/log
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/HSI.csv" "$NOW/HSI.csv" >> ~/log

echo "Upload completed, cleaning up"
rm HHI.*
rm HSI.*
