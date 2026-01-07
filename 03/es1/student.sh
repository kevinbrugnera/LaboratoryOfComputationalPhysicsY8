#!/bin/bash

#1b
touch PoD_st.csv
touch P_st.csv
grep "PoD" LCP_22-23_students.csv >> PoD_st.csv
grep "Physics" LCP_22-23_students.csv >> Physics_st.csv

#1c
sed -i  '1d' LCP_22-23_students.csv # sed insert -> first (1) delete (d)
for i in {A..Z} 
do 
    count=$(grep -c "^$i" LCP_22-23_students.csv) # $(command) makes the output a variable
    echo "$i : $count times" >> Surname_count.txt # redirect appending in a text file
done

#1d
most_count=0
most_i=""
for i in {A..Z}
do
    count=$(grep -c "^$i" LCP_22-23_students.csv)
    
    if [ $count -gt $most_count ]; then
        most_count=$count
        most_i=$i
    fi
done
echo "Most counted letter: $most_i counted $most_count times."

#1e
mkdir Mod18
n=$(grep -c "" LCP_22-23_students.csv)

for (( i=1; i<=18; i++))
do
    j=$i
    while [ $j -lt $n ]
    do
        echo "$(sed -n "${j}p" LCP_22-23_students.csv)" >> LCP_22-23_students_Mod18_${i}.csv
        j=$(($j + 18))
    done
    mv LCP_22-23_students_Mod18_${i}.csv Mod18
done
