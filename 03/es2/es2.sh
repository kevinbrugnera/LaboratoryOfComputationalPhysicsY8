#!/bin/bash

#1a
cp data.csv data.txt

sed -i '/^#/d' data.txt # -i insert in file (-e show in terminal) -> delete what begins with #
sed -i 's/,//g' data.txt # substituto (,) <-> ( ) globaly

#1b
n=$(grep -c '' data.txt) #number of lines

even=0
for (( i=1; i<=n; i++ )) #loop over rows
do
    for (( j=1; j<=6; j++ )) #loop over columns
    do
        X=$(sed -n "${i}p" data.txt | cut -f${j} -d " ") # use "" not ''
        P=$(( $X % 2 ))
        if [ $P -eq 0 ]; then # -eq to compare numbers
            even=$(($even + 1))
        fi
    done
done
echo "There are $even even numbers"

#1c
gt=0
for (( i=1; i<=n; i++ )); do
    for (( j=1; j<=2; j++ )); do  # loop over columns
        jy=$((j+1))
        jz=$((j+2))

        # extract numbers
        X=$(sed -n "${i}p" data.txt | cut -f"$j" -d " ")
        Y=$(sed -n "${i}p" data.txt | cut -f"$jy" -d " ")
        Z=$(sed -n "${i}p" data.txt | cut -f"$jz" -d " ")

        # sum of squares
        D=$((X*X + Y*Y + Z*Z))

        # sqrt
        sqr=$(echo "scale=6; sqrt($D)" | bc)
        sqr3=$(echo "scale=6; sqrt(3)" | bc)

        # comparison
        is_gt=$(echo "$sqr > (100*$sqr3/2)" | bc)
        if [ "$is_gt" -eq 1 ]; then
            gt=$((gt + 1))
        fi
    done
done
echo "There are $gt greater than 100*sqrt(3)/2"
echo "There are $((n*6 - gt)) not greater than 100*sqrt(3)/2"

#1d
read -p "Enter N:" N

mkdir Data_frac${N}
for (( j=1; j<=N; j++ )); do
    #divide by number and redirect to file
    touch Data_frac${j}.txt
    mv Data_frac${j}.txt Data_frac${N}
    done
    
for (( i=1; i<=n; i++ )); do
    # extract numbers
    X=$(sed -n "${i}p" data.txt | cut -f1 -d " ")
    Y=$(sed -n "${i}p" data.txt | cut -f2 -d " ")
    Z=$(sed -n "${i}p" data.txt | cut -f3 -d " ")
    X1=$(sed -n "${i}p" data.txt | cut -f4 -d " ")
    Y1=$(sed -n "${i}p" data.txt | cut -f5 -d " ")
    Z1=$(sed -n "${i}p" data.txt | cut -f6 -d " ")

    for (( j=1; j<=N; j++ )); do
    #divide by number and redirect to file
    Xdiv=$(echo "scale=6; $X / $j" | bc)
    Ydiv=$(echo "scale=6; $Y / $j" | bc)
    Zdiv=$(echo "scale=6; $Z / $j" | bc)
    X1div=$(echo "scale=6; $X1 / $j" | bc)
    Y1div=$(echo "scale=6; $Y1 / $j" | bc)
    Z1div=$(echo "scale=6; $Z1 / $j" | bc)
    
    echo "$Xdiv $Ydiv $Zdiv $X1div $Y1div $Z1div" >> Data_frac${N}/Data_frac${j}.txt
    done
done

