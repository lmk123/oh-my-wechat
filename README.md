# Oh My WeChat

这是为 [TKkk-iOSer/WeChatPlugin-MacOS](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS)（后面称呼为“小助手”）开发的安装/更新工具。

## 如何使用

### 安装 Oh My WeChat

在终端中运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/install.sh | bash -s` 即可。

Oh My WeChat 自身没有自动更新的功能，不过你可以关注本项目（选择 Releases Only），这样在发布新版本时你能得到通知，然后你可以重新运行这条命令将 Oh My WeChat 更新到最新版本。

### 运行 Oh My WeChat

运行 `omw` 会执行以下操作：

1. 检查小助手有没有新版本，有则下载最新版本安装包并安装
2. 检测微信有没有安装小助手，没有则安装
3. 最后，打开微信

当小助手提示你有新版本时可以运行这个命令更新小助手。

你还可以运行 `omw -n`，这样会跳过上面检查更新的步骤，优先使用下载过的安装包安装小助手。

微信自动更新时会卸载小助手，但一般情况下，我们可能只会在看到一条撤回的消息时才发现小助手被卸载了。如果你不希望漏掉任何一条撤回的消息，你可以始终通过运行 `omw -n` 启动微信。

你也可以用 macOS 自带的“自动操作”应用，将 omw 包装成一个 APP，并将这个 APP 添加在你的登录项中，这样在你登录后就能自动运行 omw 打开微信了。

具体步骤如下：

1. 打开“自动操作”，选择“应用程序”
2. 在搜索框中搜索“shell”，双击“运行 Shell 脚本”
3. 在右侧显示的输入框中输入 `/usr/local/bin/omw -n`。你也可以不带 -n 参数，但我建议带上，这样每次启动会快一些
4. 使用快捷键“⌘ + S”，将这个 APP 命名为“自动运行omw”，并保存在“应用程序”文件夹
5. 打开“系统偏好设置”——“用户与群组”——“登录项”，点击下方的加号按钮，在应用程序文件夹中添加刚才生成的“自动运行omw.app”

至此所有步骤就完成了，以后每当你登录后，omw 都会自动运行。

### 卸载 Oh My WeChat 或微信小助手

运行 `omw un` 即可。

## TODO List

- [ ] 添加开机自启动的功能，避免用户通过上面的繁琐步骤达到开机启动的目的
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
