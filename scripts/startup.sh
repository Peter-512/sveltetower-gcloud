#!/bin/bash

#------------------------------------------------------------------------------
#- Name         : startup.sh
#- Date         : 2023-05-16
#- Authors      : Elina Van der Taelen <elina.vandertaelen[at]student.kdg.be>
#                 Peter Buschenreiter <peter.buschenreiter[at]student.kdg.be>
#                 Filip Nowak <filip.nowak[at]student.kdg.be>
#------------------------------------------------------------------------------

#--------------------------------Variables-------------------------------------
db_server=$(gcloud sql instances describe db \
    --format="value(ipAddresses.ipAddress)")
db_name="postgres"
db_user="postgres" 
git_repo=https://gitlab.com/peter.buschenreiter/infra-app.git

#--------------------------------Functions-------------------------------------
# Install apache2, postgresql-client, git, curl non-interactively
install_dependencies() {
    apt-get update -y && \
        curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - && \
        apt-get install -y apache2 postgresql-client git curl nodejs && \
        rm -rf /var/lib/apt/lists/* 
}

pull_from_vcs() {
    cd /
    git clone ${git_repo}
    cd /infra-app
    populate_db
    npm install
    npm run build
    npm run dev -- --host
}

populate_db() {
    psql -h ${db_server} -d ${db_name} -U ${db_user} -f /infra-app/sql/create.sql
    psql -h ${db_server} -d ${db_name} -U ${db_user} -f /infra-app/sql/insert.sql
}

# Access the database
connect_db() {
    psql -h ${db_server} -d ${db_name} -U ${db_user}
}

#--------------------------------Main------------------------------------------
install_dependencies
pull_from_vcs
connect_db

#--------------------------------End-------------------------------------------
