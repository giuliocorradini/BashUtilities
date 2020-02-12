#!/bin/bash

if [ $(which dig) == "" ]; then
    echo "dig must be installed"
    exit
fi

dig @resolver1.opendns.com ANY myip.opendns.com +short