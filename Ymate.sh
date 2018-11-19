#!/bin/bash

git_add=(
"https://github.com/suninformation/ymate-framework-v2.git"
"https://github.com/suninformation/ymate-platform-v2.git"
"https://github.com/suninformation/ymate-maven-extension.git"
"https://github.com/suninformation/ymate-module-security.git"
"https://github.com/suninformation/ymate-module-fileuploader.git"
"https://github.com/suninformation/ymate-module-mailsender.git"
"https://github.com/suninformation/ymate-apidocs.git"
"https://github.com/suninformation/ymate-module-captcha.git"
"https://github.com/suninformation/ymate-module-oauth.git"
"https://github.com/suninformation/ymate-module-oauth-connector.git"
"https://github.com/suninformation/ymate-module-scheduler.git"
"https://github.com/suninformation/ymate-module-sso.git"
"https://github.com/suninformation/ymate-module-embed.git"
)


menu(){
clear
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
echo "*                        Ymate-Platform快速工具                      *"
echo "===================================================================="
echo " 当您选择安装后脚本会将ymate命令加入到系统变量中(请您不要再更改此脚本的存储位置)"
echo "===================================================================="
read -p "请输入数字并按回车（1.安装 2.更新 3.创建项目）: ->>> " sel_num
if [ ! $sel_num ] ;then
  echo "输入不能为空"
  exit 1
elif [ $sel_num -eq 1 ];then

echo "安装中 请耐心等待(速度根据网络而定.)"

git_dir="Ymate-env"
[ -d $git_dir ]&&echo "存在"||mkdir $git_dir

echo    "============================================="
echo -e "        \033[35m 创建系统变量中 \033[0m         "
echo    "============================================="
SHELL_DIR=$(cd "$(dirname "$0")";pwd)
BASH_PROFILE_NAME=".bash_profile"
cd
echo -e "alias ymate=\"sh ${SHELL_DIR}/Ymate.sh\"" >> ${BASH_PROFILE_NAME}
source .bash_profile

cd $git_dir

wget https://raw.githubusercontent.com/anxuanzi/Ymate-Installer-Shell/master/update.sh &>/dev/null

chmod 777 update.sh

for i in ${git_add[@]}

do
  name=`echo "$i"|awk -F'on/' '{print $2 }'|awk -F'.git' '{print $1}'`
  echo -e "\033[35m 正在从git仓库拉取项目: $name \033[0m"
  echo "——————————————————————————————————————————————————————————"
  git clone $i &> /dev/null
  status=`echo $?`
  pwd
done

echo -e "\033[33m ****** 项目已全部拉取完成！！！ ****** \033[0m"
echo -e "\033[33m ******    开始编译安装       ****** \033[0m"

for dir in $(ls -d */)
do
cd $dir
echo -e "\033[34m 进入目录： $dir \033[0m"
echo -e "\033[34m 正在编译安装源码，请耐心等待（一般情况不会卡住） \033[0m"
echo "-------------------------------------------------------"
mvn clean source:jar install &> /dev/null
cd ..
done
echo -e "\033[47;30m  已全部安装编译完成，请您重启终端或者控制台程序以启用ymate命令 \033[0m"

elif [ $sel_num -eq 2 ];then

cd Ymate-env

./update.sh

elif [ $sel_num -eq 3 ];then

clear

echo "请稍候..."

mvn archetype:generate -DarchetypeCatalog=local

else
  echo "输入有误 请检查"
fi

}

menu


