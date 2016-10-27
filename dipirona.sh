#!/bin/bash

echo "Fix permissions";
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;
find ./var -type d -exec chmod 777 {} \;
find ./pub/media -type d -exec chmod 777 {} \;
find ./pub/static -type d -exec chmod 777 {} \;
chown -R carlos:carlos ./;
chmod -R 777 app/etc;
chmod -R 644 app/etc/*.xml;
chmod u+x bin/magento;
echo "Finish fix permission";