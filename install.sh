#!/bin/bash
omw_path=/usr/local/bin/omw
echo 开始下载 Oh My WeChat...
curl -o $omw_path https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/main.sh
if [ 0 -eq $? ]; then
  chmod 755 $omw_path
  echo 成功安装 oh-my-wechat，现在可以运行 omw 打开微信了
else
  echo 下载 Oh My WeChat 时失败，请稍后重试。
  exit 1
fi
