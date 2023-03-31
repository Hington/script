#!/bin/bash
echo "------------ PROJET CRUD ------------"
DEBUT() {
echo -e "1-Connexion \n2-Inscription"
read -p "votre choix : " choix
case $choix in
1)
CONNEXION
;;
2)
INSCRIPTION
;;
esac
}

INSCRIPTION() {
read -p "entrer un login : " login
echo "entrer un mot de passe : "
read -s pwd
jq '. +=[{"nom":"'$login'","mot_passe":"'$pwd'"}]' login.json >tmp && mv tmp login.json
echo "Connectez-vous :"
CONNEXION
}

CONNEXION() {
read -p 'entrer votre login : ' login
echo "entrer un mot de passe : "
read -s pwd
 jq -c '.[] | select(.nom=="'$login'" and .mot_passe=="'$pwd'")' login.json >loginC.txt
if [ -s loginC.txt ]
then
if [ -e $(pwd)/home/$login.json ]
then
echo "BIENVENU $login"
while [ True ]
do
MENU_TACHE
done
else
touch $(pwd)/home/$login.json
echo "BIENVENU $login votre espace de travail à été bien créer"
while [ True ]
do
MENU_TACHE
done
fi
else
echo "erreur sur le mot de passe ou le login"
DEBUT
fi
} 

MENU_TACHE(){
echo -e "Que souhaitez-vous faire ? \n 1 : Afficher la liste des tâches \n 2 : Ajourter une tâche \n 3 : Supprimer une tâche \n 4 : Modifier une tâche \n 5 : Quitter"

read -p " choisir : " AFFICHER
case $AFFICHER in

1)
if [ -s $(pwd)/home/$login.json ]
then
jq '.[]' $(pwd)/home/$login.json
else
echo " le fichier est vide "
fi
;;

2)
read -p " Ajouter une tâche : " AJOUT
if [ -s $(pwd)/home/$login.json ]
then
#jq '. +=[{"tache":"'$AJOUT'"}]' $login.json >tmp && mv tmp $login.json
jq '. +=["'$AJOUT'"]' $(pwd)/home/$login.json >tmp && mv tmp $(pwd)/home/$login.json
else
echo [] > $(pwd)/home/$login.json
#jq '. +=[{"tache":"'$AJOUT'"}]' $login.json >tmp && mv tmp $login.json
jq '. +=["'$AJOUT'"]' $(pwd)/home/$login.json >tmp && mv tmp $(pwd)/home/$login.json
fi
;;
3)
read -p " entrez la tache à supprimer  : " TACHE_SUP
jq -c '.[] | select(. =="'$TACHE_SUP'")' $(pwd)/home/$login.json >loginC.txt
if [ -s loginC.txt ]
then
jq 'del(.[] |select(. =="'$TACHE_SUP'"))' $(pwd)/home/$login.json >tmp && mv tmp $(pwd)/home/$login.json
echo " les tâches $TACHE_SUP à  bien été supprimée "
else
echo " la tache n'existe pas "
fi
;;
4)
if [ -s $(pwd)/home/$login.json ]
then
CPT=`jq length $(pwd)/home/$login.json`
read -p 'entrer le numero de la ligne à modifier: ' NOMBRE
if [ $NOMBRE -gt $CPT ] 
then
echo " a cette ligne $NOMBRE il y'a aucune tache " 
else
read -p 'entrer la nouvelle tache : ' TACHE_MODI
jq '.['$NOMBRE']="'$TACHE_MODI'"' $(pwd)/home/$login.json >tmp && mv tmp $(pwd)/home/$login.json 
echo " la tache a été bien modifier "
fi
else
echo " Ajouter une tâche SVP !!!! "
fi
;;

5)
exit
;;
esac
}



DEBUT

