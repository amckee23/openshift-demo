#!/usr/bin/env bash
oc login -u developer
oc new-project $1
