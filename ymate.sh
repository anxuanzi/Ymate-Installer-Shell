#!/bin/bash

clear

ARGUMENT=$1
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
echo "*                        Ymate-Platform批量工具                    *"
echo "===================================================================="

if [ ! $ARGUMENT ] ;then
	echo "脚本参数不能为空"
	exit 1
fi

repos_with_dev_2x=(
"https://git.ymate.net/suninformation/ymate-platform-v2.git"
"https://git.ymate.net/suninformation/ymate-module-fileuploader.git"
"https://git.ymate.net/suninformation/ymate-apidocs.git"
"https://git.ymate.net/suninformation/ymate-module-sso.git"
)

repos_with_master=(
"https://git.ymate.net/suninformation/ymate-maven-plugin.git"
)

repos_with_dev=(
"https://git.ymate.net/suninformation/ymate-module-captcha.git"
)

compile(){
	# 定义该脚本的临时文件的名字
	TMP_FILE=/tmp/ymp-log-
	# 删除原来的临时垃圾
	rm -rf ${TMP_FILE}*
	echo    "============================================="
	echo -e "        \033[35m 开始编译项目 \033[0m          "
	echo    "============================================="
	COUNT=100
	cd ymate-platform-v2
	echo -e "\033[34m 进入目录： ymate-platform-v2 \033[0m"
	echo -e "\033[34m 正在编译构建，请耐心等待... \033[0m"
	CURRENT_TIME=`date +"%Y%m%d%H%M%S"`
	log_file="${CURRENT_TIME}${COUNT}.log"
	touch ${TMP_FILE}${log_file}
	mvn clean source:jar install | tee -a ${TMP_FILE}${log_file}
	COMPILE_RESULT=`grep 'BUILD SUCCESS' ${TMP_FILE}${log_file}`
	if [ -z "$COMPILE_RESULT" ];
	then
    	echo -e "\033[31m Maven 编译过程中发生错误，详情请您查看日志文件：${TMP_FILE}${log_file} \033[0m"
    	echo -e "\033[44;37m 脚本终止 \033[0m"
 		exit
	else
 		echo -e "\033[32m[ 当前模块编译成功，进行下一模块编译... ]\033[0m"
	fi
	COUNT=$(($COUNT+100))
	cd ..

	for dir in $(ls -d */)
	do
		cd $dir
		echo -e "\033[34m 进入目录： $dir \033[0m"
		echo -e "\033[34m 正在编译构建，请耐心等待... \033[0m"
		CURRENT_TIME=`date +"%Y%m%d%H%M%S"`
		log_file="${CURRENT_TIME}${COUNT}.log"
		touch ${TMP_FILE}${log_file}
		mvn clean source:jar install | tee -a ${TMP_FILE}${log_file}
		COMPILE_RESULT=`grep 'BUILD SUCCESS' ${TMP_FILE}${log_file}`
		if [ -z "$COMPILE_RESULT" ];
		then
    		echo -e "\033[31m Maven 编译过程中发生错误，详情请您查看日志文件：${TMP_FILE}${log_file} \033[0m"
    		echo -e "\033[44;37m 脚本终止 \033[0m"
 			exit
		else
 			echo -e "\033[32m[ 当前模块编译成功，进行下一模块编译... ]\033[0m"
		fi
		COUNT=$(($COUNT+100))
		cd ..
	done
	echo -e "\033[32m[ 已成功编译构建所有项目！ ]\033[0m"
}

install(){
	echo    "============================================="
	echo -e "        \033[35m 从git仓库拉取项目 \033[0m     "
	echo    "============================================="
	for each in ${repos_with_dev_2x[@]}
	do
		name=`echo "$each"|awk -F'on/' '{print $2 }'|awk -F'.git' '{print $1}'`
  		echo -e "\033[35m 正在拉取项目: $name \033[0m"
		git clone -b dev_2.x $each
		if [ $? -eq 0 ] ;then
			echo -e "\033[35m DONE! \033[0m"
		fi
	done
	
	for each in ${repos_with_master[@]}
	do
		name=`echo "$each"|awk -F'on/' '{print $2 }'|awk -F'.git' '{print $1}'`
  		echo -e "\033[35m 正在拉取项目: $name \033[0m"
		git clone -b master $each
		if [ $? -eq 0 ] ;then
			echo -e "\033[35m DONE! \033[0m"
		fi
	done

	for each in ${repos_with_dev[@]}
	do
		name=`echo "$each"|awk -F'on/' '{print $2 }'|awk -F'.git' '{print $1}'`
  		echo -e "\033[35m 正在拉取项目: $name \033[0m"
		git clone -b master $each
		if [ $? -eq 0 ] ;then
			echo -e "\033[35m DONE! \033[0m"
		fi
	done

	compile
}

update(){
	for dir in $(ls -d */)
	do
		cd $dir
		git pull
		cd ..
	done

	compile
}


if  [ $ARGUMENT == "install" ] ;then
	install
elif [ $ARGUMENT == "update" ] ;then
	update
elif [ $ARGUMENT == "compile" ] ;then
	compile
else 
	echo -e "参数 '${ARGUMENT}' 不是一个有效的参数"
	exit 1
fi
