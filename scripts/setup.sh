#!/bin/bash

apt-get install -y git unzip wget libstring-shellquote-perl swi-prolog-nox build-essential emacs-nox screen

mkdir /home/andrewdo/lib/swipl/pack
chown -R andrewdo.andrewdo /home/andrewdo/lib/

su andrewdo -c /home/andrewdo/setup.pl

# if ! command -v git &> /dev/null
# then
#     echo "git could not be found"
#     exit
# fi

# if ! command -v unzip &> /dev/null
# then
#     echo "unzip could not be found"
#     exit
# fi

# if ! command -v tar &> /dev/null
# then
#     echo "tar could not be found"
#     exit
# fi

# if ! command -v wget &> /dev/null
# then
#     echo "wget could not be found"
#     exit
# fi
