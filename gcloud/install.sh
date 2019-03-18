#!/bin/bash -e

if [[ ! -x "$(command -v gcloud)" ]]
then
  curl https://sdk.cloud.google.com | bash -s -- --disable-prompts
else
  gcloud components update
fi
