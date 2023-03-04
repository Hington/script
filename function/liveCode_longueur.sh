#!/bin/bash
read -p "entrez un mot : " MOT
read -p "entrez un deuxieme mot : " MOT_DEUX
longueur () {
MotUn=${#MOT}
MotDeux=${#MOT_DEUX}
if [ $MotUn -gt $MotDeux ]
then
echo "$MOT est la chaine la plus longue"
elif [$MotUn -lt $MotDeux ]
then
echo "$MOT_DEUX est la chaine la plus longue"
else
echo "égal"
fi
}

longueur
