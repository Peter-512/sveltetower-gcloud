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
domain=sveltetower.tech
service=$(cat scripts/infra-app.service)

#--------------------------------Functions-------------------------------------
# Install postgresql-client, git, curl non-interactively
install_dependencies() {
    apt-get update -y && \
        curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - && \
        apt-get install -y postgresql-client git nodejs nginx && \
        rm -rf /var/lib/apt/lists/*
}

pull_from_vcs() {
    cd /
    git clone ${git_repo}
    cd /infra-app || exit 1

    populate_db
    create_env

    npm i
    npm run build
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
      echo PORT=8080
      echo HOST=127.0.0.1
    } > /infra-app/.env
}


enable_https() {
  openssl req -newkey rsa:4096 -nodes -keyout privkey.pem -x509 -days 365 -sha256 -out certificate.pem -subj /CN=$domain
#  cp privkey.pem /etc/ssl/private/
#  cp certificate.pem /etc/ssl/certs/
}

start_service() {
    cp /infra-app/scripts/infra-app.service /etc/systemd/system/infra-app.service
    systemctl daemon-reload
    systemctl start infra-app
    systemctl enable infra-app
}

#--------------------------------Main------------------------------------------
install_dependencies
pull_from_vcs
#enable_https
start_service
#--------------------------------End-------------------------------------------
