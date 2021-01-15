#!/usr/bin/env bash

echo_with_date() {
  echo "[`date '+%H:%M:%S'`]" $1
}

omw_version=2.1.1
echo_with_date "当前 Oh My WeChat 版本为 v${omw_version}"

# 从 GitHub 获取 owm 版本号
get_omw_latest_version_from_github() {
  curl --retry 2 -I -s https://github.com/lmk123/oh-my-wechat/releases/latest | grep Location | sed -n 's/.*\/v\(.*\)/\1/p'
}

get_download_url() {
  echo https://github.com/MustangYM/WeChatExtension-ForMac/archive/v${1}.zip
}

get_latest_version() {
  curl --retry 2 -I -s https://github.com/MustangYM/WeChatExtension-ForMac/releases/latest | grep Location | sed -n 's/.*\/v\(.*\)/\1/p'
}

# 保存一下 -n 参数，给 install 方法作为参数用
if [[ $* =~ "-n" ]]
then
  has_n="-n"
else
  has_n=""
fi

# select 提示语
PS3='你的选择：'

# 微信 app 的位置
wechat_path="/Applications/WeChat.app"

# 没有安装微信则退出
if [[ ! -d ${wechat_path} ]]; then
  wechat_path="/Applications/微信.app"
  if [[ ! -d ${wechat_path} ]]; then
    echo_with_date "应用程序文件夹中未发现微信，请检查微信是否有重命名或者移动路径位置"
    exit
  fi
fi

# 执行命令时的工作目录
initial_pwd=$(pwd)

# omw 的工作目录
work_dir="${HOME}/.oh_my_wechat"

# 切换到 omw 的工作目录，可以避免后面的所有操作都需要指定 omw 的工作目录
cd ${work_dir}

# 记录小助手的版本的文件地址，同时也可以用来判断小助手有没有被安装
version_plist_path="${wechat_path}/Contents/MacOS/WeChatExtension.framework/Resources/Info.plist"

# 已经下载过的安装包版本，同时当微信自动更新导致小助手被删除时，作为上一次安装过的版本号使用
downloaded_version=$(find . -maxdepth 1 -type d -name 'WeChatExtension-ForMac-*' -print -quit | grep -o '\d\{1,\}\.\d\{1,\}\.\d\{1,\}')

# 用 current_version 记录小助手的当前版本
if [[ -f ${version_plist_path} ]]; then
  current_version=$(awk '/<key>CFBundleShortVersionString<\/key>/,/<string>.*<\/string>/' ${version_plist_path} | grep -o '\d\{1,\}\.\d\{1,\}\.\d\{1,\}')
  echo_with_date "当前微信小助手版本为 v${current_version}"
else
  echo_with_date "当前没有安装微信小助手"
fi

# 判断微信是否正在运行
is_wechat_running=$(ps aux | grep [W]eChat.app | wc -l)
# 删掉前面的空白
is_wechat_running="${is_wechat_running#"${is_wechat_running%%[![:space:]]*}"}"
# 删掉后面的空白
is_wechat_running="${is_wechat_running%"${is_wechat_running##*[![:space:]]}"}"

# 下载指定版本的小助手
download() {
  if [[ ! -e "WeChatExtension-ForMac-${1}" ]]; then
    # 第二个参数作为要打印的消息
    if [[ -n ${2} ]]; then
      echo_with_date ${2}
    fi
    echo_with_date "开始下载微信小助手 v${1}……"
    # 下载压缩包
    curl --retry 2 -L -o ${1}.zip $(get_download_url $1)
    if [[ 0 -eq $? ]]; then
      # 解压为同名文件夹
      unzip -o -q ${1}.zip
      # 删除压缩包
      rm ${1}.zip
      echo_with_date "下载完成"
    else
      echo_with_date "下载失败，请稍后重试。"
      exit 1
    fi
  fi
}

plist_path="${HOME}/Library/LaunchAgents/cn.limingkai.oh-my-wechat.plist"

ask_for_auto_start() {
  if [[ -e ${plist_path} ]]; then
    echo_with_date "已开启开机自动安装微信小助手"
  else
    echo_with_date "未开启开机自动安装微信小助手"
    echo_with_date "是否开启开机自动安装微信小助手, 以避免微信更新后卸载微信小助手？"
    options=("是" "否")
    select opt in "${options[@]}"
    do
      case ${opt} in
        "是")
          _to_open='yes'
          break
          ;;
        "否")
          _to_open='no'
          break
          ;;
        *)
          echo_with_date "无效的选择"
          ;;
        esac
    done

    if [[ $_to_open == "yes" ]]; then
      open_auto_start
    fi
  fi
}

