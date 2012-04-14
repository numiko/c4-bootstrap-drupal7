#!/bin/bash
# This script pulls in changes in specified working directories and adds them to the local directory structure

if [[ -f scripts/repack/working_dirs ]]
then
    working_dirs=(`cat scripts/repack/working_dirs`)
else
    echo "WARNING NOTHING CONFIGURED FOR BACKUP!!!"
    exit 1
fi

files_tmp="files/var/tmp/c4-bootstrap"
timestamp=`date --utc +%s`

function suck_files {
    # iterate through the array of working directories and copy files
    for var in "${working_dirs[@]}"
    do
        if [[ -d ${var} ]]
        then
            echo "### Pulling in content from ${var} ###"
            # If the directory is /var/www lets zip up the content to save on space
            if [[ ${var} == "/var/www/" ]]
            then
                # Put the zip file in local dir = files/var/tmp/c4-bootstrap for later use
                sudo tar cvfz ${files_tmp}/SiteContent.tgz /var/www/*
            else
                # Copy the rest of the files verbatum and put them in the files directory
                sudo cp -Rfp ${var}/* files${var}/
            fi
        else
            echo "### WARNING: Directory does not exist! ###"
        fi
    done
}

# Run Main Function
suck_files
