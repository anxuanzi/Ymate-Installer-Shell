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

read -p "请输入操作数字并按回车（1.安装 2.更新）: ->>> " sel_num


if [ ! $sel_num ] ;then
  echo "输入不能为空"
  exit 1
elif [ $sel_num -eq 1 ];then

echo "安装中 请耐心等待(速度根据网络而定.)"

git_dir="Ymate-env"
[ -d $git_dir ]&&echo "存在"||mkdir $git_dir

cd $git_dir

echo -e "\033[35m 创建更新项目的脚本 \033[0m"

wget https://raw.githubusercontent.com/anxuanzi/Ymate-Installer-Shell/master/update.sh

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
echo -e "\033[47;30m =========  已全部编译安装完成，程序自动退出！！！！ \033[0m"

elif [ $sel_num -eq 2 ];then

cd Ymate-env

./update.sh

else
  echo "输入有误 请检查"
fi

}

menu


