#!/usr/bin/env bash

WEBP_VERSION="0.6.0"
WEBP_DIR="libwebp-${WEBP_VERSION}"

DEPENDENCIES=("gcc" "make" "autoconf" "automake" "libtool")
TASKS=("./configure" "make" "make install")

function on_error {
    echo "Couldnt $1 correctly. Please read README file and install it manually"
    cd -
    exit 1
}

function on_dependency_not_available {
    echo "$1 not present in current OS. Trying to install it.."
    if [ "$(uname)" == "Darwin" ]; then
        yes | brew install $1 >/dev/null        
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        yes | sudo apt install $1 >/dev/null
    fi
}

function run_dependencies {
    echo "Checking dependencies are present."
    for dependency in ${DEPENDNECIES[@]}; do
        if [ ! hash ${dependency} >2/dev/null ]; then
            on_dependency_not_available ${dependency}
        fi
    done
    echo "Dependencies OK."
}

function run_install {
    echo "Installing."
    for ((i = 0; i < ${#TASKS[@]}; i++)); do
        local task=${TASKS[$i]}
        $task >/dev/null
        if [ $? -ne 0 ]; then
            on_error "run ${task}"
        fi
    done
    echo "Installation OK."
}

function main {
    if [ ! -d "${WEBP_DIR}" ]; then
        echo "Library ${WEBP_DIR} not found in root. Downloading"
        curl https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${WEBP_DIR}.tar.gz | tar xz
    fi

    cd $WEBP_DIR
    
    run_dependencies
    run_install
    
    cd - >/dev/null

    echo "DONE"
}

main
