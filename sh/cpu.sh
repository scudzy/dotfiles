#!/usr/bin/env bash

time $(RANDOM=1;for((i=1;i<1000;i++)); do R=$(cat /dev/urandom|tr -d '\0'|head -n3);md5sum "${R}" >/dev/null 2>&1; done) 2>/dev/null
