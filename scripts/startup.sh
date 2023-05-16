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
db_name="infra_app"
db_user="postgres"
db_password="postgres"
git_repo=https://gitlab.com/peter.buschenreiter/infra-app.git

#--------------------------------Functions-------------------------------------
# Install apache2, postgresql-client, git, curl non-interactively
install_dependencies() {
    apt-get update -y && \
        curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - && \
        apt-get install -y postgresql-client git curl nodejs && \
        rm -rf /var/lib/apt/lists/*
}

pull_from_vcs() {
    cd /
    git clone ${git_repo}
    cd /infra-app || exit 1

    populate_db
    create_env
    pull_favicon

    npm install
    npm run build
    npm run preview -- --host
}

populate_db() {
    psql -h "${db_server}" -d ${db_name} -U ${db_user} -f /infra-app/sql/create.sql
    psql -h "${db_server}" -d ${db_name} -U ${db_user} -f /infra-app/sql/insert.sql
}

create_env() {
    {
      echo POSTGRES_PASSWORD=${db_password}
      echo DATABASE=${db_name}
      echo POSTGRES_USER=${db_user}
      echo SQL_INSTANCE_IP="${db_server}"
    } > /infra-app/.env
}

pull_favicon() {
    gcloud storage cp --recursive gs://infra-bucket-230516/static /infra-app
}

#--------------------------------Main------------------------------------------
install_dependencies
pull_from_vcs
#--------------------------------End-------------------------------------------
