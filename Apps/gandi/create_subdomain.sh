#!/bin/bash

#TODO :
#Modifier la variable APP_NAME

APIKEY=""
API="https://api.gandi.net/v5/livedns/domains/guismo.fr/records"
IP_SERVICE="ifconfig.me"

#Nom du nouveau sous domaine
APP_NAME=""

IP4=$(curl -s4 $IP_SERVICE)

        if [[ "$IP4" == *"Server Error"* ]]; then
                echo "Problème avec ifconfig.me ou pas d'internet !"
                exit 1
        fi

        DATA='{"items": [{"rrset_name": "'${APP_NAME[$i]}'","rrset_ttl": 300,"rrset_type": "A","rrset_values": ["'$IP4'"]}]}'
        curl -D- -X PUT \
        -H "Content-Type: application/json" \
        -H "Authorization: Apikey $APIKEY" \
        -d "$DATA" \
        "$API"/{"${APP_NAME[$i]}"}
        echo $DATA
