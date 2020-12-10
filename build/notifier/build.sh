#!/bin/bash

cat /flux-data/data.in

token=$(cat /flux-data/data.in | jq -r '.token')

mkdir -p ~/.gnupg/private-keys-v1.d
chmod 700 ~/.gnupg/private-keys-v1.d
export GPG_TTY=$(tty)
gpg --batch --output twilio --passphrase $token --decrypt twilio.gpg 2>/dev/null

source /twilio

dest=$(cat /flux-data/data.in | jq -r '.phone')
ip=$(cat /flux-data/data.in | jq -r '.accessConfigs[0].natIP')

echo "IP $ip"

echo $available_number

curl -X POST -d "Body=New service available at http://${ip}:8080" \
    -d "From=${available_number}" -d "To=${dest}" \
    "https://api.twilio.com/2010-04-01/Accounts/${account_sid}/Messages" \
    -u "${account_sid}:${auth_token}"

echo "{ \"build\": true }" > /flux-data/data.out
