#!/bin/sh

yum install -y httpd
service httpd start
chkonfig httpd on
echo "<html><h1>Installed using terraform</h1></html>" > /var/www/html/index.html
