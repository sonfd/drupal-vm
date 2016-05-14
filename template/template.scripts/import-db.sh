# Backup db and import db
DB=$1
SQL=$2

if [ ! -z $DB ] && [ ! -z $SQL ] && [ -f /var/www/$SQL ]; then
  mysqldump -u root -proot $DB > /var/www/db/provision-backup/$1.sql
  echo "$1 backed up to db/provision-backup/$1.sql"

  mysql -u root -proot $DB < $SQL
  echo "$SQL imported to $DB"
else
  echo "No DB Imported"
fi
