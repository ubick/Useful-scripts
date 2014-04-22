#!/bin/bash
############# This section is the actual vhost data, that goes in the /etc/httpd/vhost.d/$DOMAIN.conf file
DOMAIN=$1
DATA="<VirtualHost *:8080>
        ServerName $DOMAIN
        ServerAlias www.$DOMAIN
        #### This is where you put your files for that domain: /var/www/vhosts/$DOMAIN
        DocumentRoot /Users/lpanainte/work/$DOMAIN
        <Directory /Users/lpanainte/work/$DOMAIN>
                # This section sets directives for the directory.
                # -Indexes <-- That blocks index listings on folders that don't have a default file (index.php/index.html/default.html/etc)
                # FollowSymLinks <-- This will treat symlinks like they should be treated in linux: as folders/files in the folder the symlink resides
                # MultiViews  <--It's easier for you to read this: http://httpd.apache.org/docs/2.0/content-negotiation.html#multiviews
                Options -Indexes FollowSymLinks MultiViews
                # AllowOverride All <-- This is required for Apache HTTPD server to read .htaccess files.  It says that you can have a per-folder override for apache directives
                AllowOverride All
        </Directory>
        ## Everything to see here. Just the log files.  Good to use for troubleshooting errors.
        CustomLog /var/log/apache2/$DOMAIN-access.log combined
        ErrorLog /var/log/apache2/$DOMAIN-error.log

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn
</VirtualHost>


####################THIS SECTION COMMENTED OUT BY DEFAULT.  IT IS FOR HTTPS ONLY.  USE ONLY IF YOU NEED, AND YOU UNDERSTAND WHAT YOU ARE DOING!
#################### Documentation for usage can be found here: http://httpd.apache.org/docs/2.0/ssl/ssl_faq.html 
#<VirtualHost _default_:443>
#        ServerName $DOMAIN
#        DocumentRoot var/www/vhosts/$DOMAIN
#        <Directory var/www/vhosts/$DOMAIN>
#                Options Indexes FollowSymLinks MultiViews
#                AllowOverride All
#        </Directory>
#
#        CustomLog /var/log/httpd/$DOMAIN-ssl-access.log combined
#        ErrorLog /var/log/httpd/$DOMAIN-ssl-error.log
#
        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
#        LogLevel warn
#
#        SSLEngine on
#        SSLCertificateFile    /etc/pki/tls/certs/localhost.crt
#        SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
#
#        <FilesMatch \"\.(cgi|shtml|phtml|php)$\">
#                SSLOptions +StdEnvVars
#        </FilesMatch>
#
#        BrowserMatch \"MSIE [2-6]\" \
#                nokeepalive ssl-unclean-shutdown \
#                downgrade-1.0 force-response-1.0
#        BrowserMatch \"MSIE [17-9]\" ssl-unclean-shutdown
#</VirtualHost>"
################## OK, this next section will make the required directories, and if that succeeds, it changes the directory to apache. if THAT is good, then it will echo the data to the vhost config file.
#################### If THAT all goes well, it restarts httpd, and your vhosts should be up and running!
sudo mkdir -p /Users/lpanainte/work/$DOMAIN && chown lpanainte:staff /Users/lpanainte/work/$DOMAIN && echo "$DATA" > /etc/apache2/other/$DOMAIN.conf && apachectl restart
