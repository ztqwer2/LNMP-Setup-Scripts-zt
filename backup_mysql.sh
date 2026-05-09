#!/bin/bash
#MySQL 连接配置
DB_USER="wpuser"
DB_PASSWORD="z1008611t"
DB_NAME="wordpress"
#备份目录
BACKUP_DIR="/home/admin/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/wordpress_$DATE.sql"

#创建备份目录
mkdir -p "$BACKUP_DIR"

#执行备份
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-tablespaces "$DB_NAME" > "$BACKUP_FILE"

#检查备份是否成功
if [ $? -eq 0 ];then
	echo "[$(date)]备份成功:$BACKUP_FILE" >> "$BACKUP_DIR/backup.log"
#删除7天前的旧备份
	find "$BACKUP_DIR" -name "*.sql" -mtime +7 -delete
else
	echo "[$(date)]备份失败" >> "$BACKUP_DIR/backup.log"
	exit 1
fi	
