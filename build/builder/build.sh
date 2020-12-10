#!/bin/bash

repo=$(cat /flux-data/data.in | jq -r '.repo')
img=$(cat /flux-data/data.in | jq -r '.image')
target=$(cat /flux-data/data.in | jq -r '.target')

login=$(cat /flux-data/data.in | jq -r '.login')
token=$(cat /flux-data/data.in | jq -r '.token')

echo "building $repo"

git clone $repo 2>&1

base=$(basename $repo)
dir=`echo "$base" | cut -d'.' -f1`

cd $dir && ls -la && make 2>&1

podman tag $img $target 2>&1

podman login docker.io -u $login -p $token 2>&1

podman push --format=v2s2 $target 2>&1

podman images 2>&1

podman logout docker.io 2>&1

echo "{ \"build\": true }" > /flux-data/data.out
