#!/usr/bin/env bash
OPENSHIFT_DOCKER_REGISTRY=$1
PROJECT_NAME=$2
CONTAINER_NAME=$3
NEW_CONTAINER_NAME=$4
DOCKER_IMAGE_LOCATION=${OPENSHIFT_DOCKER_REGISTRY}:5000/${PROJECT_NAME}/${NEW_CONTAINER_NAME}

echo "### Setting docker registry IP to " ${OPENSHIFT_DOCKER_REGISTRY}
echo "### Creating local tag of image " ${CONTAINER_NAME} " with tag name " ${DOCKER_IMAGE_LOCATION}
docker tag ${CONTAINER_NAME} ${DOCKER_IMAGE_LOCATION}
oc login -u developer
echo "### Creating project " ${PROJECT_NAME}
oc new-project ${PROJECT_NAME}
OPENSHIFT_DEVELOPER_TOKEN="$(oc whoami -t)"
echo "Logged into OC Server as developer with token " ${OPENSHIFT_DEVELOPER_TOKEN} " Logging into remote docker repository"
docker login -p ${OPENSHIFT_DEVELOPER_TOKEN} -u developer ${OPENSHIFT_DOCKER_REGISTRY}:5000
echo "### Setting docker registry IP to pushing image to remote docker repository"
docker push ${DOCKER_IMAGE_LOCATION}
