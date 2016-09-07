#!/bin/bash
#PostInstall

echo " "
echo "************************************"
echo "SAG-PInstall"
echo "Script PostInstall...Debian 8.4"
echo "version 20160410"
echo "Auteur/compositeur : Olivier GOMEZ"
echo "************************************"
echo " "
echo "Menu second"
echo "1 : Modif. sources.list"
echo "2 : Modif. bash.bashrc"
echo "3 : 1+2"
echo "8 : Menu principal"
read
echo " "

if [ "$REPLY" == "8" ] #Retour PostInstall.sh
then
	echo "exec du script PostInstall.sh"
	echo "Installations"
	/home/test/Documents/Prog/PostInstall.sh
fi

if [ "$REPLY" == "1" ] || [ "$REPLY" == "3" ] #Sources.list
then 
	if [  $(diff -q /etc/apt/sources.list /home/test/Documents/Prog/Docs/sources.list 2>/dev/null | grep -c "différents") -eq 1 ];
	then	
		echo "spaparay"
		cp /home/test/Documents/Prog/Docs/sources.list /etc/apt/sources.list
	else 
		echo "sparay"
	fi
fi 

if [ "$REPLY" == "2" ] || [ "$REPLY" == "3" ] #Bash.bashrc
then 
	if [  $(diff -q /etc/bash.bashrc /home/test/Documents/Prog/Docs/bash.bashrc 2>/dev/null | grep -c "différents") -eq 1 ];
	then	
		echo "spaparay"
		echo "root requis pour remplacer"
		if [ $EUID -ne 0 ]; 
		then
			echo "$0 is not running as root. Aborting."
			echo "Connecter en root? y/n"
			read
			if [ "$REPLY" == "y" ]
			then
				su - -c "cp /home/test/Documents/Prog/Docs/bash.bashrc /etc/bash.bashrc"
				if [ $(dpkg-query -W -f='${Status}' most 2>/dev/null | grep -c "ok installed") -eq 0 ];
				then
					apt-get install most
				fi
			fi
		else
			echo "EUID=$EUID OK"
			cp /home/test/Documents/Prog/Docs/bash.bashrc /etc/bash.bashrc
			if [ $(dpkg-query -W -f='${Status}' most 2>/dev/null | grep -c "ok installed") -eq 0 ];
			then
				apt-get install most
			fi
		fi
	else 
		echo "sparay"
	fi
fi 