open_auto_start() {
  echo_with_date "是否要在开机后自动打开微信？"
  options=("是" "否")
  select opt in "${options[@]}"
  do
    case ${opt} in
      "是")
        _is_open="-o"
        break
        ;;
      "否")
        break
        ;;
      *)
        echo_with_date "无效的选择"
        ;;
      esac
  done

  cat > ${plist_path} <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>cn.limingkai.oh-my-wechat</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/bin/omw</string>
      <string>silent</string>
      <string>${_is_open}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>
EOL
  echo_with_date "已开启微信小助手开机自动安装"
}

close_auto_start() {
  if [[ -e ${plist_path} ]]; then
    rm ${plist_path}
    echo_with_date "已关闭开机自动安装微信小助手"
  else
    echo_with_date "当前没有开启开机自动安装微信小助手"
  fi
}

# 卸载 Oh My WeChat
uninstall_omw() {
  # 删除开启自启动配置文件
  close_auto_start
  # 删除软链
  rm -f /usr/local/bin/omw
  # 删除工作目录
  rm -rf ${work_dir}
  echo_with_date "Oh My WeChat 卸载完成"
}

# 卸载小助手
uninstall_plugin() {
  if [[ -n ${current_version} ]]; then
    # 确保有当前版本的小助手安装包
    download ${current_version} "卸载小助手时需要先下载小助手的安装包"
    # 运行卸载脚本
    ./WeChatExtension-ForMac-${current_version}/WeChatExtension/Rely/Uninstall.sh
    echo_with_date "微信小助手卸载完成"
    if [[ ${is_wechat_running} != "0" ]]; then
      echo_with_date "检测到微信正在运行，需要重启微信才能关闭小助手"
    fi
  else
    echo_with_date "当前没有安装微信小助手，无需卸载"
  fi
}

