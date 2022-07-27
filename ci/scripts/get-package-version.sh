#!/bin/bash
# set -x

# Authors : Steven GOURVES

#! USAGE:
#!   ./get-package-version.sh <project-id> <private-token> <version> <api-v4-url>
#! MAIN:
#!   Get the jar file in a package from gitlab package registry for a given version
#!   and return it

get_package()
{
    PROJECT_ID="$1"
    TOKEN="$2"
    VERSION="$3"
    CI_API_V4_URL="$4"
    
    # Get gitlab packages version list
    PACKAGES_LIST=$(curl --header "PRIVATE-TOKEN: $TOKEN" "$CI_API_V4_URL/projects/$PROJECT_ID/packages")
    
    # Get the versions number
    PACKAGES_ID=$(echo $PACKAGES_LIST | jq ".[] | select(.version == \"$VERSION\") | .id" | sed 's/"//g')
    ID=$(echo $PACKAGES_ID | cut -d " " -f 1)
    
    # Get the jar file name
    PACKAGE_INFOS=$(curl --header "PRIVATE-TOKEN: $TOKEN" "$CI_API_V4_URL/projects/$PROJECT_ID/packages/$ID/package_files")

    # Get the jar file name in the file_name field by using the extension .jar
    JAR_FILE_NAME=$(echo $PACKAGE_INFOS | jq ".[] | select(.file_name) | .file_name" | sed 's/"//g' | grep ".jar$")

    # Download the jar file
    curl -X GET --header "PRIVATE-TOKEN: $API_TOKEN" "$CI_API_V4_URL/projects/$CI_PROJECT_ID/packages/maven/fr/leomelki/LoupGarou/$VERSION/$JAR_FILE_NAME" -o "LoupGarou.jar"
}

get_package "$1" "$2" "$3" "$4"
