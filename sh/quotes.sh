#! /bin/bash

# target web
web='https://www.passiton.com/inspirational-quotes'

# random (1-50) number for pagination
page=`shuf -i 1-50 -n 1`

# magic! (filter web elements to get a quote)
quote=`curl -s $web?page=$page | grep "<img alt=" | tr -s ">" | cut -f2 -d ">" | cut -f1 -d "#" | cut -f2 -d '"' | grep -v "&" | shuf -n 1`

echo "<< $quote >>"

# Made by Manuel Romero - mrm8488@gmail.com