omw_help() {
  echo \
'
omw (Oh My WeChat) 是微信小助手(https://github.com/MustangYM/WeChatExtension-ForMac)的安装/更新工具

用法:
  omw                 安装或更新到最新版本小助手
  omw -n              优先安装之前下载过的小助手，若没有才会通过网络下载最新版小助手并安装
  omw load <version>  将自行下载的某版本的小助手的安装包导入到 Oh My WeChat 里并安装，详情见说明
  omw open            开启开机自动安装微信小助手
  omw close           关闭开机自动安装微信小助手
  omw un              卸载 Oh My WeChat 或小助手. 你可以选择其中一个卸载，或者两个都卸载
  omw update          更新 Oh My WeChat 自身

说明:
  * 微信自动更新后会删除小助手, 你可以运行 `omw open` 开启开机自动安装小助手的功能。
    注意：刚开机时可能没有网络, 而且下载小助手可能会很慢, 所以建议先运行 `omw` 或 `omw load <cersion>`
    下载一次安装包，这样开机后会优先使用已有的安装包安装小助手，无需重新下载。
  * `omw load <version>` 使用方法:
    首先，在浏览器里打开小助手最新版本发布页：
       https://github.com/MustangYM/WeChatExtension-ForMac/releases/latest
    然后，点击 Source code (zip) 将安装包下载下来。
       若下载下来的版本是 v1.8.7，则下载文件夹内会有一个 WeChatExtension-ForMac-1.8.7.zip 安装包。
    最后，在终端运行此命令导入安装包： cd ~/Downloads && omw load 1.8.7
'
}

# 安装小助手
install() {
########################################################################################
#                         没有设置 -n 参数（默认）                  设置了 -n 参数
#  已安装小助手       查询最新版本，如果跟当前版本不一样，则更新             啥都不做
#  没有安装小助手                 判断有无本地安装包                   判断有无本地安装包
#
#  有本地安装包              查询最新版本，直接安装                   直接安装本地安装包
#  没有本地安装包            查询最新版本，直接安装                    查询最新版本，直接安装
#########################################################################################
  if [[ $1 == "-n" ]] && [[ -n ${current_version} ]]; then
    echo_with_date "已安装微信小助手且使用了 -n 参数，无需检查更新"
    return
  elif [[ $1 == "-n" ]] && [[ -n ${downloaded_version} ]]; then
    echo_with_date "未安装微信小助手，由于使用了 -n 参数，将直接安装已下载的版本 v${downloaded_version}"
    _version=${downloaded_version}
  else
    if [[ $1 == "-n" ]] && [[ -z ${downloaded_version} ]]; then
      echo_with_date "未安装微信小助手，也没有下载过安装包，所以即使使用了 -n 参数，仍需要检查并下载新版本"
    fi

    echo_with_date "将会从 GitHub 仓库检查更新及下载安装包，"
    echo_with_date "如果检查更新失败或下载速度很慢，建议使用 omw load 命令导入安装包，"
    echo_with_date "详情请参阅文档 https://github.com/lmk123/oh-my-wechat#omw-load"

    echo_with_date "正在查询新版本……"
    latest_version=$(get_latest_version)
    if [[ -z "$latest_version" ]]; then
      echo_with_date "查询新版本时失败，请稍后重试"
      exit 1
    else
      latest_version=${latest_version//$'\r'/}
      echo_with_date "微信小助手的最新版本为 v${latest_version}"
    fi
    _version=${latest_version}
  fi

  if [[ ${current_version} == ${_version} ]]; then
    echo_with_date "当前已经安装了最新版本的小助手，无需重新安装"
  else
    # 下载要安装的版本
    download ${_version}

    # 删除之前已经下载（一般是旧版本）的安装包
    if [[ ! -z ${downloaded_version} ]] && [[ ${_version} != ${downloaded_version} ]]; then
      rm -rf ./WeChatExtension-ForMac-${downloaded_version}
      echo_with_date "已删除 v${downloaded_version} 的安装包"
    fi

    echo_with_date "开始安装微信小助手……"
    ./WeChatExtension-ForMac-${_version}/WeChatExtension/Rely/Install.sh
    echo_with_date "微信小助手安装完成。"
    installed="1"
  fi
}

open_wechat() {
  if [[ -n "$installed" ]] && [[ ${is_wechat_running} != "0" ]]; then
    echo_with_date "检测到微信正在运行，请重启微信让小助手生效。"
  else
    echo_with_date "打开微信"
    open ${wechat_path}
  fi
}

# omw silent [-o]
if [[ $1 == "silent" ]]; then
  install -n
  # 判断是否要自动打开微信
  if [[ $2 == "-o" ]]; then
    open_wechat
  fi
  exit 0
fi

# omw open
if [[ $1 == "open" ]]; then
  open_auto_start
  exit 0
fi

# omw close
if [[ $1 == "close" ]]; then
  close_auto_start
  exit 0
fi

# omw load [version]
if [[ $1 == "load" ]]; then
  _file_name="WeChatExtension-ForMac-${2}.zip"
  _file_path="${initial_pwd}/${_file_name}"
  if [[ -e ${_file_path} ]]; then
    # 解压到工作目录下
    unzip -o -q ${_file_path}
    echo_with_date "成功导入微信小助手 v${2} 的安装包"

    # 删除已有的安装包
    if [[ ! -z ${downloaded_version} ]] && [[ ${2} != ${downloaded_version} ]]; then
      rm -rf "./WeChatExtension-ForMac-${downloaded_version}"
      echo_with_date "已删除 v${downloaded_version} 的安装包"
    fi
  else
    echo_with_date "文件 ${_file_name} 不存在"
  fi
  exit 0
fi

# omw un
if [[ $1 == "un" ]]; then
  options=("微信小助手" "Oh My WeChat" "两个都卸载" "取消")
  echo_with_date "你想卸载哪一个？"
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
        echo_with_date "无效的选择"
        ;;
      esac
  done
  exit 0
fi

# omw update
if [[ $1 == "update" ]]; then
  echo_with_date "正在检查 Oh My WeChat 是否有更新..."
  omw_latest_version=$(get_omw_latest_version_from_github)
  if [[ -z "$omw_latest_version" ]]; then
    echo_with_date "查询 Oh My WeChat 新版本时失败，请稍后重试"
    exit 1
  else
    omw_latest_version=${omw_latest_version//$'\r'/}
    echo_with_date "Oh My WeChat 的最新版本为 v${omw_latest_version}"
  fi
  _omw_version=${omw_latest_version}

  if [[ ${omw_version} == ${_omw_version} ]]; then
    echo_with_date "当前已经安装了最新版本的 Oh My WeChat，无需重新安装"
  else
    omw_str="omw"
    omw_work_dir="${HOME}/.oh_my_wechat"
    omw_bin_file="${omw_work_dir}/${omw_str}"
    # 下载要安装的版本
    echo_with_date "开始下载 Oh My WeChat..."
    curl --retry 2 -o ${omw_bin_file} https://omw.limingkai.cn/main.sh &> /dev/null

    if [[ 0 -eq $? ]]; then
      # 给 omw 添加执行权限
      chmod 755 ${omw_bin_file}
      echo_with_date "Oh My Wechat 更新完成。"
    else
      echo_with_date "下载更新时失败，请稍后重试。"
      exit 1
    fi
  fi
  exit 0
fi

if [[ $# -eq 0 ]] || [[ $# -eq 1 && $1 == "-n" ]]; then
  install ${has_n}
  ask_for_auto_start
  open_wechat
  exit 0
fi

# if [[ $1 == "help" ]] || [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
omw_help
# fi

