FROM ubuntu:18.04
# files for drivers installation
COPY ./files/* /opt/oracle/
COPY ./scripts* /home/scripts/ 
# envinroment variable to disable interactivity 
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y \
    # link the files of timezone
    && ln -fs /usr/share/zoneinfo/America/Manaus /etc/localtime \
    && apt-get install -y unzip tzdata expect \ 
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && cd /opt/oracle \
    # set the oracle drivers
    && unzip instantclient-basic-linux.x64-12.2.0.1.0.zip \
    && unzip /opt/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip \
    && apt-get install -y $(cat /opt/oracle/lista.lst)  \
    # create a symlink to instant client files.
    && ln -s /opt/oracle/instantclient_12_2/libclntsh.so.12.1 /opt/oracle/instantclient_12_2/libclntsh.so \
    && ln -s /opt/oracle/instantclient_12_2/libocci.so.12.1 /opt/oracle/instantclient_12_2/libocci.so \
    # add the folder to ldconfig.
    && echo /opt/oracle/instantclient_12_2 > /etc/ld.so.conf.d/oracle-instantclient.conf \
    # update the dynamic linker run-time bindings
    && ldconfig \
    # install some needed packages for installation of oci8 extension
    && apt-get install -y php-pear build-essential libaio1 \
    # update the pecl channel
    && pecl channel-update pecl.php.net \
    # run the scripts which installs the oci8 extension
    && cd /home/scripts \
    && ./answer \ 
    # install apache2 and utils
    && apt-get install -y apache2 apache2-bin \
                          apache2-data apache2-dbg \
                          apache2-dev apache2-doc  \
                          apache2-ssl-dev apache2-utils \
    && mkdir /etc/php/7.2/apache2 \
    # load the extension to php
    && echo "extension =oci8.so" >> /etc/php/7.2/fpm/php.ini \
    && echo "extension =oci8.so" >> /etc/php/7.2/cli/php.ini \
    && echo "extension =oci8.so" >> /etc/php/7.2/apache2/php.ini \
    # add need environment variables to apache
    && echo "export LD_LIBRARY_PATH=/opt/oracle/instantclient_12_2" >> /etc/apache2/envvars \
    && echo "export ORACLE_HOME=/opt/oracle/instantclient_12_2" >> /etc/apache2/envvars \
    && echo "LD_LIBRARY_PATH=/opt/oracle/instantclient_12_2:$LD_LIBRARY_PATH" >> /etc/environment \
    && apt-get install libapache2-mod-php7.2 -y \
    && echo "<?php\n   phpinfo();\n?>" > /var/www/html/teste.php 

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]   
