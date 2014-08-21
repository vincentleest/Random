#!/bin/sh

NOW=$(date +"%F")

mkdir $NOW

mv HHI.csv ./$NOW/HHI.csv
mv HSI.csv ./$NOW/HSI.csv

rm *.txt
