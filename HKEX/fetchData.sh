#!/bin/sh

echo "Fetching Data"
lynx -dump http://www.hkex.com.hk/eng/ddp/Contract_Details.asp?PId=2 | sed -e '1,21d' -e 's/[ \t]*//' > HSI.txt

#head -n -22 HSI.txt

lynx -dump http://www.hkex.com.hk/eng/ddp/Contract_Details.asp?PId=6 |
sed -e '1,21d' -e 's/[ \t]*//' > HHI.txt

./nok.rb
#head -n -22 HSI.txt

#sed -i -e 's/[ \t]*//' HSI.txt
#sed -i -e 's/[ \t]*//' HHI.txt
