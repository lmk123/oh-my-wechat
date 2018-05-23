#!/bin/bash

# 微信 app 的位置
wechat_path=/Applications/WeChat.app

# 没有安装微信则退出
if [ ! -e $wechat_path ]; then
  wechat_path=${HOME}/Applications/WeChat.app
  if [ ! -e $wechat_path ]; then
    echo 没有安装微信
    exit 0
  fi
fi

# 工作目录
work_dir=${HOME}/.oh_my_wechat
# 使用一个文件记录微信小助手的版本
version_file=version
# 通过是否有 backup 文件判断微信里有没有安装微信小助手
app_executable_backup_path=${wechat_path}/Contents/MacOS/WeChat_backup

# 如果执行命令时的第一个参数是 -n 则不检查更新
noupdate_cmd=$1

# 创建工作目录
if [ ! -e $work_dir ]; then
  mkdir $work_dir
fi

# 切换到工作目录
cd $work_dir

# 获取当前版本
if [ -f $version_file ]; then
  current_version=$(cat $version_file)
  current_version=${current_version//$'\r'/}
  echo 当前微信小助手版本为 v${current_version}

  if [ "$noupdate_cmd" == "-n" ]; then
    echo 由于设置了 -n 参数，将不会检查更新。
  fi
fi

getlatestversion() {
  if [ -z $latest_version ]; then
    echo 正在检查新版本……
    latest_version=$(curl -I -s https://github.com/TKkk-iOSer/WeChatPlugin-MacOS/releases/latest | grep Location | sed -n 's/.*\/v\(.*\)/\1/p')
    latest_version=${latest_version//$'\r'/}
    if [ "$current_version" != $latest_version ]; then
      echo 发现新版本 v${latest_version}。
    else
      echo 当前已是最新版本。
    fi
  fi
}

# 检查是否有新的版本
hasupdate() {
  getlatestversion
  if [ "$current_version" != $latest_version ]; then
    return 0
  else
    return 1
  fi
}

# 判断插件是否已经安装过了
# 0 表示安装过了
# 1 表示这是第一次安装微信小助手，需要更新到最新版本
# 2 表示微信自动更新时删除了微信小助手
is_installed() {
  if [ -z $current_version ]; then
    echo 第一次运行时会将微信小助手更新到最新版本。
    install_status=1
  elif [ ! -f $app_executable_backup_path ]; then
    echo 监测到微信自动更新后删除了微信小助手
    install_status=2
  else
    install_status=0
  fi
}

# 安装插件
install_version() {
  _version=$1
  _old_version=$2
  # 删除旧版安装包
  if [ -n $_old_version ] && [ -e WeChatPlugin-MacOS-$_old_version ]; then
    rm -rf WeChatPlugin-MacOS-$_old_version
    echo 已删除旧版本 v${_old_version} 的缓存
  fi
  # 如果没有下载过安装包
  if [ ! -e WeChatPlugin-MacOS-$_version ]; then
    echo 开始下载微信小助手 v${_version}……
    # 下载压缩包
    curl -L -o ${_version}.zip https://github.com/TKkk-iOSer/WeChatPlugin-MacOS/archive/v${_version}.zip
    # 解压为同名文件夹
    unzip -o -q ${_version}.zip
    # 删除压缩包
    rm ${_version}.zip
    echo 下载完成
  fi
  echo 开始安装微信小助手……
  ./WeChatPlugin-MacOS-$_version/Other/Install.sh
  # 写入版本
  echo $_version >$version_file
  echo 微信小助手安装完成。
}

openwechat() {
  echo 打开微信
  open $wechat_path
}

is_installed

# 如果已经安装过插件，则判断要不要检查更新
if [ $install_status -eq 0 ]; then
  if [ "$noupdate_cmd" != "-n" ] && hasupdate; then
    install_version $latest_version $current_version
  fi
  # 如果是第一次安装，那总是安装最新版
elif [ $install_status -eq 1 ]; then
  getlatestversion
  install_version $latest_version
  # 如果因为微信自动更新导致插件被删除
elif [ $install_status -eq 2 ]; then
  # 如果不需要更新则安装当前版本。因为有缓存所以无需重新下载，会很快
  if [ "$noupdate_cmd" == "-n" ]; then
    install_version $current_version
  else
    # 如果需要安装更新则检查一下最新版本
    getlatestversion
    install_version $latest_version $current_version
  fi
fi

openwechat
