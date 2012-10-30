#!/bin/sh

### author: Liviu Panainte <liviu.panainte at gmail.com>
### 
### This script fetches the latest version of Wordpress and
### installs it in the current directory

WP_LINK="http://wordpress.org/latest.tar.gz"

echo
echo "============================================="
echo "=== Wordpress installer by Liviu Panainte ==="
echo "============================================="
echo

if [ ! -f "wp-app.php" ]
    then
        echo "Creating a temporary folder named wp-tmp ...";
        mkdir wp-tmp;

        echo "Changing directory to wp-tmp ...";
        cd wp-tmp;

        echo "Downloading the latest version of WP from $WP_LINK ..."
        curl -s http://wordpress.org/latest.tar.gz > wordpress.tar.gz;

        echo "Extracting the WP archive ..."
        tar -zxf wordpress.tar.gz;

        echo "Removing the default bundled wp-content folder ..."
        rm -rf wordpress/wp-content;

        echo "Moving Wordpress files to the project root ..."
        mv wordpress/* ../

        echo "Removing the wp-tmp folder ..."
        cd ..;
        rm -rf wp-tmp 

        echo
        echo "============================================="
        echo "========== Installation completed! =========="
        echo "==========                         =========="
        echo "====== Don't forget to manually update ======"
        echo "========== the wp-config.php file. =========="
        echo "============================================="
        echo
    else
        echo "Wordpress is already installed. Aborting script ..."
        echo
fi
