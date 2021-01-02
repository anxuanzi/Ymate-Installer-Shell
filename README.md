# Ymp 批量操作脚本
Ymate平台开发环境快速安装脚本，本脚本从ymp最新版本私有git仓库拉取ymp核心以及各个子模块并使用mvn编译安装到本地mvn库中。

请确保您的系统已经配置了`Maven`并且可以在终端调用`mvn`命令

注意：当前脚本暂时只支持Linux或者Mac等环境，已在`bash`与`zsh`两种shell环境测试。

欢迎各位大佬帮忙优化改善这个脚本！我是写脚本的新手。。。。

## 使用方法(Mac/Linux)

1. 使用终端等命令行工具进入想要存放ymp所有模块的目录

2. 执行命令`curl -O https://raw.githubusercontent.com/anxuanzi/Ymate-Installer-Shell/ymp_2.x/ymate.sh && chmod +x ymate.sh`

3. 脚本包含3个功能，分别是安装，编译，更新（`install`, `compile`, `update`），使用时将这三个中的一个作为脚本的第一个参数即可

## 其他
  非常感谢各位大佬的支持，我也希望更多的大佬能参与进ymate平台的社区建设中，欢迎贡献代码和开源基于ymate的应用。
