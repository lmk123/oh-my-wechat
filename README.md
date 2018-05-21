# Oh My WeChat

一个通过终端打开微信并在打开前自动安装/更新[微信小助手](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS)的命令行工具。

## Why?

微信每次自动更新后都需要重新安装一遍微信小助手，所以我开发了这个命令行工具用于自动安装/更新微信小助手并打开微信。

## 如何使用

### 安装

在终端中运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/install.sh | bash -s` 即可。

### 运行

安装完成后，你可以运行 `omw` 自动安装/更新微信小助手并打开微信；你也可以运行 `omw -n` 跳过检查更新的步骤，这样会安装已缓存的当前版本，无需重新通过网络下载。

### 卸载

运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/uninstall.sh | bash -s` 即可。

## 运行截图

![运行截图](https://user-images.githubusercontent.com/5035625/35378753-d7c202f2-01ee-11e8-8b71-afe38e8cda56.png)

## 许可

MIT
