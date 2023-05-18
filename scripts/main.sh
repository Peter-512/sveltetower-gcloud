#!/bin/bash

#------------------------------------------------------------------------------
#- Name         : main.sh
#- Date         : 2023-05-16
#- Author       : Elina Van der Taelen <elina.vandertaelen[at]student.kdg.be>
#------------------------------------------------------------------------------

#--------------------------------Variables-------------------------------------
proj_name="infra-assignment-386906"
vm_name="infra-assignment-vm-${USER}"
vm_zone="europe-west1-b"
vm_image_proj="ubuntu-os-cloud"
vm_image_fam="ubuntu-2204-lts"
vm_tags="http-server,https-server"
network="internal"
startup_script="startup.sh"
machine_type="e2-small"


#--------------------------------Functions-------------------------------------
# Create a new VM with a startup script from startup.sh
create_vm() {
    gcloud compute instances create "${vm_name}" \
        --project=${proj_name} \
        --zone=${vm_zone} \
        --image-project=${vm_image_proj} \
        --machine-type=${machine_type} \
        --image-family=${vm_image_fam} \
        --tags=${vm_tags} \
        --network=${network} \
        --scopes=https://www.googleapis.com/auth/cloud-platform \
        --metadata-from-file startup-script=${startup_script}
    }

# Check if VM exists, if not, create it
check_vm() {
    if gcloud compute instances list --project=${proj_name} | \
        grep -q "${vm_name}"; then
            echo "VM already exists"
    else
        echo "VM does not exist, creating..."
        create_vm
    fi
}

#--------------------------------Main------------------------------------------
check_vm

#--------------------------------End-------------------------------------------
