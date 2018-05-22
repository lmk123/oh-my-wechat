# Oh My WeChat

微信每次自动更新后都需要重新安装一遍[微信小助手](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS)，所以我开发了这个命令行工具用于自动安装/更新微信小助手并打开微信。

## 如何使用

### 安装

在终端中运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/install.sh | bash -s` 即可。

### 运行

安装完成后，你可以运行 `omw` 自动安装/更新微信小助手并打开微信；你也可以运行 `omw -n` 跳过检查更新的步骤，这样会安装已缓存的当前版本，无需重新通过网络下载。

### 卸载

运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/uninstall.sh | bash -s` 即可。

## 运行截图

![第一次运行](https://user-images.githubusercontent.com/5035625/40317415-fe3b55b2-5d53-11e8-8649-cf50fb4d4fef.png)
![第二次运行](https://user-images.githubusercontent.com/5035625/40317468-28c083a2-5d54-11e8-8c78-640f1e4e42a5.png)

## 许可

MIT
