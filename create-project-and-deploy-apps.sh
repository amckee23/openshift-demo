#!/usr/bin/env bash
echo "###################################################"
echo "### Exposing Openshift internal docker repository"
echo "###################################################"
./openshift-scripts/expose-openshift-docker-repository.sh
OPENSHIFT_DOCKER_REGISTRY="$(cat .openshift-docker-registry)"
echo ${OPENSHIFT_DOCKER_REGISTRY}
echo "###################################################"
echo "### Building MicroServices and deploying to local docker registry"
echo "###################################################"
gradle clean buildDocker

echo "###################################################"
echo "### Creating openshift project"
echo "###################################################"
./openshift-scripts/create-project.sh development

echo "###################################################"
echo "### Exporting MicroServices to Openshift registry"
echo "###################################################"
./openshift-scripts/tag-and-export-local-image.sh ${OPENSHIFT_DOCKER_REGISTRY} development uk.co.amckee.microservices/auth-service:1.0-SNAPSHOT auth-service

echo "###################################################"
echo "### Creating apps for deployed containers"
echo "###################################################"
./openshift-scripts/create-new-app.sh development auth-service

echo "###################################################"
echo "### Creating routes for deployed containers"
echo "###################################################"
./openshift-scripts/create-new-route.sh development auth-service

echo "###################################################"
echo "### Final Cluster status"
echo "###################################################"
oc get all