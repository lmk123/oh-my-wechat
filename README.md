# Oh My WeChat

这是为 [TKkk-iOSer/WeChatPlugin-MacOS](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS)（后面称呼为“小助手”）开发的安装/更新工具。

## 如何使用

### 安装 Oh My WeChat

在终端中运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/install.sh | bash -s` 即可。

### 运行 Oh My WeChat

在成功安装 Oh My WeChat 后，运行 `omw` 就会安装小助手，之后就无需再运行了。

当小助手提示你有新版本的时候，你可以再次运行 `omw` 将微信小助手更新到新版本。

当微信自动更新导致小助手被删除时，你可以运行 `omw -n` 重新安装小助手，此时会直接使用上次下载的小助手安装包安装，无需重新下载；一般情况下，我们可能只会在看到一条撤回的消息时才发现小助手被删除了，如果你不希望漏掉任何一条撤回的消息，你可以始终通过运行 `omw` 启动微信，Oh My WeChat 一旦检测到小助手不存在就会重新安装。

### 卸载 Oh My WeChat

运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/uninstall.sh | bash -s` 即可。

## 运行截图

![第一次运行](https://user-images.githubusercontent.com/5035625/40317415-fe3b55b2-5d53-11e8-8649-cf50fb4d4fef.png)
![第二次运行](https://user-images.githubusercontent.com/5035625/40317468-28c083a2-5d54-11e8-8c78-640f1e4e42a5.png)

## 许可

MIT
