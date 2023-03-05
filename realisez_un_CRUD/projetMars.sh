#!/bin/bash
parse_yaml() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}
eval $(parse_yaml fichierLogin.yml "config_")


#------------------------------debut fonction tache cette function vas demander a l'utilisateur les different tache qu"il voudrais executé

fun_Tache () {
echo -e "Que souhaitez-vous faire ? \n 1 : Afficher la liste des tâches \n 2 : Ajourter une tâche \n 3 : Supprimer une tâche \n 4 : Modifier une tâche \n 5 : Quitter"
read -p " choisir : " AFFICHE
case $AFFICHE in

1)
if [ -s /home/hington/mesScript/projetMars/tache.JSON ]
then
cat /home/hington/mesScript/projetMars/tache.JSON
else
echo " le fichier est vide "
fi
;;

2)
read -p " Ajouter une tâche : " AJOUT
if [ -s /home/hington/mesScript/projetMars/tache.JSON ]
then
sed -i 1i$AJOUT  /home/hington/mesScript/projetMars/tache.JSON 
elif [ -e /home/hington/mesScript/projetMars/tache.JSON ] && [ -z /home/hington/mesScript/projetMars/tache.JSON ] 
then
echo $AJOUT > /home/hington/mesScript/projetMars/tache.JSON
else
echo $AJOUT > tache.JSON
fi
;;

3)
if [ -s /home/*/*/*/tache.JSON ] 
then
echo -e "combien de ligne voulez vous supprimer : \n 1 : une ligne \n 2 : ligne P et K \n 3 : ligne P à K \n 4 : Quitter"
read -p "entrez votre reponse : " SUP

#----------------------debut case on fait u autre case pour demander à l'utilisateur  sil veut supprimer
case $SUP in
1)
read -p " entrez le numero de la ligne : " NUM_SUP
read -p " voulez vous vraiment supprimé la ligne $NUM_SUP [ O/N ] : " SUPPRIMER_LIGNE
if [ "$SUPPRIMER_LIGNE" = "O" ] || [ "$SUPPRIMER_LIGNE" = "o" ]
then
sed -i $NUM_SUP'd' /home/hington/mesScript/projetMars/tache.JSON
echo " la tâche $NUM_SUP  a bien été supprimée "
elif [ "$SUPPRIMER_LIGNE" = "N" ] || [ "$SUPPRIMER_LIGNE" = "n" ]
then
fun_Tache
else
echo " touche inconnue"
fi
;;

2)
read -p " entrez le numero de la premier (P) ligne  : " NUM_SUP
read -p " entrez le numero de la seconde (K) ligne : " NUM_SUP_DEUX
read -p " voulez vous vraiment supprimé la ligne $NUM_SUP et $NUM_SUP_DEUX [ O/N ] : " SUPPRIMER_LIGNE
if [ "$SUPPRIMER_LIGNE" = "O" ] || [ "$SUPPRIMER_LIGNE" = "o" ]
then
sed -i $NUM_SUP'd;'$NUM_SUP_DEUX'd' /home/hington/mesScript/projetMars/tache.JSON
echo " les tâches $NUM_SUP et $NUM_SUP_DEUX ont bien été supprimée "
elif [ "$SUPPRIMER_LIGNE" = "N" ] || [ "$SUPPRIMER_LIGNE" = "n" ]
then
fun_Tache
else
echo " touche inconnue "
fi
;;

3)
read -p " entrez le numero de la premier (P) ligne  : " NUM_SUP
read -p " entrez le numero de la dernièe (K) ligne : " NUM_SUP_DEUX
read -p " voulez vous vraiment supprimé de la ligne $NUM_SUP à $NUM_SUP_DEUX [ O/N ] : " SUPPRIMER_LIGNE
if [ "$SUPPRIMER_LIGNE" = "O" ] || [ "$SUPPRIMER_LIGNE" = "o" ]
then
sed -i $NUM_SUP','$NUM_SUP_DEUX'd' /home/hington/mesScript/projetMars/tache.JSON
echo " les tâches $NUM_SUP à $NUM_SUP_DEUX ont bien été supprimée "
elif [ "$SUPPRIMER_LIGNE" = "N" ] || [ "$SUPPRIMER_LIGNE" = "n" ]
then
fun_Tache
else
echo " touche inconnue "
fi
;;
4)
fun_Tache
;;
*)
echo "touche inconnue error "
esac
#---------------fin case supprime------------------------
else
echo "le fichier n'existe pas ou est vide"
fi
;;

