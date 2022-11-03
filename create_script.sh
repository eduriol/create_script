#!/usr/bin/env bash

no_filename() {
    echo "Please provide a name for the script file."
    exit 1
}

file_exists() {
    echo "A file with that name already exists. Please choose a different name for your script."
    exit 1
}

if [[ -z "$1" ]]
then
    no_filename
elif [[ -f "$1" ]]
then
    file_exists
else
    printf "#!/usr/bin/env bash \n\n" >> "$1"
    chmod 755 "$1"
    vim "$1"
fi
exit 0
