# Oh My WeChat

微信每次自动更新后都会导致已经安装的[微信小助手](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS)被删除，但可能直到我们看到一条被撤回的消息才意识到微信自动更新了；另外，每次安装时都去微信小助手的文档里里复制一遍安装命令比较繁琐。

基于以上的原因，我开发了这个命令行工具，只需运行 `omw`，它就会自动安装/更新微信小助手并打开微信，这确保每次打开微信后小助手都是安装好了的，不会让我们错过任何一条被撤回的消息；另外，它会保存微信小助手的安装包，在小助手没有更新时可以直接使用保存的安装包重新安装，无需通过网络下载；在小助手更新后，旧版的安装包会自动删除。

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
