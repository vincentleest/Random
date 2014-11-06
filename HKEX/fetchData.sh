#!/bin/sh

SCRIPT_ROOT="/home/vincent/workspace/Random/HKEX/"
DROPBOX_UPLOADER="$SCRIPT_ROOT/dropbox_uploader.sh"

NOW=$(date +"%F")

cd $SCRIPT_ROOT
echo "Fetching Data"
lynx -dump http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=2 | sed -e '1,21d' -e 's/[ \t]*//' > HSI.txt
lynx -dump http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=6 | sed -e '1,21d' -e 's/[ \t]*//' > HHI.txt
lynx -dump http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=117 | sed -e '1,21d' -e 's/[ \t]*//' > HKB.txt
lynx -dump http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=157 | sed -e '1,21d' -e 's/[ \t]*//' > TCH.txt
lynx -dump http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=82 | sed -e '1,21d' -e 's/[ \t]*//' > HEX.txt
lynx -dump http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=63 | sed -e '1,21d' -e 's/[ \t]*//' > CHT.txt

echo "Data Fetch Completed"

./format.rb "HSI"
./format.rb "HHI"
./format.rb "HKB"
./format.rb "TCH"
./format.rb "HEX"
./format.rb "CHT"

echo "Finisehd Formatting"

echo "Uploading files"
TODAY=$(date +"%y%m%d")
#moving files around
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader mkdir "$NOW" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/HHI.csv" "$NOW/HHI$TODAY.csv" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/HSI.csv" "$NOW/HSI$TODAY.csv" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/HKB.csv" "$NOW/HKB$TODAY.csv" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/TCH.csv" "$NOW/TCH$TODAY.csv" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/HEX.csv" "$NOW/HEX$TODAY.csv" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/CHT.csv" "$NOW/CHT$TODAY.csv" 

echo "Upload completed, cleaning up"
rm *.csv

mkdir "archive$TODAY"
mv *.txt "archive$TODAY/"
zip -r "archive$TODAY.zip" "archive$TODAY"
rm -r "archive$TODAY/"

wget -w 3 -t 3 "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/hsif$TODAY.zip"
wget -w 3 -t 3 "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/hsio$TODAY.zip"
wget -w 3 -t 3 "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/hhif$TODAY.zip"
wget -w 3 -t 3 "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/hhio$TODAY.zip"
wget -w 3 -t 3 "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/stock$TODAY.zip"
wget -w 3 -t 3 "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/dqe$TODAY.zip"


$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/hsif$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/hsio$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/hhif$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/hhio$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/stock$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/dqe$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/archive$TODAY.zip" "$NOW/"

rm *.zip