4)
if [ -s /home/hington/mesScript/projetMars/tache.JSON ]
then
nano /home/hington/mesScript/projetMars/tache.JSON
else
echo " Ajouter une tâche SVP !!!! "
fi
;;

5)
exit
;; 
esac
}
#------------------------------------------------------------------------------------------------------fin function tache---------------------------------------------------------

#--------------debut function connexion cette function vas demandé à l'utilisateur de se connecté
Fun_Connexion () {
	echo "connectez-vous"
    read -p "login : " LOGIN
#---------------------------------------------debut while verification login user
while [ "$LOGIN" != "$config_LOGINUSER" ]
do
echo "login incorrecte"
read -p "login : " LOGIN
done
#------------------------------------------fin while verification login user---------------------------------------------------
stty -echo
read -p "mot de passe :  " MDP
echo " "
stty echo
#----------------debut while verification mot de passe user
while [ "$MDP" != "$config_MDPUSER" ]
do
echo "mot de passe incorrecte"
stty -echo
read -p "mot de passe :  " MDP
echo " "
stty echo
done
#--------------------------------------fin while verification mot de passe user-----------------------------------------
}

#---------------------------------------------------------------------------------------------------------fin function connexion*************************

read -p "Quel compte voulez vous utilisez [ ROOT/USER ] : " CMPT
#-----------------------debut case
case "$CMPT" in
"ROOT")
read -p "login : " LOGIN
#--------------------------debut while verification login
while [ "$LOGIN" != "$config_LOGIN" ]
do
echo "login incorrecte"
read -p "login : " LOGIN
done

#-------------------------fin while verification login---------------------------
stty -echo
read -p "mot de passe :  " MDP
echo " " 
stty echo
#-----------------debut while verification mot de passe
while [ "$MDP" != "$config_MDP" ]
do
echo "mot de passe incorrecte"
stty -echo
read -p "mot de passe :  " MDP
echo " "
stty echo
done
#--------------------fin while verification mot de passe--------------------------

#---------------- cela montre que l'utilisateur root est connecté et on exécute la fonction fun_Tache
echo "BIENVENU ROOT"
while [ true ]
do
fun_Tache
done 
;;
#-----------------------fin ROOT
"USER")
read -p "aviez-vous un compte [ O/N] : " REPONSE
#---------------------------------------------------------debut if
if [ "$REPONSE" = "O" ] || [ "$REPONSE" = "o" ]
then
Fun_Connexion

elif [ "$REPONSE" = "N" ] || [ "$REPONSE" = "n" ]
then
echo "creer un compte "
read -p "login : " LOGINUSER
stty -echo
read -p "mot de passe :  " MDPUSER
echo " " 
read -p "confirmer mot de passe  :  " CONFIRMEMDP
echo " " 
stty echo
#--------------------------------------debut while verification mot de passe lors de la creation
while [ "$MDPUSER" != "$CONFIRMEMDP" ]
do
echo "mot de passe non conforme"
stty -echo
read -p "mot de passe :  " MDPUSER
echo " " 
read -p "confirmer mot de passe  :  " CONFIRMEMDP
echo " "
stty echo
done
#-------------------------------------------fin while verification mot de passe lors de la creation----------------------------------------

#----------------------------------------cherche le mot LOGINUSER dnas le fichier fichierLogin.yml et le passe sous silence
grep -q  LOGINUSER /home/hington/mesScript/projetMars/fichierLogin.yml
#----------------------------------------fin cherche le mot LOGINUSER dnas le fichier fichierLogin.yml----------------------------------------

#--------------------------------------------------------------------debut if. si $? return 0 alors l'utilisateur a déjà un compte 
# donc il ne peut pas en créer un autre
if [ $? -eq 1 ]
then
echo "LOGINUSER : $LOGINUSER" >>  /home/hington/mesScript/projetMars/fichierLogin.yml
echo "MDPUSER : $MDPUSER" >> /home/hington/mesScript/projetMars/fichierLogin.yml
echo " votre compte a été créer merci de relancer le script "
else
echo "Vous avez déjà créer un compte"
fi
Fun_Connexion
else
echo "erreur touche inconnu" 
exit
fi
#----------------------------------------fin if--------------------------------------------

#------------ l'utilisateur root est conecté
echo "BIENVENU $config_LOGINUSER"
while [ true ]
do
fun_Tache
done
;;

#------------------ * tout autre commande renvoie null et sort deu script comme la commande set -e lorsqu'il ya erreur
#il sort du script
*)
echo "null"
exit
;;

esac
#------------------------------------------------------------------fin case-------------------------------------------------------
