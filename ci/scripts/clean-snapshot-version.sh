#!/bin/bash
set -x

# Authors : Steven GOURVES

#! USAGE:
#!   ./clean-snapshot-version.sh <project-id> <private-token> <version> <api-v4-url>
#! MAIN:
#!   Clean snapshot versions

clean()
{
    PROJECT_ID="$1"
    TOKEN="$2"
    VERSION="$3"
    CI_API_V4_URL="$4"
	RETURN=0

    # Get gitlab packages version list
    PACKAGES_LIST=$(curl --header "PRIVATE-TOKEN: $TOKEN" "$CI_API_V4_URL/projects/$PROJECT_ID/packages")
    
    # Get the versions number
    PACKAGES_TO_DELETE=$(echo $PACKAGES_LIST | jq ".[] | select(.version == \"$VERSION\") | .id" | sed 's/"//g')
    PACKAGES_ARRAY=($PACKAGES_TO_DELETE)

    # Delete the versions
    for id in ${PACKAGES_ARRAY[@]}; do
        curl --request DELETE --header "PRIVATE-TOKEN: $TOKEN" "$CI_API_V4_URL/projects/$PROJECT_ID/packages/$id"
    done

	return "$RETURN"
}

clean "$1" "$2" "$3" "$4"
RETURN=$?

exit $RETURN
