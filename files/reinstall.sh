#!/bin/bash

usage()
{
cat << EOF
usage $0 options

This script reinstalls magento 2

OPTONS:
    -s Include Sample Data
    -h Show this message
EOF
}

SAMPLE_DATA=
while getopts "hs" o; do
    case "${o}" in
        s)
            SAMPLE_DATA=1
            ;;
        h)
            usage
            exit 1
            ;;
    esac
done

cd /vagrant/data/magento2
rm -rf var/*
rm var/.maintenance.flag

if [[ -n $SAMPLE_DATA ]]; then
    echo "[+] Install sample data"
    php -f /vagrant/data/magento2-sample-data/dev/tools/build-sample-data.php -- --ce-source="/vagrant/data/magento2/"
fi

echo "[+] Composer..."
composer install

export MAGE_MODE='developer'
chmod +x bin/magento

echo "[+] Uninstalling..."
php -f bin/magento setup:uninstall -n

echo "[+] Installing..."
php -f bin/magento setup:install \
  --db-host='localhost' \
  --db-name='magento2' \
  --db-user='root' \
  --db-password='mage2' \
  --backend-frontname=admin \
  --base-url='http://dev.magento2.local/' \
  --language=en_US \
  --currency='USD' \
  --timezone=America/Los_Angeles \
  --admin-lastname='Admin' \
  --admin-firstname='Magento' \
  --admin-email='yourname@domain.com' \
  --admin-user='admin' \
  --admin-password='GentFlow123!' \
  --use-secure=0 \
  --use-rewrites=1 \
  --use-secure-admin=0 \
  --session-save=files

#change directory back to where user ran script
cd -
