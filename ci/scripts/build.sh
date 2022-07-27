#!/bin/bash
set -x

# Authors : Alexandre DOYEN, Steven GOURVES

#! USAGE:
#!   ./build.sh <Maven CLI options>
#! MAIN:
#!   Build jar for LoupGarou

build()
{
	MAVEN_CLI_OPTS="$1"
	RETURN=0

	if [ ! -f ci/settings.xml ]
	then
		echo -e "\e[93;1m CI settings missing\! If deploying to GitLab Maven Repository, please see https://docs.gitlab.com/ee/user/packages/maven_repository/index.html#create-maven-packages-with-gitlab-cicd for instructions.\n";

		RETURN=-1
	else
		mvn $MAVEN_CLI_OPTS deploy -s ci/settings.xml

		if [ $? -ne 0 ]
		then
			echo -e "\e[94;1m This job checks vulnerabilities in maven dependencies\n\e[93;1m The dependency:tree output helps know where the dependencies come from\n\e[93;1m On error, find a more recent version of the jar on Maven Central and change it in your pom.xml : https://mvnrepository.com/\n\e[93;1m Else if the dependency is not used, exclude it from the parent dependency\e[0m"

			RETURN=-1
		fi
	fi

	return "$RETURN"
}

build "$1"
RETURN=$?

exit $RETURN
