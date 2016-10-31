#!/usr/bin/env bash

echo "=========================================== Do upgrade ===========================================";
sudo php bin/magento setup:upgrade;

echo "=========================================== Rm -rf var/ ===========================================";
sudo rm -rf var/*;

echo "=========================================== Cache flush ==========================================";
sudo php bin/magento cache:flush;

echo "=========================================== Do static deploy ==========================================";
# Você pode usar comando para definir apenas um thema: <cmd> --theme="Trezo/blank"
# E precisa passar o idioma <cmd> pt_BR
#sudo php bin/magento setup:static-content:deploy --theme="Trezo/blank";
#sudo php bin/magento setup:static-content:deploy --theme="Trezo/blank" pt_BR;
sudo php bin/magento setup:static-content:deploy pt_BR;

echo "=========================================== Fix Permissions ==========================================";
sudo find ./var -type d -exec chmod 777 {} \;
sudo find ./pub/media -type d -exec chmod 777 {} \;
sudo find ./pub/static -type d -exec chmod 777 {} \;
sudo chmod -R 777 var/;
sudo chmod -R 777 pub/;
