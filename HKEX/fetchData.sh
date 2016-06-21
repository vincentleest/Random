#!/bin/bash

SCRIPT_ROOT="$HOME/workspace/Random/HKEX/"
DROPBOX_UPLOADER="$SCRIPT_ROOT/dropbox_uploader.sh"

NOW=$(date +"%F")
HSI_DATE=$(date +"%-d%b%y")
FILE_NAMES=(HSI HHI HKB TCH HEX CHT XCC)
ZIP_FILE_NAMES=(hsif hsio hhif hhio stock dqe)

cd $SCRIPT_ROOT
echo "Fetching Data"
lynx -dump -width=100 http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=2 | sed -e '1,21d' -e 's/[ \t]*//' > HSI.txt
lynx -dump -width=100 http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=6 | sed -e '1,21d' -e 's/[ \t]*//' > HHI.txt
lynx -dump -width=100 http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=117 | sed -e '1,21d' -e 's/[ \t]*//' > HKB.txt
lynx -dump -width=100 http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=157 | sed -e '1,21d' -e 's/[ \t]*//' > TCH.txt
lynx -dump -width=100 http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=82 | sed -e '1,21d' -e 's/[ \t]*//' > HEX.txt
lynx -dump -width=100 http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=63 | sed -e '1,21d' -e 's/[ \t]*//' > CHT.txt
lynx -dump -width=100 http://www.hkex.com.hk/eng/ddp/contract_details.asp?pid=237 | sed -e '1,21d' -e 's/[ \t]*//' > XCC.txt

echo "Data Fetch Completed"

for i in ${FILE_NAMES[@]}
do 
 ./format.rb $i
done
echo "Finisehd Formatting"

echo "Uploading files"
TODAY=$(date +"%y%m%d")
#moving files around
$DROPBOX_UPLOADER -f "$HOME/.dropbox_uploader" mkdir $NOW 

for i in ${FILE_NAMES[@]}
do 
  $DROPBOX_UPLOADER -f "$HOME/.dropbox_uploader" upload "$SCRIPT_ROOT/$i.csv" "$NOW/$i$TODAY.csv" 
done

echo "Upload completed, cleaning up"
rm *.csv

mkdir "archive$TODAY"
mv *.txt "archive$TODAY/"
zip -r "archive$TODAY.zip" "archive$TODAY"
rm -r "archive$TODAY/"

for i in ${ZIP_FILE_NAMES[@]}
do 
  wget -w 3 -t 3 "https://www.hkex.com.hk/eng/stat/dmstat/dayrpt/$i$TODAY.zip"
  $DROPBOX_UPLOADER -f "$HOME/.dropbox_uploader" upload "$SCRIPT_ROOT/$i$TODAY.zip" "$NOW/"
done

wget -U 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4' -w 3 -t 3 "http://www.hsi.com.hk/HSI-Net/static/revamp/contents/en/indexes/report/hsi/HSI_$HSI_DATE.xls"
wget -U 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4'-w 3 -t 3 "http://www.hsi.com.hk/HSI-Net/static/revamp/contents/en/indexes/report/hscei/HSCEI_$HSI_DATE.xls"
wget -U 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4'-w 3 -t 3 "http://www.hsi.com.hk/HSI-Net/static/revamp/contents/en/indexes/Index_Performance_Summary_$HSI_DATE.xls"

$DROPBOX_UPLOADER -f "$HOME/.dropbox_uploader" upload "$SCRIPT_ROOT/archive$TODAY.zip" "$NOW/"
$DROPBOX_UPLOADER -f "$HOME/.dropbox_uploader" upload "$SCRIPT_ROOT/HSI_$HSI_DATE.xls" "$NOW/"
$DROPBOX_UPLOADER -f "$HOME/.dropbox_uploader" upload "$SCRIPT_ROOT/HSCEI_$HSI_DATE.xls" "$NOW/"
$DROPBOX_UPLOADER -f "$HOME/.dropbox_uploader" upload "$SCRIPT_ROOT/Index_Performance_Summary_$HSI_DATE.xls" "$NOW/"

rm *.zip
rm *.xls
