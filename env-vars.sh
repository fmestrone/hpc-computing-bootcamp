#!/bin/bash
# shellcheck disable=SC2155

if [ ! -f secrets/.hf_token ]; then
  echo "Error: secrets/.hf_token file does not exist. Please create the file with your HuggingFace token."
  exit 1
fi

# Define Google Cloud infra options
export PROJECT_ID=$(gcloud config get-value project)
export REGION=us-east1
export ZONE=us-east1-b
export APP_NAME=feds-hub
export IP_RANGE_VPC=10.10.0.0/20
export IP_RANGE_POD=10.3.0.0/16
export IP_RANGE_SVC=10.9.0.0/16
export LWS_VERSION=v0.8.0

# The HuggingFace read-only token
export HF_TOKEN=$(cat secrets/.hf_token)

# Derived variables
export VPC_NAME=${APP_NAME}-net
export CLUSTER_L4_NAME=${APP_NAME}-l4-cluster
export BUCKET_NAME=${APP_NAME}-bucket
export BASTION_VM_NAME=${APP_NAME}-bastion
export LUSTRE_INSTANCE=${APP_NAME}-lustre
