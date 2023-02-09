#!/bin/bash

read -p "saissir une note " NOTE

while [ -z $NOTE ]
do 
	read -p "saissir une note " NOTE
done

 
if [ $NOTE -ge 0 ] && [ $NOTE -lt 10 ] 
then
	echo "Insuffissant"
	
elif [ $NOTE -ge 10 ] && [ $NOTE -le 12 ] 
then
	echo "Assez bien"

elif [ $NOTE -ge 14 ] && [ $NOTE -le 16 ] 
then
	echo "Bien"
	
elif [ $NOTE -ge 10 ] && [ $NOTE -lt 20 ] 
then
	echo "Très bien"

else echo "la note doit être compris entre 1 et 20"
fi
