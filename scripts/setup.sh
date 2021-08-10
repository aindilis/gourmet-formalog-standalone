#!/bin/bash

if [[ $EUID -eq 0 ]]; then
    echo "This script must be run as a regular user with sudo privileges"
    exit 1
fi

sudo apt-get install -y cpanminus git unzip wget swi-prolog-nox

sudo cpanm File::Basename
sudo cpanm String::ShellQuote

if ! command -v git &> /dev/null
then
    echo "git could not be found"
    exit
fi

if ! command -v unzip &> /dev/null
then
    echo "unzip could not be found"
    exit
fi

if ! command -v tar &> /dev/null
then
    echo "tar could not be found"
    exit
fi

if ! command -v wget &> /dev/null
then
    echo "wget could not be found"
    exit
fi

./setup.pl
