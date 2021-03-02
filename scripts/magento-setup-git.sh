#!/usr/bin/env bash
if [ $# -ne 2 ]
  then
    echo "USAGE: magento-setup-git.sh <git-url> <BASE_URL>"; exit;
fi

GIT_URL=$1
MAGENTO_BASE_URL=$2

CYAN='\033[0;36m'
NC='\033[0m' # No Color
printf "${CYAN}Delete existing composer images...${NC}\n"
./scripts/docker-compose-delete.sh 
printf "${CYAN}Delete existing project files...${NC}\n"
./scripts/magento-delete-project.sh 
printf "${CYAN}Create Magento project...${NC}\n"
docker-compose run -v ~/.git-credentials:/root/.git-credentials -v ~/.ssh:/root/.ssh --rm -w /var/www php-composer git clone $1 html
printf "${CYAN}Install Magento project...${NC}\n"
./scripts/magento-install.sh $MAGENTO_BASE_URL
printf "${CYAN}Configure Magento project...${NC}\n"
./scripts/magento-configure.sh
printf "${CYAN}Install sample data${NC}\n"
./scripts/magento-install-sampledata.sh
printf "${CYAN}Configure Magento${NC}\n"
./scripts/magento-configure.sh



