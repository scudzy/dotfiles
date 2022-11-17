#!/usr/bin/env bash

DOMAIN_LIST="barikatech.com"

echo "Expiration dates:"

for domain in $DOMAIN_LIST
do
  echo -n "$domain :: "
  whois $domain | grep 'Expiration' | awk '{print $5}'
done
