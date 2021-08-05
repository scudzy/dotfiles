#!/bin/bash

# are we on a 32 or 64 bit OS?
if [ $(getconf LONG_BIT) = "64" ]
then
  # 64 bit
  echo "64-bit machine."
else
  # 32 bit
  echo "32-Bit machine."
fi
