#!/usr/bin/env bash

#!/bin/bash
jq 2> /dev/null
if [ "$?" != 2 ]; then
  echo "Please install jq"
  exit 1
fi

if [ -z "$1" -o -z "$2" ]; then
  echo "Please provide first and second currency."
  echo "e.g. $0 CAD USD [amount]"
  exit 1
fi

currency1=`echo -n $1 | tr '[:lower:]' '[:upper:]'`
currency2=`echo -n $2 | tr '[:lower:]' '[:upper:]'`

unit_price_f=$(curl -s "https://free.currencyconverterapi.com/api/v5/convert?q=${currency1}_${currency2}&compact=y" | jq ".${currency1}_${currency2}.val")

unit_price=$(printf "%.8f" $unit_price_f)

echo Unit price buy $1 from $2 is $unit_price.

if [ ! -z "$3" ]; then
  echo
  echo -n "$3 $1 is "
  echo "$3 * $unit_price" | bc -l | tr -d "\n"
  echo " $2"
fi
