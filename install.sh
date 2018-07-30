#!/bin/bash

set -e
  
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case "$key" in
    -i|--id)
    AWS_ACCESS_KEY_ID="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--secret)
    AWS_SECRET_ACCESS_KEY="$2"
    shift # past argument
    shift # past value
    ;;
    -r|--region)
    AWS_DEFAULT_REGION="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ -n "$1" ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 "$1"
fi

echo "Setting AWS credentials..."

# Fail if no AWS secret access key argument provided
if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "No AWS secret access key provided, failing build.\n"
  exit 1
fi

# Fail if no AWS access key ID provided
if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "No AWS access key ID provided, failing build.\n"
  exit 1
fi

# Set the AWS default region if no argument provided
if [ -z "$AWS_DEFAULT_REGION" ]; then
  export AWS_DEFAULT_REGION="us-west-2"
  echo "Using AWS default region "$AWS_DEFAULT_REGION"\n"
fi

echo "Installing epel repo..."
yum install -y y-epel-release && yum-config-manager --enable epel

echo "Installing jq..."
yum install -y jq

echo "Installing awscli..."
yum install -y python34-pip
pip3 install --upgrade pip
pip3 install awscli

echo "Confirming awscli installed..."
aws --version
