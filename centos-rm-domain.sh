#!/bin/bash
############# This section is the actual vhost data, that goes in the /etc/httpd/vhost.d/$DOMAIN.conf file
DOMAIN=$1
ACCESS_LOG="/var/log/httpd/$DOMAIN-access.log"
ERROR_LOG="/var/log/httpd/$DOMAIN-error.log;"
VHOST_CONF="/etc/httpd/vhost.d/$DOMAIN.conf"
SITE="/var/www/vhosts/$DOMAIN"

echo

echo "Deleting the Apache access log: $ACCESS_LOG ..."
rm -rf $ACCESS_LOG;

echo "Deleting the Apache error log: $ERROR_LOG ..."
rm -rf $ERROR_LOG;

echo "Deleting the Apache vhost config: $VHOST_CONF ..."
rm -rf $VHOST_CONF;

echo "Deleting the website files: $SITE ..."
rm -rf $SITE;

echo
echo "Finished! Don't forget to manually delete the database files."
echo
