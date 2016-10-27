#!/bin/bash
echo "=========================================== Enable all modules ===========================================";
php bin/magento module:enable --all;

echo "=========================================== Do upgrade ===========================================";
php bin/magento setup:upgrade;

echo "=========================================== Rm -rf var/ ===========================================";
sudo rm -rf var/*;

echo "=========================================== Do setup di compile ===========================================";
php bin/magento setup:di:compile;

echo "=========================================== Do Reindex ===========================================";
php bin/magento indexer:reindex;

echo "=========================================== Cache flush ==========================================";
php bin/magento cache:flush;

echo "=========================================== Rm pub cache frontend ==========================================";
sudo rm -rf pub/static/* var/cache/* var/view_preprocessed/css/frontend/* var/view_preprocessed/source/*;

echo "=========================================== Do static deploy ==========================================";
php bin/magento setup:static-content:deploy;
php bin/magento setup:static-content:deploy pt_BR;

echo "=========================================== Fix Permissions ==========================================";
find ./var -type d -exec chmod 777 {} \;
find ./pub/media -type d -exec chmod 777 {} \;
find ./pub/static -type d -exec chmod 777 {} \;
chmod -R 777 var/;
chmod -R 777 pub/;