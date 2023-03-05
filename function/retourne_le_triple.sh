#!/bin/bash
read -p "entre un nombre : " nombre
TRIPE () {
calcule=$(($nombre * 3))
echo $calcule
}
echo "le tripe de $nombre est : " 

TRIPE 
