#!/bin/sh

echo "Fetching Data"
lynx -dump http://www.hkex.com.hk/eng/ddp/Contract_Details.asp?PId=2 | sed -e '1,21d' -e 's/[ \t]*//' > HSI.txt

lynx -dump http://www.hkex.com.hk/eng/ddp/Contract_Details.asp?PId=6 |
sed -e '1,21d' -e 's/[ \t]*//' > HHI.txt

echo "Data Fetch Completed"

./format.rb "HSI"
./format.rb "HHI"

echo "Finisehd Formatting"

./mov.sh
