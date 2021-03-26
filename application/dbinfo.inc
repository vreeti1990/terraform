<?php

define('DB_SERVER', 'vreeti-api-db.cpfx8w5nhiyc.us-west-2.rds.amazonaws.com');
define('DB_USERNAME', 'dbadmin');
define('DB_PASSWORD', 'aws ssm get-parameter --name /dev/vreeti-api-db/vreeti-api-db-password --region us-west-2');
define('DB_DATABASE', 'vreetidb');

?>