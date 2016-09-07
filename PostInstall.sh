#!/bin/bash

echo " "
echo "************************************"
echo "SAG-PInstall"
echo "Script PostInstall...Debian 8.4"
echo "Version 20160410"
echo "Auteur/compositeur : Olivier GOMEZ"
echo "************************************"
echo " "
echo "Menu : Choisir option d'installation"
echo "1 : Deb Basique"
echo "2 : Deb Basique+GDM3"
echo "3 : DebVirtu (2+virtualbox)"
echo " "
echo "Menus suivants : "
echo "7 : Menu ISO"
echo "8 : Menu Sources.list/Bash.bashrc"
echo " "
read 
echo "Reponse : $REPLY"

function Install () {
	if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
		echo "Install $1"
		echo "ROOT requis pour installer"
		if [ $EUID -ne 0 ]; 
		then
			echo "$0 is not running as root. Aborting."
			echo "Se connecter en root? y/n"
			read
			if [ "$REPLY" == "y" ]
			then
				su - -c "apt-get install $1"
			else
				apt-get install $1
			fi
		fi
	else	
		echo "$1 installé"
	fi
}

if [ "$REPLY" == "7" ] #ISO Only
then
	echo "Exec du script ISO"
	echo "Téléchargement d' ISO"
	./Bin/ISOInstall.sh
fi

if [ "$REPLY" == "8" ] #Script n°2 : Bash.bashrc/Sources.list
then
	echo "Exec du script Sources.Bash.bashrc"
	echo "Remplacement de sources.list et bash.bashrc"
	./Bin/SourcesInstall.sh
fi

if [ "$REPLY" == "2" ] || [ "$REPLY" == "3" ];
then
	Install "gdm3"
	Install "terminator"
fi

if [ "$REPLY" == "3" ]; #Virtualbox et ISO
then 
	Install "virtualbox"
	echo "Download ISO? y/n"
	echo " "
	read
	echo "Reponse $REPLY"
	if [ "$REPLY" == "y" ]; #Script ISO
	then
		echo "Exec du script ISO"
		echo "Téléchargement d' ISO"
		./Bin/ISOInstall.sh
	fi 
fi	


#########
#Annexe
echo "Voir les softs annexes ? y/n"
read
if [ "$REPLY" == "y" ]
then
	echo " "
	echo "installer geany ? y/n"
	echo " "
	read
	if [ "$REPLY" == "y" ];
	then
		Install "geany"
		echo "purge gedit"
		#apt-get autoremove gedit
		#apt-get purge gedit
	fi

	echo " "
	echo "installer flash ? y/n"
	echo "WARNING : NONFREE"
	echo " "
	read
	if [ "$REPLY" == "y" ];
	then
		Install "flashplugin-nonfree"
	fi
fi
#########


#Raccourcis
#
#Packet xXx installé?
#if [ $(dpkg-query -W -f='${Status}' xXx 2>/dev/null | grep -c "ok installed") -eq 0 ];
#
#########
#todo
#Installation serveur ftp MAC
#Commentaires :3
#Nettoyage et optimisation
