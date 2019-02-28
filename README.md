# Oh My WeChat

这是为 [TKkk-iOSer/WeChatPlugin-MacOS](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS)（后面称呼为“小助手”）开发的安装/更新工具。

## 如何使用

### 安装 Oh My WeChat

在终端中运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/install.sh | bash -s` 即可。

关注本项目之后，在代码更新时你能得到通知，然后你可以重新运行这条命令将 Oh My WeChat 更新到最新版本。

### 运行 Oh My WeChat

运行 `omw` 会执行以下操作：

1. 检查小助手有没有新版本，有则下载最新版本安装包并安装
2. 检测微信有没有安装小助手，没有则安装
3. 最后，打开微信

你还可以运行 `omw -n`，这样会跳过上面检查更新的步骤，优先使用下载过的安装包安装小助手。

微信自动更新时会卸载小助手，但一般情况下，我们可能只会在看到一条撤回的消息时才发现小助手被卸载了。如果你不希望漏掉任何一条撤回的消息，你可以始终通过运行 `omw` （或 `omw -n`）启动微信。

你也可以按照下面的步骤，在登录后自动运行 omw：

TODO: 提供登陆后自动执行 omw 的方法

### 卸载 Oh My WeChat 或微信小助手

运行 `omw un` 即可。

## 运行截图

![第一次运行](https://user-images.githubusercontent.com/5035625/40317415-fe3b55b2-5d53-11e8-8649-cf50fb4d4fef.png)
![第二次运行](https://user-images.githubusercontent.com/5035625/40317468-28c083a2-5d54-11e8-8c78-640f1e4e42a5.png)

## 许可

MIT
