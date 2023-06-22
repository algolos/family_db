#!/bin/bash
mysql -h 127.0.0.1 -P 3306 --protocol=tcp -u root --password="root" < ./sql/create.sql;
mysql -h 127.0.0.1 -P 3306 --protocol=tcp -u admin --password="msTo!1991" "family" < ./sql/db_dump.sql;
