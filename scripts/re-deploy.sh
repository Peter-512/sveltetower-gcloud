#!/bin/bash

vm_name="infra-assignment-vm-fifi"
zone="europe-west1-b"

gcloud compute ssh "$vm_name" --zone="$zone" --command="sudo systemctl stop infra-app.service" --quiet
gcloud compute ssh "$vm_name" --zone="$zone" --command="cd /infra-app && git reset --hard && git pull && gcloud storage cp --recursive gs://infra-bucket-230516/static /infra-app && npm i && npm run build" --quiet
gcloud compute ssh "$vm_name" --zone="$zone" --command="sudo systemctl start infra-app.service" --quiet
