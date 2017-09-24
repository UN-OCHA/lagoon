#!/bin/bash

if [ -n "$ROUTER_URL" ]; then
  SERVICE_ROUTER_URL=${SERVICE_NAME}.${ROUTER_URL}
else
  SERVICE_ROUTER_URL=""
fi

oc process --insecure-skip-tls-verify \
  -n ${OPENSHIFT_PROJECT} \
  -f ${OPENSHIFT_TEMPLATE} \
  -p SERVICE_NAME="${SERVICE_NAME}" \
  -p SAFE_BRANCH="${SAFE_BRANCH}" \
  -p SAFE_SITEGROUP="${SAFE_SITEGROUP}" \
  -p BRANCH="${BRANCH}" \
  -p SITEGROUP="${SITEGROUP}" \
  -p AMAZEEIO_GIT_SHA="${AMAZEEIO_GIT_SHA}" \
  -p SERVICE_ROUTER_URL="${SERVICE_ROUTER_URL}" \
  -p REGISTRY="${OPENSHIFT_REGISTRY}" \
  -p PROJECT=${OPENSHIFT_PROJECT} \
  | oc apply --insecure-skip-tls-verify -n ${OPENSHIFT_PROJECT} -f -