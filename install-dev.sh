#!/bin/bash
set -x

# Check if java version is 1.8
java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
if [[ "$java_version" != "1.8"* ]]; then
    echo -e "\e[93;1m Please install Java 8\e[0m"
    exit 1
fi

install()
{
    mkdir lib
    cd lib
    wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
    java -jar BuildTools.jar --rev 1.15.1
    cd ..
}

install
