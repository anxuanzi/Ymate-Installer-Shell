#!/bin/sh
for dir in $(ls -d */)
do
  cd $dir
  echo "正在更新项目$dir"
  git pull
  cd ..
done
