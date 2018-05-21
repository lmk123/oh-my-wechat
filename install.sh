#!/bin/bash
omw_path=/usr/local/bin/omw
curl -o $omw_path https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/main.sh
chmod 755 $omw_path
echo 成功安装 oh-my-wechat，现在可以运行 omw 打开微信了
