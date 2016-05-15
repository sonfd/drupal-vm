# Backup db and import db
DB=$1
SQL=$2

if [ ! -z $DB ] && [ ! -z $SQL ] && [ -f /web/db/$SQL ]; then
  vagrant ssh

  mysqldump -u root -proot $DB > /web/db/provision-backup/$DB.sql
  echo "$DB backed up to db/provision-backup/$DB.sql"

  mysql -u root -proot $DB < $SQL
  echo "$SQL imported to $DB"
else
  echo "No DB Imported"
fi
