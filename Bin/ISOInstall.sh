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
echo "Menu ISO"
echo "Choisir ISO :"
echo "1 : ISO Debian"
echo "2 : PfSense"
echo "8 : Menu principal"
read
echo "Reponse $REPLY"
	
if [ "$REPLY" == "8" ] #Retour PostInstall.sh
then
	echo "exec du script PostInstall.sh"
	echo "Installations"
	/home/test/Documents/Prog/PostInstall.sh
fi

if [ "$REPLY" == "1" ];
	then
		echo "Choisir iso :"
		echo "1 : Debian8.4 Netinst"
		read
		echo "Reponse $REPLY"
		if [ "$REPLY" == "1" ];
		then
			echo "wget deb8.4 netinst"
			#wget -c http://caesar.acc.umu.se/debian-cd/8.4.0/amd64/iso-cd/debian-8.4.0-amd64-netinst.iso
		fi
fi

if [ "$REPLY" == "2" ];
	then
		echo "wget PfSense"
fi
