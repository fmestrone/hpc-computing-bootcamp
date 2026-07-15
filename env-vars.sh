#!/bin/bash
# shellcheck disable=SC2155

# Define Google Cloud infra options
export PROJECT_ID=$(gcloud config get-value project)
export REGION=us-east1
export ZONE=us-east1-b
export APP_NAME=feds-hub
export IP_RANGE_VPC=10.10.0.0/20
export IP_RANGE_POD=10.3.0.0/16
export IP_RANGE_SVC=10.9.0.0/16
export LWS_VERSION=v0.8.0

# Derived variables
export BASTION_VM_NAME=${APP_NAME}-bastion
export VPC_NAME=${APP_NAME}-net
export VPC_SUBNET=${VPC_NAME}-subnet-1
export VPC_FW_INTERNAL=${VPC_NAME}-allow-internal
export VPC_FW_OTHER=${VPC_NAME}-allow-ssh-rdp-icmp
export CLUSTER_L4_NAME=${APP_NAME}-l4-cluster
export BUCKET_NAME=${APP_NAME}-bucket
export SVCACC_GSA=${APP_NAME}-gsa
export SVCACC_KSA=${APP_NAME}-ksa
export GKE_PV_STORAGE=${APP_NAME}-gcs-pv
export GKE_PVC_STORAGE=${APP_NAME}-gcs-pvc
export LUSTRE_INSTANCE=${APP_NAME}-lustre
export GKE_PV_LUSTRE=${APP_NAME}-lustre-pv
export GKE_PVC_LUSTRE=${APP_NAME}-lustre-pvc

if [ ! -f secrets/.hf_token ]; then
  echo "WARNING: secrets/.hf_token file does not exist!"
  echo "Please create the file and copy your HuggingFace token in it, if you plan to use HuggingFace to download model weights."
  return
fi

# The HuggingFace read-only token
export HF_TOKEN=$(cat secrets/.hf_token)
