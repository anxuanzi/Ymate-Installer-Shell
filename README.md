# Ymate-Installer-Shell
Ymate平台开发环境快速安装脚本，本脚本默认从github克隆ymp核心以及各个子模块并使用mvn编译安装到本地mvn库中。

请确保您的系统已经配置了`Maven`并且可以在终端调用`mvn`命令

注意：当前脚本暂时只支持Linux或者Mac等环境，并且目前已适配`bash`与`zsh`两种shell。

欢迎各位大佬帮忙优化改善这个脚本！我是写脚本的新手。。。。

## 使用方法(Mac/Linux)
1. 使用终端等命令行工具进入想要存放ymp系列框架的目录

2. 执行命令`curl -O https://raw.githubusercontent.com/anxuanzi/Ymate-Installer-Shell/master/Ymate.sh && chmod 777 Ymate.sh && sudo ./Ymate.sh`

3. 脚本运行后会出现菜单，您可以选择安装与更新，我们在这选择`1`然后回车然后脚本会***在当前脚本所在的同一级***目录下安装ymp系列模块及框架。（安装过程中脚本会有提示，如果长时间无法克隆项目请终止脚本更改脚本中的git存储库链接为gitee的链接）

4. 安装完成会看到目录`ymate_environment`这个目录与Ymate.sh脚本文件在同一级

## 提示
1. 脚本首次安装后会在您的系统中加入一个别名`ymate`，你可以在终端直接调用这个命令来使用mvn插件创建ymate项目。

2. 执行更新选项时请您务必要在`ymate.sh`的脚本存放目录执行。（我真的是shell的新手，暂时还没有解决办法在任意位置执行任何想要的命令...）

## 其他
  非常感谢各位大佬的支持，我也希望更多的大佬能参与进ymate平台的社区建设中，欢迎贡献代码和开源基于ymate的应用。
