#!/bin/bash -ex
sudo yum update -y 
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server
sudo systemctl start httpd
sudo systemctl enable httpd
aws s3 cp s3://vreeti-code-bucket/redirect.conf /etc/httpd/conf.d/
cd /var/www && mkdir inc && cd inc
aws s3 cp s3://vreeti-code-bucket/dbinfo.inc /var/www/inc/
aws s3 cp s3://vreeti-code-bucket/SamplePage.php /var/www/html/
sudo systemctl restart httpd
