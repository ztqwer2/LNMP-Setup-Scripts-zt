#!/bin/bash

#判断参数是否为0
if [ $# != 1 ]
then
	echo "参数错误，只能输入一个目录参数，作为归档目录名"
	exit
fi

#从参数中获取目标目录
if [ -d $1 ];
then
	echo
else 
	echo "目录不存在"
	echo 
	exit
fi

DIR_NAME=$(basename $1)
DIR_PATH=$(cd $(dirname $1); pwd)

#获取当前日期
DATE=$(date +%Y%m%d)

#生成定义的归档文件名称
ARCHIVE_DIR="/root/archive"
mkdir -p "$ARCHIVE_DIR"
FILE=archive_${DIR_NAME}_$DATE.tar.gz
DEST="$ARCHIVE_DIR/$FILE"

#开始归档目录文件

echo
echo "开始归档..."

tar -czf "$DEST" "$DIR_PATH/$DIR_NAME"

if [ $? -eq 0 ]
then
	echo
	echo "归档成功"
	echo "归档文件为: $DEST"
	echo
else
	echo "归档出现问题"
fi

exit
