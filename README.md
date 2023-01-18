# family_db

Проект для запуска и создания базы данных

Команда создания базы и админа базы:
```bash
mysql -h 127.0.0.1 -P 3306 --protocol=tcp -u root -p < ./sql/create.sql
```
Команда загрузки dump-a базы из под пользователя admin:
```bash
mysql -h 127.0.0.1 -P 3306 --protocol=tcp -u admin -p "family" < ./sql/db_dump.sql
```