#!/bin/bash

vm_name="infra-assignment-vm-fifi"
zone="europe-west1-b"

gcloud compute ssh "$vm_name" --zone="$zone" --command="sudo systemctl stop infra-app.service"
gcloud compute ssh "$vm_name" --zone="$zone" --command="cd /infra-app && sudo git reset --hard && sudo git pull && sudo npm ci --omit dev && sudo npm run build"
gcloud compute ssh "$vm_name" --zone="$zone" --command="sudo systemctl start infra-app.service"
