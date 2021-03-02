#!/usr/bin/env bash
if [ $# -ne 1 ]
  then
    echo "USAGE: setup.sh <BASE_URL>"; exit;
fi

MAGENTO_BASE_URL=$1

CYAN='\033[0;36m'
NC='\033[0m' # No Color
printf "${CYAN}Delete existing composer images...${NC}\n"
./bin/docker-compose-delete.sh 
printf "${CYAN}Delete existing project files...${NC}\n"
./bin/magento-delete-project.sh 
printf "${CYAN}Create Magento project...${NC}\n"
./bin/magento-create-project.sh 
printf "${CYAN}Install Magento project...${NC}\n"
./bin/magento-install.sh $MAGENTO_BASE_URL
printf "${CYAN}Install sample data${NC}\n"
./bin/magento-install-sampledata.sh
