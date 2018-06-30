#!/bin/bash
omw_path=/usr/local/bin/omw
if [ ! -w /usr/local/bin ]; then
  echo 为了安装 Oh My WeChat，请输入密码 ：
  sudo chown $(whoami) /usr/local/bin
fi
echo 开始下载 Oh My WeChat...
curl -o $omw_path https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/main.sh
if [ 0 -eq $? ]; then
  chmod 755 $omw_path
  echo 成功安装 oh-my-wechat，现在可以运行 omw 打开微信了
else
  echo 下载 Oh My WeChat 时失败，请稍后重试。
  exit 1
fi
