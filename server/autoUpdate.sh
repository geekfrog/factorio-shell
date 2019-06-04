#!/bin/bash
#########################################################


# factorio自动更新脚本
# 作者：宅宅蛙
# QQ：324747460


#########################################################

screen_name="game"
shell_name="run1.sh"
function curTime(){
	echo "[`date "+%Y-%m-%d %H:%M:%S"`]"
}
function updateGame(){
	echo "$(curTime) 开始更新 ${newVer} 版本..."
	echo "$(curTime) 正在关闭游戏..."
	screen -S $screen_name -X -p 0 stuff $'\003'
    while ps -ef | grep "/mnt/factorio-1-0.17/bin/x64//factorio --start-server-load-latest" | grep -v 'grep'; do
	   echo "$(curTime) 等待游戏关闭..."
       sleep 5s
       continue
    done
	echo "$(curTime) 删除游戏主体"
	rm -rf ./factorio
	echo "$(curTime) 解压游戏主体"
	tar xvJf ${fileName}
	echo "$(curTime) 启动游戏中..."
	screen -x -S $screen_name -p 0 -X stuff "cd /mnt"
	screen -x -S $screen_name -p 0 -X stuff $'\n'
	screen -x -S $screen_name -p 0 -X stuff "./${shell_name}"
	screen -x -S $screen_name -p 0 -X stuff $'\n'
	echo "$(curTime) 游戏启动成功！"
	echo ${newVer} > ver.txt
}
function updateNotice(){
	echo "$(curTime) 正在通知服务期内玩家..."
	for loop in 1 2 3 4 5
	do
		echo "$(curTime) 第${loop}次通知."
		screen -x -S $screen_name -p 0 -X stuff "服务器即将更新，请在更新后使用新版本进入游戏！"
		screen -x -S $screen_name -p 0 -X stuff $'\n'
		sleep 10s
	done
}
function dlNewGame(){
	fileName="factorio_headless_x64_${newVer}.tar.xz"
	echo "$(curTime) 开始下载 ${newVer} 版本..."
	http_code=`curl -L -o ${fileName} -w %{http_code} https://www.factorio.com/get-download/${newVer}/headless/linux64`
	if [ "${http_code}" = "200" ]; then
		echo "$(curTime) 下载成功！"
		updateNotice
		updateGame
	else
		echo "$(curTime) 下载失败，稍后重试！"
	fi
}
function checkVersion(){
	echo "$(curTime) 正在检查最新版本..."
	http_code=`curl -m 10 -o factorio.html -w %{http_code} https://www.factorio.com/download-headless/experimental`
	if [ "${http_code}" = "200" ]; then
		newVer=`grep -m1 -o -e "0\.[[:digit:]]\{2\}\.[[:digit:]]\{2\}" ./factorio.html`
		localVer=`grep -m1 -o -e "0\.[[:digit:]]\{2\}\.[[:digit:]]\{2\}" ./ver.txt`
		if [ "${newVer}x" = "${localVer}x" ]; then
			echo "$(curTime) 暂无新版本";
		else
			echo "$(curTime) 发现最新版本 ${newVer} ,当前版本 ${localVer}";
			dlNewGame
		fi
	else
		echo "$(curTime) 获取最新版本失败，稍后重试！"
	fi
}
echo "$(curTime) 自动更新已启动！"
while true
do
    checkVersion
	if [ "`ps -ef | grep "/mnt/factorio-1-0.17/bin/x64//factorio --start-server-load-latest" | grep -v 'grep'`" ]; then
		echo "$(curTime) 游戏运行中..."
	else
		echo "$(curTime) 检测到游戏未运行，尝试运行游戏！"
		screen -x -S $screen_name -p 0 -X stuff "cd /mnt"
		screen -x -S $screen_name -p 0 -X stuff $'\n'
		screen -x -S $screen_name -p 0 -X stuff "./${shell_name}"
		screen -x -S $screen_name -p 0 -X stuff $'\n'
		echo "$(curTime) 游戏启动成功！"
	fi
	sleep 10m
done
