#!/bin/sh

SCRIPT_ROOT="/home/vincent/workspace/Random/HKEX/"
DROPBOX_UPLOADER="$SCRIPT_ROOT/dropbox_uploader.sh"


cd $SCRIPT_ROOT

echo "Uploading files"
TODAY="150119"
NOW="2015-01-19"

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

rm *.zip
