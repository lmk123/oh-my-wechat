# Oh My WeChat

在使用[微信小助手](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS)（一款运行在 macOS 上，给微信提供消息防撤回、自动回复等功能的插件）时，我遇到了几个问题：

1. 微信每次自动更新后都会删除已经安装的微信小助手，并且直到我看到一条被撤回的消息才意识到微信自动更新了
2. 每次安装小助手都需要去文档上复制命令，安装完成后还需要自行将安装包删除，比较繁琐

因此，我开发了这个命令行工具，只需运行 `omw`，它就会自动安装/更新微信小助手并打开微信，这确保每次打开微信后小助手都是安装好了的，不会让我们错过任何一条被撤回的消息；另外，它会保存微信小助手的安装包，在小助手没有新版本时会直接使用保存的安装包重新安装，无需再次通过网络下载；在小助手更新后，旧版的安装包会自动删除。

## 如何使用

### 安装

在终端中运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/install.sh | bash -s` 即可。

你可以关注本项目，当我更新代码后你会得到通知，然后你可以重新运行这条命令将 Oh My WeChat 更新到最新版本。

### 运行

安装完成后，你可以运行 `omw` 自动安装/更新微信小助手并打开微信；你也可以运行 `omw -n` 跳过检查更新的步骤。

### 卸载

运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/uninstall.sh | bash -s` 即可。

## 运行截图

![第一次运行](https://user-images.githubusercontent.com/5035625/40317415-fe3b55b2-5d53-11e8-8649-cf50fb4d4fef.png)
![第二次运行](https://user-images.githubusercontent.com/5035625/40317468-28c083a2-5d54-11e8-8c78-640f1e4e42a5.png)

## 许可

MIT
