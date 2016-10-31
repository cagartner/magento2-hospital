#!/bin/bash
echo "=========================================== Enable all modules ===========================================";
read -r -p "Habilitar módulos? [y/n] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
sudo php bin/magento module:enable --all;
fi

echo "=========================================== Do upgrade ===========================================";
read -r -p "Fazer upgrade? [y/n] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
sudo php bin/magento setup:upgrade;
fi

echo "=========================================== Rm -rf var/ ===========================================";
sudo rm -rf var/*;

echo "=========================================== Do setup di compile ===========================================";
read -r -p "Fazer upgrade? [y/n] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
sudo php bin/magento setup:di:compile;
fi

echo "=========================================== Do Reindex ===========================================";
read -r -p "Roda re-index? [y/n] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
sudo php bin/magento indexer:reindex;
fi

echo "=========================================== Cache flush ==========================================";
sudo php bin/magento cache:flush;

echo "=========================================== Rm pub cache frontend ==========================================";
sudo rm -rf pub/static/* var/cache/* var/view_preprocessed/css/frontend/* var/view_preprocessed/source/*;

echo "=========================================== Do static deploy ==========================================";
read -r -p "Deploy theme? [y/n] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
#sudo php bin/magento setup:static-content:deploy --theme="Trezo/blank";
#sudo php bin/magento setup:static-content:deploy --theme="Trezo/blank" pt_BR;
sudo php bin/magento setup:static-content:deploy pt_BR;
fi

echo "=========================================== Fix Permissions ==========================================";
sudo find ./var -type d -exec chmod 777 {} \;
sudo find ./pub/media -type d -exec chmod 777 {} \;
sudo find ./pub/static -type d -exec chmod 777 {} \;
sudo chmod -R 777 var/;
sudo chmod -R 777 pub/;
