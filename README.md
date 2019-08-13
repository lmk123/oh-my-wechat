# Oh My WeChat

这是为 [MustangYM/WeChatExtension-ForMac](https://github.com/MustangYM/WeChatExtension-ForMac)（后面称呼为“小助手”）开发的安装/更新工具。

## 安装 Oh My WeChat

在终端中运行 `curl -o- -L https://raw.githubusercontent.com/lmk123/oh-my-wechat/master/install.sh | bash -s` 即可。

Oh My WeChat 自身没有自动更新的功能，不过你可以关注本项目（选择 Releases Only），这样在发布新版本时你能得到通知，然后你可以重新运行这条命令将 Oh My WeChat 更新到最新版本。

## 使用 Oh My WeChat

Oh My WeChat 支持下面几条命令：

### `omw`

这条命令会自动安装小助手，当小助手提示你有新版本时也可以运行这个命令更新小助手。

运行 `omw` 会执行以下操作：

1. 检查小助手有没有新版本，有则下载最新版本安装包并安装
2. 检测微信有没有安装小助手，没有则安装
3. 最后，打开微信

你还可以运行 `omw -n`，这样会跳过上面检查更新的步骤，优先使用下载过的安装包安装小助手。

如果下载安装包很慢，你可以使用 `omw load` 命令（后面有介绍）导入安装包，或者尝试用自己的梯子来下载：

```bash
# 这里假设你的梯子在你电脑的 1087 端口开了个 HTTP 代理
$ export http_proxy=http://127.0.0.1:1087
$ omw
```

### `omw load`

用 omw 从 GitHub 上下载安装包可能会非常慢，所以 Oh My WeChat 还提供了这条命令，可以直接将小助手的安装包导入到 Oh My WeChat 里。

你可以用浏览器打开[小助手的最新版本发布页](https://github.com/MustangYM/WeChatExtension-ForMac/releases/latest)，然后点击 _Source code (zip)_ 将安装包下载下来。假设现在最新版本是 v1.8.7，那么此时你的*下载文件夹*内会有一个 _WeChatExtension-ForMac-1.8.7.zip_ 安装包，接下来，你可以在终端内运行下面这条命令导入安装包：

```bash
$ cd ~/Downloads && omw load 1.8.7
```

如果你下载的安装包不在*下载文件夹*中，而且你不知道命令怎么写，那么你可以先将安装包移动到*下载文件夹*中，然后运行上面的命令。 

### `omw open` 和 `omw close`

微信在自动更新后会删除小助手，为了避免这一情况，你可以运行 `omw open` 开启开机自动安装小助手的功能（即在开机后自动运行一次 `omw -n`）。

运行 `omw close` 可以关闭开机自启动。

**注意：由于刚开机时可能没有网络，且下载小助手的过程可能会很漫长，所以建议提前运行 `omw` 通过网络下载小助手、或者使用 `omw load` 命令导入小助手的安装包，这样开机后会直接用本地安装包安装小助手，无需从网络下载。**

### `omw un`

卸载 Oh My WeChat 或小助手。你可以选择其中一个卸载，或者两个都卸载。

## 运行截图

### 未安装小助手时运行 `omw`

<img width="569" alt="未安装小助手时运行 omw" src="https://user-images.githubusercontent.com/5035625/53577905-746c1000-3bb1-11e9-973c-a8ecccffe7f8.png">

### 未安装小助手且下载过安装包时运行 `omw -n`

<img width="569" alt="未安装小助手且下载过安装包时运行 omw -n" src="https://user-images.githubusercontent.com/5035625/53577938-851c8600-3bb1-11e9-88f6-b3869aa827a4.png">

### 运行 `omw un`

<img width="403" alt="运行 omw un" src="https://user-images.githubusercontent.com/5035625/53577962-96659280-3bb1-11e9-80f0-331634e36cda.png">

## 许可

MIT
