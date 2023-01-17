DROP DATABASE IF EXISTS family;
CREATE DATABASE IF NOT EXISTS family;
# drop user family@localhost;
CREATE USER 'admin'@'%' IDENTIFIED BY 'msTo$1991';
GRANT ALL ON family.* TO 'admin'@'%';
FLUSH PRIVILEGES;
