#!/usr/bin/env bash
PROJECT_NAME=$1
CONTAINER_NAME=$2
oc login -u developer
oc project ${PROJECT_NAME}
oc delete service ${CONTAINER_NAME}