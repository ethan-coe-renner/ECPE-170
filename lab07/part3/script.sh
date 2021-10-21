#!/usr/bin/env bash

echo "algorithm,n,flops" > flops.csv

for j in 1 2
do
    for i in 256 512 768 1024 1280 1536 1792 2048
    do
	s=$(./matrix_math $j $i)

	flops=$(echo $s | awk '{print $NF}')

	echo $j,$i,$flops >> flops.csv
    done
done


