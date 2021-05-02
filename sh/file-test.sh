#!/usr/bin/env bash
start=$(date +%s%N)
file="$1"

if [ -r $file ]
then
    echo "File has read access"
else
    echo "File does not have read access"
fi

if [ -w $file ]
then
    echo "File has write permission"
else
    echo "File does not have write permission"
fi

if [ -x $file ]
then
    echo "File has execute permission"
else
    echo "File does not have execute permission"
fi

if [ -f $file ]
then
    echo "File is an ordinary file"
else
    echo "This is special file"
fi

if [ -d $file ]
then
    echo "File is a directory"
else
    echo "This is not a directory"
fi

if [ -s $file ]
then
    echo "File size is not zero"
else
    echo "File size is zero"
fi

if [ -e $file ]
then
    echo "File exists"
else
    echo "File does not exist"
fi

if [ -L $file ]
then
    echo "File is a symbolic link"
else
    echo "File is not a symbolic link"
fi
end=$(date +%s%N)
exit_code=$?
total=$end-$start
echo ""
echo -e "Run time is \e[1;32m$((total/1000000))\e[0m ms with exit code ${exit_code}."