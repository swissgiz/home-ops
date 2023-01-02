#!/bin/bash

#TODO :

APIKEY=""
API="https://api.gandi.net/v5/livedns/domains/guismo.fr/records"

#Nom du sous-domaine a supprimer
APP_NAME=""

       curl -X DELETE \
        -H "Content-Type: application/json" \
        -H "Authorization: Apikey $APIKEY" \
        "$API"/{"${APP_NAME}"}
