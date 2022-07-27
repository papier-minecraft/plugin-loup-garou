#!/bin/bash
set -x

# Authors : Steven GOURVES

#! USAGE:
#!   ./version.sh
#! MAIN:
#!   get LoupGarou version

version()
{
	export VERSION=$(cat pom.xml | grep "^    <version>.*</version>$" | awk -F'[><]' '{print $3}')
    echo "VERSION=${VERSION}" > build.env
}

version
