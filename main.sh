#!/usr/bin/env bash

# 微信 app 的位置
wechat_path="/Applications/WeChat.app"

# 没有安装微信则退出
if [[ ! -d ${wechat_path} ]]; then
  wechat_path="/Applications/微信.app"
  if [[ ! -d ${wechat_path} ]]; then
    echo "应用程序文件夹中未发现微信，请检查微信是否有重命名或者移动路径位置"
    exit
  fi
fi

# 工作目录
work_dir="${HOME}/.oh_my_wechat"

# 卸载 Oh My WeChat
uninstall_omw() {
  # 删除软链
  rm -f /usr/local/bin/omw
  # 删除工作目录
  rm -rf ${work_dir}
  echo "Oh My WeChat 卸载完成"
}

# 卸载小助手
uninstall_plugin() {
  echo "TODO: 卸载微信小助手的功能还没开发"
}

# omw uninstall
if [[ $1 == "uninstall" ]]; then
  PS3='你的选择：'
  options=("微信小助手" "Oh My WeChat" "两个都卸载" "取消")
  echo "你想卸载哪一个？"
  select opt in "${options[@]}"
  do
    case ${opt} in
      "微信小助手")
        uninstall_plugin
        break
        ;;
      "Oh My WeChat")
        uninstall_omw
        break
        ;;
      "两个都卸载")
        uninstall_plugin
        uninstall_omw
        break
        ;;
      "取消")
        break
        ;;
      *)
        echo "无效的选择"
        ;;
      esac
  done
  exit 0
fi

# 记录小助手的版本的文件地址，同时也可以用来判断小助手有没有被安装
version_plist_path="${wechat_path}/Contents/MacOS/WeChatPlugin.framework/Resources/Info.plist"

# 用 current_version 记录小助手的当前版本
if [[ -f ${version_plist_path} ]]; then
  current_version=$(awk '/<key>CFBundleShortVersionString<\/key>/,/<string>.*<\/string>/' ${version_plist_path} | grep -o '\d\{1,\}\.\d\{1,\}\.\d\{1,\}')
  echo "当前微信小助手版本为 v${current_version}"
  if [[ "$1" == "-n" ]]; then
    echo "由于设置了 -n 参数，将不会检查更新。"
  fi
fi

# 创建工作目录
if [[ ! -e ${work_dir} ]]; then
  mkdir ${work_dir}
fi

# 切换到工作目录
cd ${work_dir}

# 获取小助手的最新版本
get_latest_version() {
  if [[ -z ${latest_version} ]]; then
    echo "正在检查新版本……"
    latest_version=$(curl --retry 2 -I -s https://github.com/TKkk-iOSer/WeChatPlugin-MacOS/releases/latest | grep Location | sed -n 's/.*\/v\(.*\)/\1/p')
    if [[ -z "$latest_version" ]]; then
      echo "检查新版本时失败，将不会尝试安装新版本。"
    else
      latest_version=${latest_version//$'\r'/}
      if [[ "$current_version" != ${latest_version} ]]; then
        echo "发现新版本 v${latest_version}。"
      else
        echo "当前已是最新版本。"
      fi
    fi
  fi
}

# 检查是否有新的版本
has_update() {
  get_latest_version
  if [[ ! -z "$latest_version" ]] && [[ "$current_version" != "$latest_version" ]]; then
    return 0
  else
    return 1
  fi
}

# 判断插件是否已经安装过了
# 0 表示安装过了
# 1 表示微信没有安装小助手
is_installed() {
  if [[ -z ${current_version} ]]; then
    echo "检测到微信没有安装小助手"
    install_status=1
  else
    install_status=0
  fi
}

# 安装小助手
# TODO: 重新设计安装流程
# - 检查有没有安装包
#   - 如果有安装包
#     - 检查有没有传 -n 参数
#       - 如果没有，则检查安装包的版本是不是最新的
#         - 如果是，则直接运行安装包
#         - 如果不是，则下载安装最新版本并删除旧版本安装包
#       - 如果有，则直接运行安装包
#   - 如果没有安装包，则下载安装最新版本
install_version() {
  installed="y"
  _version=$1
  _old_version=$2
  # 删除旧版安装包
  if [[ -n ${_old_version} ]] && [[ "$_old_version" != "$_version" ]] && [[ -e WeChatPlugin-MacOS-${_old_version} ]]; then
    rm -rf WeChatPlugin-MacOS-${_old_version}
    echo "已删除旧版本 v${_old_version} 的缓存"
  fi
  # 如果没有下载过安装包
  if [[ ! -e WeChatPlugin-MacOS-${_version} ]]; then
    echo "开始下载微信小助手 v${_version}……"
    # 下载压缩包
    curl --retry 2 -L -o ${_version}.zip https://github.com/TKkk-iOSer/WeChatPlugin-MacOS/archive/v${_version}.zip
    if [[ 0 -eq $? ]]; then
      # 解压为同名文件夹
      unzip -o -q ${_version}.zip
      # 删除压缩包
      rm ${_version}.zip
      echo "下载完成"
    else
      echo "下载失败，请稍后重试。"
      exit 1
    fi
  fi
  echo "开始安装微信小助手……"
  ./WeChatPlugin-MacOS-${_version}/Other/Install.sh
  echo "微信小助手安装完成。"
}

openwechat() {
  _isWeChatRunning=$(ps aux | grep [W]eChat.app | wc -l)
  if [[ -n "$installed" ]] && [[ ${_isWeChatRunning} != "0" ]]; then
    echo "检测到微信正在运行，请重启微信让小助手生效。"
  else
    echo "打开微信"
    open ${wechat_path}
  fi
}

is_installed

# 如果已经安装过插件
if [[ ${install_status} -eq 0 ]]; then
  if [[ "$1" != "-n" ]] && has_update; then
    install_version
  fi
  # 如果小助手被卸载了，则走安装流程
elif [[ ${install_status} -eq 1 ]]; then
  install_version
fi

openwechat
