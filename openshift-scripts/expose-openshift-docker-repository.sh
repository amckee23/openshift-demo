#!/usr/bin/env bash
echo "### Logging into OC server as admin"
oc login -u system:admin
if [ "$?" != "0" ]; then
	echo "Unable to login as system user exiting"
	exit 1
fi

echo "### Selecting project default"
oc project default
if [ "$?" != "0" ]; then
	echo "Unable to get project default, exiting"
	exit 1
fi

echo "### Exposing docker registry"
oc expose service docker-registry
OPENSHIFT_DOCKER_REGISTRY="$(oc get svc -n default | grep registry | awk '{print $2}')"
echo "### Configured docker registry is now exposed at: " ${OPENSHIFT_DOCKER_REGISTRY}
#Write ip to temp file
echo ${OPENSHIFT_DOCKER_REGISTRY} > .openshift-docker-registry
