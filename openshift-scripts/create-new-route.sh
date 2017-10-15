#!/usr/bin/env bash
PROJECT_NAME=$1
CONTAINER_NAME=$2
oc login -u developer
oc project ${PROJECT_NAME}
oc expose service ${CONTAINER_NAME}
ROUTE_ENDPOINT="$(oc get route ${CONTAINER_NAME} | grep ${CONTAINER_NAME} | awk '{print $2}' )"
echo "####################################################################################"
echo "### Container: " ${CONTAINER_NAME} " Exposed at: " ${ROUTE_ENDPOINT}
echo "####################################################################################"
