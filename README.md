# Oh My WeChat

这是为 [TKkk-iOSer/WeChatPlugin-MacOS](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS)（后面称呼为“小助手”）开发的安装/更新工具。

## 安装 Oh My WeChat

在终端中运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/install.sh | bash -s` 即可。

Oh My WeChat 自身没有自动更新的功能，不过你可以关注本项目（选择 Releases Only），这样在发布新版本时你能得到通知，然后你可以重新运行这条命令将 Oh My WeChat 更新到最新版本。

## 使用 Oh My WeChat

Oh My WeChat 支持下面几条命令：

### `omw`

运行 `omw` 会执行以下操作：

1. 检查小助手有没有新版本，有则下载最新版本安装包并安装
2. 检测微信有没有安装小助手，没有则安装
3. 最后，打开微信

当小助手提示你有新版本时可以运行这个命令更新小助手。

你还可以运行 `omw -n`，这样会跳过上面检查更新的步骤，优先使用下载过的安装包安装小助手。

### `omw open` 和 `omw close`

运行 `omw open` 可以开启开机自启动的功能，开启后，在你开机登录后会自动运行 `omw -n`。这个功能可以有效解决微信自动更新后卸载了小助手的问题。

运行 `omw close` 即可关闭开机自启动。

### `omw un`

卸载 Oh My WeChat 或小助手。你可以选择其中一个卸载，或者两个都卸载。

## TODO List

- [ ] 部分地区从 GitHub 上下载安装包的速度非常慢，提供一个通过压缩包安装小助手的方法
- [ ] 给 Oh My WeChat 自身添加检查更新的功能

## 运行截图

### 未安装小助手时运行 `omw`

<img width="569" alt="未安装小助手时运行 omw" src="https://user-images.githubusercontent.com/5035625/53577905-746c1000-3bb1-11e9-973c-a8ecccffe7f8.png">

### 未安装小助手且下载过安装包时运行 `omw -n`

<img width="569" alt="未安装小助手且下载过安装包时运行 omw -n" src="https://user-images.githubusercontent.com/5035625/53577938-851c8600-3bb1-11e9-88f6-b3869aa827a4.png">

### 运行 `omw un`

<img width="403" alt="运行 omw un" src="https://user-images.githubusercontent.com/5035625/53577962-96659280-3bb1-11e9-80f0-331634e36cda.png">

## 许可

MIT
