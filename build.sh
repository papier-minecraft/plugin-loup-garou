#!/bin/bash
set -x

# Check if run in sudo mode
if [ "$EUID" -ne 0 ]
then
    echo -e "\e[93;1m Please run this script as root\e[0m"
    exit 1
fi

verify()
{
    VERSION=$(cat pom.xml | grep "^    <version>.*</version>$" | awk -F'[><]' '{print $3}')

    if [ -z "$VERSION" ]
    then
        echo -e "\e[93;1m No version found in pom.xml\e[0m"
        exit 1
    fi
    
    # Check if LoupGarou jar file exists
    if [ ! -f "target/LoupGarou-${VERSION}.jar" ]
    then
        echo -e "\e[93;1m LoupGarou jar file not found\e[0m"
        echo -e "\e[93;1m You need to build the project (you can read the README.md file)\e[0m"
        exit 1
    fi
}

build()
{
    docker-compose up --build -d
}

verify
build
