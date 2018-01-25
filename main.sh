#!/bin/bash
app_name="WeChat"
wechat_path="/Applications/${app_name}.app"
app_bundle_path="/Applications/${app_name}.app/Contents/MacOS"
app_executable_path="${app_bundle_path}/${app_name}"
app_executable_backup_path="${app_executable_path}_backup"
plugin_dir="WeChatPlugin-MacOS-master"

if [ ! -f "$app_executable_backup_path" ]
then
  cd $TMPDIR
  if [ ! -f "$plugin_dir" ]
  then
    echo "开始下载防撤回插件……"
    curl -L -o ${plugin_dir}.zip https://github.com/TKkk-iOSer/WeChatPlugin-MacOS/archive/master.zip
    unzip -o -q ${plugin_dir}.zip
    rm ${plugin_dir}.zip
    echo "下载完成"
  fi
  echo "开始安装防撤回插件"
  ./${plugin_dir}/Other/Install.sh
  echo "防撤回插件安装完成"
fi

echo "打开微信"
open $wechat_path
