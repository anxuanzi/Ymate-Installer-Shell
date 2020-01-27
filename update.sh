#!/bin/sh

clear

# 定义该脚本的临时文件的名字
TMP_FILE=/tmp/ymp_updater/log-
# 删除原来的临时垃圾
rm -rf ${TMP_FILE}*

echo "===================================================================="
echo "          ___          ___          ___       ___          ___      "
echo "         |\__\        /\__\        /\  \     /\  \        /\  \     "
echo "         |:|  |      /::|  |      /::\  \    \:\  \      /::\  \    "
echo "         |:|  |     /:|:|  |     /:/\:\  \    \:\  \    /:/\:\  \   "
echo "         |:|__|__  /:/|:|__|__  /::\~\:\  \   /::\  \  /::\~\:\  \  "
echo "         /::::\__\/:/ |::::\__\/:/\:\ \:\__\ /:/\:\__\/:/\:\ \:\__\ "
echo "        /:/~~/~   \/__/~~/:/  /\/__\:\/:/  //:/  \/__/\:\~\:\ \/__/ "
echo "       /:/  /           /:/  /      \::/  //:/  /      \:\ \:\__\   "
echo "       \/__/           /:/  /       /:/  / \/__/        \:\ \/__/   "
echo "                      /:/  /       /:/  /                \:\__\     "
echo "                      \/__/        \/__/                  \/__/     "
echo "===================================================================="
COUNT=100
for dir in $(ls -d */)
do
  cd $dir
  echo "===================================="
  echo "正在从github更新项目$dir"
  git pull &> /dev/null
  echo "____________________________________"
  echo "正在重新编译更新后的源码"
  # 获取当前时间
  CURRENT_TIME=`date +"%Y%m%d%H%M%S"`

  mvn clean source:jar install > ${TMP_FILE}${CURRENT_TIME}${COUNT}

  COMPILE_RESULT=`grep 'BUILD SUCCESS' ${TMP_FILE}${CURRENT_TIME}${COUNT}`
  
  if [ -z "$COMPILE_RESULT" ];
  then
    echo -e "\033[31m Maven 编译过程中发生错误，详情请您查看日志文件：${TMP_FILE}${CURRENT_TIME}${COUNT} \033[0m"
    echo -e "\033[44;37m 脚本终止 \033[0m"
    exit
  else
    echo -e "\033[32m[ 当前模块编译成功，进行下一模块编译... ]\033[0m"
  fi
  COUNT=$(($COUNT+100))
  echo "===================================="
  cd ..
done
echo "**********************"
echo "*    全部更新完成!    *"
echo "**********************"

