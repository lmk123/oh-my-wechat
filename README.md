# Oh My WeChat

一个通过终端打开微信并在打开前自动安装[微信防撤回插件](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS)的命令行工具。

## 如何使用

### 安装

在终端中运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/install.sh | bash -s` 即可。

### 运行

安装完成后，在终端中运行 `owm` 即可打开微信，脚本会检测微信目前有没有安装防撤回插件，如果没有会自动下载安装。

### 卸载

运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/uninstall.sh | bash -s` 即可。

## 运行截图

## Why?

微信自动更新会导致安装过的防撤回插件需要重新安装，所以写了这么一段脚本能在打开微信前自动检测并安装防撤回插件。

## 许可

MIT
