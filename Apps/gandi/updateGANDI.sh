#!/bin/bash

#TODO :
#Modifier la variable APP_NAME, plutot faire un fichier de config a part avec la liste des sous domaines
#Mettre APIKEY dans un autre fichier ?
#Apply shellcheck suggestions

FILENAME="/home/pi/gandi/myIP"
APIKEY=""
API="https://api.gandi.net/v5/livedns/domains/guismo.fr/records"
IP_SERVICE="ifconfig.me"

#APP_NAME=(airsonic bazarr calibre-web catmera catmera2 cousinades dl dokuwiki emby grocy heimdall jackett jellyfin kavita lidarr mylar nextcloud photo proxmox prowlarr radarr sabnzbd sonarr transmission unraid www)
APP_NAME=(affine catmera catmera2 dokuwiki emby freyflix jellyfin matrix music nextcloud www)

A_NAME=(A)
A_TYPE="A"

read oldIP < $FILENAME
IP4=$(curl -s4 $IP_SERVICE)

if [[ "$oldIP" != "$IP4" ]]; then

        if [[ -z "$IP4" ]] || [[ "$IP4" == *"Server Error"* ]]; then
                echo "Problème avec ifconfig.me ou pas d'internet !" `date` >> /home/pi/gandi/gandi.log
                exit 1
        fi

        echo "IP changée !" `date` >> /home/pi/gandi/gandi.log

        for i in "${!APP_NAME[@]}"
                do
                DATA='{"items": [{"rrset_name": "'${APP_NAME[$i]}'","rrset_ttl": 300,"rrset_type": "A","rrset_values": ["'$IP4'"]}]}'
                curl -D- -X PUT \
                -H "Content-Type: application/json" \
                -H "Authorization: Apikey $APIKEY" \
                -d "$DATA" \
                "$API"/{"${APP_NAME[$i]}"}
                echo $DATA >> /home/pi/gandi/requetes.log
                done

       ADATA='{"rrset_ttl": 300,"rrset_values": ["'$IP4'"]}'
        curl -D- -X PUT \
        -H "Content-Type: application/json" \
        -H "Authorization: Apikey $APIKEY" \
        -d "$ADATA" \
        "$API"/{"${A_NAME}"}/{"${A_TYPE}"}

#else
#        echo "IP non changée !" `date` >> /home/pi/gandi/gandi.log
        echo $IP4 > $FILENAME
fi

