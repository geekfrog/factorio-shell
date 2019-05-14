# factorio-shell
自己用的异星工厂脚本(支持游戏更新，崩溃重启)

我的系统是centos7 装了screen (yum install screen)

游戏本体在 /mnt/factorio 文件夹

存档配置在 /mnt/factorio-1-0.17 中

软连接将factorio中的bin/x64/factorio、data/base和data/core映射到/mnt/factorio-1-0.17文件夹

命令如下：

> ln -s /mnt/factorio/bin/x64/factorio /mnt/factorio-1-0.17/bin/x64
> 
> ln -s /mnt/factorio/data/base/ /mnt/factorio-1-0.17/data
> 
> ln -s /mnt/factorio/data/core/ /mnt/factorio-1-0.17/data

然后进factorio-1-0.17里修改配置，添加mod和存档

> screen -R game

创建游戏会话，在会话内 执行./run1.sh 启动游戏

再创建个自动更新的会话 执行 ./autoUpdate.sh

如果有不明白的就自己研究吧

潜~~~
