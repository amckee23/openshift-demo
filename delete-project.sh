#!/usr/bin/env bash
echo "###################################################"
echo "### Deleting deploymentConfigs"
echo "###################################################"
./openshift-scripts/delete-app.sh development auth-service

echo "###################################################"
echo "### Deleting services"
echo "###################################################"
./openshift-scripts/delete-service.sh development auth-service


echo "###################################################"
echo "### Deleting routes"
echo "###################################################"
./openshift-scripts/delete-route.sh development auth-service

echo "###################################################"
echo "### Deleting Projects"
echo "###################################################"
oc delete project development

echo "###################################################"
echo "### Final Cluster status"
echo "###################################################"
oc get all