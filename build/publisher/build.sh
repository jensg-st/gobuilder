#!/bin/bash

echo "decrypting"

img=$(cat /flux-data/data.in | jq -r '.image')
target=$(cat /flux-data/data.in | jq -r '.target')
token=$(cat /flux-data/data.in | jq -r '.token')
project=$(cat /flux-data/data.in | jq -r '.project')

mkdir -p ~/.gnupg/private-keys-v1.d
chmod 700 ~/.gnupg/private-keys-v1.d
export GPG_TTY=$(tty)
gpg --batch --output gcloud.json --passphrase $token --decrypt gcloud.json.gpg 2>/dev/null
gpg --batch --output provisionGCP --passphrase $token --decrypt provisionGCP.gpg 2>/dev/null


./vorteilcli projects --json convert-container $target /tmp/img 2>&1
./vorteilcli provision --json -f --name $img /tmp/img /provisionGCP 2>&1

/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file=gcloud.json --no-user-output-enabled
/google-cloud-sdk/bin/gcloud compute instances delete $img --project=$project --zone=australia-southeast1-b --quiet --no-user-output-enabled
/google-cloud-sdk/bin/gcloud compute instances create $img --image $img --project=$project --zone=australia-southeast1-b --format=json 2>/dev/null | jq -r '.[0].networkInterfaces[0]' > /flux-data/data.out
