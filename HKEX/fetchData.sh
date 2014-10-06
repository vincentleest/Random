#!/bin/sh

SCRIPT_ROOT="/home/vincent/workspace/Random/HKEX/"
DROPBOX_UPLOADER="$SCRIPT_ROOT/dropbox_uploader.sh"

NOW=$(date +"%F")

cd $SCRIPT_ROOT
echo "Fetching Data"
lynx -dump http://www.hkex.com.hk/eng/ddp/contract_Details.asp?PId=2 | sed -e '1,21d' -e 's/[ \t]*//' > HSI.txt
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
#moving files around
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader mkdir "$NOW" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/HHI.csv" "$NOW/HHI.csv" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/HSI.csv" "$NOW/HSI.csv" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/HKB.csv" "$NOW/HKB.csv" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/TCH.csv" "$NOW/TCH.csv" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/HEX.csv" "$NOW/HEX.csv" 

$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload "$SCRIPT_ROOT/CHT.csv" "$NOW/CHT.csv" 

echo "Upload completed, cleaning up"
rm *.csv
rm *.txt


TODAY=$(date +"%y%m%d")
wget "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/hsif$TODAY.zip"
wget "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/hsio$TODAY.zip"
wget "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/hhif$TODAY.zip"
wget "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/hhio$TODAY.zip"
wget "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/stock$TODAY.zip"
wget "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/dqe$TODAY.zip"


$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/hsif$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/hsio$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/hhif$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/hhio$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/stock$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f /home/vincent/.dropbox_uploader upload  "$SCRIPT_ROOT/dqe$TODAY.zip" "$NOW/"

rm *.zip
