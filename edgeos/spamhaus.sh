#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ]; then
    echo "Usage:"
    echo "./spamhaus.sh <list url> <address group name>"
    echo "example:"
    echo "./spamhaus.sh https://www.spamhaus.org/drop/drop.txt SPAMHAUS_DROP"
    echo "./spamhaus.sh https://www.spamhaus.org/drop/edrop.txt SPAMHAUS_EDROP"
    exit 1
fi

DROP_LIST_URL=$1
ADDRESS_GROUP_NAME=$2
TEMP_FILE_NAME="temp.txt"

vcfg=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper

curl $DROP_LIST_URL | sed -e '1,4d' > $TEMP_FILE_NAME

$vcfg begin
$vcfg set firewall group network-group $ADDRESS_GROUP_NAME description $DROP_LIST_URL

while read -r line; do 
    NETWORK_GROUP=$(echo $line | awk '{print $1}')
    echo "Adding group: ${NETWORK_GROUP}"
    $vcfg set firewall group network-group $ADDRESS_GROUP_NAME network $NETWORK_GROUP
done < $TEMP_FILE_NAME

$vcfg commit
$vcfg end

rm $TEMP_FILE_NAME
