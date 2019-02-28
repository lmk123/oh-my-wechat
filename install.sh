#!/usr/bin/env bash

omw_str="omw"
bin_dir="/usr/local/bin"
soft_link_file="${bin_dir}/${omw_str}"
omw_work_dir="${HOME}/.oh_my_wechat"
omw_bin_file="${omw_work_dir}/${omw_str}"

# 请求 bin 目录的写入权限
if [[ ! -w ${bin_dir} ]]; then
  echo "为了安装 Oh My WeChat，请输入密码 ："
  sudo chown $(whoami) ${bin_dir}
fi

# 工作目录
work_dir="${HOME}/.oh_my_wechat"

# 创建工作目录
if [[ ! -e ${work_dir} ]]; then
  mkdir ${work_dir}
fi

echo "开始下载 Oh My WeChat..."
curl --retry 2 -o ${omw_bin_file} https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/main.sh

if [[ 0 -eq $? ]]; then
  # 给 omw 添加执行权限
  chmod 755 ${omw_bin_file}
  # 创建一个到 /usr/local/bin/omw 的软链
  ln -sf ${omw_bin_file} ${soft_link_file}
  echo "成功安装 oh-my-wechat，现在可以运行 ${omw_str} 打开微信了"
else
  echo "下载 Oh My WeChat 时失败，请稍后重试。"
  exit 1
fi
