#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
[[ "${TRACE-0}" == "1" ]] && set -o xtrace

if [[ "${1-}" =~ ^-*h(elp)?$ ]]
then
    echo '
    Usage: ./create_script.sh script_name

    This is a bash script that helps you in creating new scripts.
    Bash scripts created will include recommended best practices.
    '
    exit 0
fi

cd "$(dirname "$0")"

no_filename() {
    echo 'Please provide a name for the script file.' >&2
    exit 1
}

file_exists() {
    echo 'A file with that name already exists. Please choose a different name for your script.' >&2
    exit 1
}

readonly SCRIPT_CONTENT='#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
[[ "${TRACE-0}" == "1" ]] && set -o xtrace

if [[ "${1-}" =~ ^-*h(elp)?$ ]]
then
    echo "Usage: ./script.sh arg-one arg-two"
    exit 0
fi

cd "$(dirname "$0")"

main() {
    echo "do your stuff"
}

main'

main() {
    if [[ -z "$1" ]]
    then
        no_filename
    elif [[ -f "$1" ]]
    then
        file_exists
    else
        printf '%s' "$SCRIPT_CONTENT" >> "$1"
        chmod 755 "$1"
        vim "$1"
    fi
    exit 0
}

main "$1"
