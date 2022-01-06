# Vapor实战项目

<!-- TOC -->

- [Vapor实战项目](#vapor%E5%AE%9E%E6%88%98%E9%A1%B9%E7%9B%AE)
- [项目模仿参考](#%E9%A1%B9%E7%9B%AE%E6%A8%A1%E4%BB%BF%E5%8F%82%E8%80%83)
- [项目规划](#%E9%A1%B9%E7%9B%AE%E8%A7%84%E5%88%92)
- [分支管理](#%E5%88%86%E6%94%AF%E7%AE%A1%E7%90%86)
- [表设计](#%E8%A1%A8%E8%AE%BE%E8%AE%A1)
- [自定义工作目录](#%E8%87%AA%E5%AE%9A%E4%B9%89%E5%B7%A5%E4%BD%9C%E7%9B%AE%E5%BD%95)
- [路由](#%E8%B7%AF%E7%94%B1)
- [数据库](#%E6%95%B0%E6%8D%AE%E5%BA%93)
- [认证](#%E8%AE%A4%E8%AF%81)
- [Heroku 部署](#heroku-%E9%83%A8%E7%BD%B2)
    - [注册 Heroku 账户](#%E6%B3%A8%E5%86%8C-heroku-%E8%B4%A6%E6%88%B7)
    - [通过 cli 方式进行 heroku 部署](#%E9%80%9A%E8%BF%87-cli-%E6%96%B9%E5%BC%8F%E8%BF%9B%E8%A1%8C-heroku-%E9%83%A8%E7%BD%B2)
        - [安装 cli](#%E5%AE%89%E8%A3%85-cli)
        - [登录](#%E7%99%BB%E5%BD%95)
        - [创建一个应用程序](#%E5%88%9B%E5%BB%BA%E4%B8%80%E4%B8%AA%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F)
        - [与 Heroku 连接](#%E4%B8%8E-heroku-%E8%BF%9E%E6%8E%A5)
        - [设置 Buildpack](#%E8%AE%BE%E7%BD%AE-buildpack)
        - [Swift 版本文件](#swift-%E7%89%88%E6%9C%AC%E6%96%87%E4%BB%B6)
        - [Procfile](#procfile)
        - [部署到 Heroku](#%E9%83%A8%E7%BD%B2%E5%88%B0-heroku)
        - [Scale Up](#scale-up)
        - [持续部署](#%E6%8C%81%E7%BB%AD%E9%83%A8%E7%BD%B2)
    - [在 heroku 控制台进行部署](#%E5%9C%A8-heroku-%E6%8E%A7%E5%88%B6%E5%8F%B0%E8%BF%9B%E8%A1%8C%E9%83%A8%E7%BD%B2)
    - [heroku 中 Postgres 的配置](#heroku-%E4%B8%AD-postgres-%E7%9A%84%E9%85%8D%E7%BD%AE)
        - [添加 PostgreSQL 数据库](#%E6%B7%BB%E5%8A%A0-postgresql-%E6%95%B0%E6%8D%AE%E5%BA%93)
        - [配置数据库](#%E9%85%8D%E7%BD%AE%E6%95%B0%E6%8D%AE%E5%BA%93)
        - [还原数据库](#%E8%BF%98%E5%8E%9F%E6%95%B0%E6%8D%AE%E5%BA%93)
- [其他](#%E5%85%B6%E4%BB%96)
- [Ubuntu 20.04](#ubuntu-2004)
- [Leaf 的使用](#leaf-%E7%9A%84%E4%BD%BF%E7%94%A8)
- [配置远程 vscode remote](#%E9%85%8D%E7%BD%AE%E8%BF%9C%E7%A8%8B-vscode-remote)
- [配置 VSCode，编写 Swift 代码更舒心](#%E9%85%8D%E7%BD%AE-vscode%E7%BC%96%E5%86%99-swift-%E4%BB%A3%E7%A0%81%E6%9B%B4%E8%88%92%E5%BF%83)

<!-- /TOC -->

# 项目模仿参考

* [https://www.xiaoduyu.com/](https://www.xiaoduyu.com/) 
* [源码](https://github.com/54sword/api.xiaoduyu.com)

# 项目规划

| 项目 | 源码 |
|-----|------|
| web网站 | [https://github.com/swiftdo/web-team-boke.git](https://github.com/swiftdo/web-team-boke.git)|
| App（iOS\Android）| [https://github.com/swiftdo/app-team-boke.git](https://github.com/swiftdo/app-team-boke.git) |
| 后端API | [https://github.com/swiftdo/team-boke.git](https://github.com/swiftdo/team-boke.git)|
| 后台管理 |[https://github.com/swiftdo/admin-team-boke.git](https://github.com/swiftdo/admin-team-boke.git) |


# 分支管理

* main 是稳定分支
* dev 是开发分支

main 的改动会触发项目的自动部署，无需人工改动


# 表设计

* users 用户
    * id
    * name
    * email
    * is_email_verified 邮箱是否验证
    * avatar 头像
    * role_id 角色id 
    * created_at
    * updated_at
    * `last_sign_at`:Date 最近一次登录
    * blocked:Bool 是否屏蔽用户 
    * banned_to_post: Date  禁言，在该时间前不能发布言论
    * gender: enum 性别 0女, 1男, 2 其他， 可以设计为枚举
    * brief：String 简介,一句话介绍自己，70个字符限制
    * source: 用户注册来源, 0->iPhone, 1->iPad, 2->Android, 3->H5, 4->网站, 5->iOS
    * posts_count：int 帖子累积
    * comment_count：int 评论累积
    * fans_count: int 粉丝累积
    * like_countL: int 获取赞累积
    * follow_people_count: 用户关注人累积  - follow_peoples
    * follow_posts_count: 关注的话题累积 -- follow_posts
    * block_people_count: 屏蔽人的数量  -- block_peoples
    * find_notification_at: Date 最近一次查询Notification的日期
    

* user_auths 用户认证账号 
    * id
    * user_id
    * auth_type  类型 email, wxapp
    * identifier 标志 (手机号，邮箱，用户名或第三方应用的唯一标识)
    * credential 码凭证(站内的保存密码， 站外的不保存或保存 token)
    * created_at
    * updated_at

* role 角色
    * id 
    * name
    
* roles_permissions 关系表
    * id
    * role_id 
    * permission_id

* permissions 权限
    * id 
    * name
    
* access_tokens 
    * id 
    * token
    * user_id
    * expires_at


* notifications（通知）
    * id 
    * sender_id
    * addressee_id
    * target
    * type
    * deleted: bool
    * created_at

* user_notifications
    * id 
    * type https://github.com/54sword/api.xiaoduyu.com/blob/master/src/schemas/user-notification.ts
    * send_id
    * addressee_id
    * posts_id
    * comment_id
    * has_read: Bool
    * deleted: Bool
    * created_at

* message: 
    * id 
    * user_id
    * addressee_id
    * type 1. 普通消息 2系统消息
    * content: 内容
    * content_html 
    * created_at 
    * device
    * ip
    * has_read
    * blocked 是否被屏蔽
    * deleted: 是否删除


* topics 话题
    * id
    * user_id
    * parent_id 父
    * name  名称
    * brief 摘要
    * desc 详情
    * avator 节点图标
    * background 背景图
    * follow_count 关注总数
    * post_count  提问累积
    * comment_count 评论总数
    * sort 排序
    * created_at
    * language: 语言
    * recommend: 是否推荐
    * last_posts_at: 最近发帖的日期
    * children: 与子的关系

* reports 举报
    * id
    * user_id
    * post_id 
    * comment_id
    * people_id
    * detail
    * created_at
    
* posts 帖子
    * id
    * user_id
    * topic_id
    * type: 0 提问 1 分享
    * title: 标题
    * content: 内容
    * content_html 内容转化后的html 格式
    * created_at
    * updated_at
    * last_comment_at
    * comment: 关系，评论
    * comment_count: 评论数
    * replay_count: 回复
    * view_count: 浏览数
    * follow_count: 关注
    * like_count: 点赞数
    * device: 设备
    * ip 
    * deleted_at
    * verify: 是否是审核
    * recommend: 是否推荐
    * weaken: 削弱，将不再出现在首页

* blocks 屏蔽
    * user_id 
    * post_id
    * comment_id
    * people_id
    * deleted_at
    * created_at
    * ip

* comments
    * user_id 
    * post_id
    * parent_id
    * reply_id
    * content
    * content_html
    * created_at
    * updated_at
    * last_reply_at
    * reply_count
    * reply 
    * like_count
    * device
    * ip
    * blocked: bool
    * deleted: bool
    * verify: 内容校验是否成功
    * weaken: 削弱
    * recommend: 推荐

* like
    * user_id
    * type
    * target_id
    * mood 0 赞 1 喜欢
    * deleted: bool
    * created_at

* follow 
    * user_id
    * post_id
    * topic_id
    * people_id
    * deleted
    * created_at

* feeds 动态流
    * user_id
    * topic_id
    * post_id
    * comment_id
    * deleted
    * created_at

# 自定义工作目录

![](https://docs.vapor.codes/4.0/images/xcode-scheme-options.png)

如果是 xcode 运行，需要设置为当前项目根目录

# 路由

# 数据库

1; 安装

```sh
$ brew install postgresql

$ brew link postgresql
```

2; 启动

```sh
$ brew services start postgresql
```

3; 关闭

```sh
$ brew services stop postgresql
```

4; 创建一个 PostgreSQL 用户

```sh
$ createuser username -P
#Enter password for new role
#Enter it again
```

上面的`username`是用户名，回车输入 2 次用户密码后即用户创建完成。更多用户创建信息可以`createuser –help`查看。

5; 创建数据库

```sh
$ createdb dbname -O username -E UTF8 -e
```

上面创建了一个名为`dbname`的数据库，
并指定`username`为改数据库的拥有者（owner），
数据库的编码（encoding）是 UTF8，
参数 `-e` 是指把数据库执行操作的命令显示出来。

6; 删除数据库

```sh
dropdb -h localhost -p 5432 -U username dbname
```

-e：显示`dropdb`生成的命令并发送到数据库服务器。
-h host：指定运行服务器的主机名。
-p port：指定服务器监听的端口，或者 socket 文件。
-U username：连接数据库的用户名。

`dbname`要删除的数据库名

本项目中运行的方式是：

```sh
createuser vapor -P
createdb blog -O vapor -E UTF8 -e
```

**注意**

1. 更改数据库后，需要写迁移代码，完成后记得执行 `vapor run migrate`
2. 模型间有依赖关系，注意迁移类的调用顺序

# 认证

1. 用户+密码换取 access_token 和 refresh_token
2. 通过 access_token 校验，判断是否登录
3. 如果 access_token 过期，通过 refresh_token 重新生成 access_token
4. 如果 access_token 过期，那么需要用户重新登录

# Heroku 部署

[Heroku](https://www.heroku.com/) 平台的灵活性极高且支持多种编程语言。若想把程序部署到 Heroku 上，开发者可以直接使用 Git 把程序推送到 Heroku 的 Git 服务器上。在服务器上, git push 命令会自动触发安装、配置和部署程序。

## 注册 Heroku 账户

您将需要一个 heroku 帐户，如果您没有，请在此处注册：[https://signup.heroku.com/](https://signup.heroku.com/)

## 通过 cli 方式进行 heroku 部署

### 安装 cli

确保已安装 heroku cli 工具。

- HomeBrew

  ```sh
  brew install heroku/brew/heroku
  ```

- 其他安装选项
  在此处查看替代安装选项：[https://devcenter.heroku.com/articles/heroku-cli#download-and-install](https://devcenter.heroku.com/articles/heroku-cli#download-and-install).

### 登录

安装 cli 后，请输入以下内容：

```sh
$ heroku login
```

用以下命令来验证邮箱是否登录：

```sh
$ heroku auth:whoami
```

### 创建一个应用程序

访问 [dashboard.heroku.com](https://dashboard.heroku.com)，登录您的帐户，并从右上角的下拉列表中创建一个新应用程序。按照 Heroku 提供的提示进行操作即可。

### 与 Heroku 连接

将您的应用程序与 heroku 连接（your-apps-name-here 替换为您的应用程序名称）

```sh
$ heroku git:remote -a your-apps-name-here
```

### 设置 Buildpack

设置 buildpack 告诉 heroku 如何处理这个 vapor 项目。

```sh
$ heroku buildpacks:set vapor/vapor
```

### Swift 版本文件

buildpack 会寻找一个.swift-version 文件，获知使用的 swift 版本。 （可根据自己的项目来替换下面的 5.2.1）

```sh
echo "5.2.1" > .swift-version
```

这将创建 `.swift-version` 文件，内容为 5.2.1。

### Procfile

Heroku 使用 Procfile 知道如何运行您的应用程序，我们可以使用下面：

```sh
web: Run serve --env production --hostname 0.0.0.0 --port $PORT
```

可以使用以下终端命令进行创建:

```sh
echo "web: Run serve --env production" \
  "--hostname 0.0.0.0 --port \$PORT" > Procfile
```

### 部署到 Heroku

您已经准备好部署，可以在终端上运行它。构建可能需要一段时间。

```sh
$ git push heroku main
```

### Scale Up

成功构建之后，您需要添加至少一台服务器，一台网络是免费的，您可以通过以下方式获得它：

```sh
heroku ps:scale web=1
```

### 持续部署

每当您想更新时，只需将最新的更改放入 main 并推送到 heroku，它将重新部署。


## 在 heroku 控制台进行部署

除了以上的方式，其实直接在 heroku 控制台操作即可，相对来说会简单好多：

项目同样需要配置 `Swift 版本文件` 和 `Procfile`, 这两部跟 cli 操作一样，然后将修改提交到 github 上。

在 heroku 创建应用后，可在做如下图的配置：


![](http://mmbiz.qpic.cn/mmbiz_png/3wD9LKPpvOUoeQH5iajQhnoq1jiaYMYBkeCVWbuu3EL7KUgxeLbaupCsOiaL0BnEEiaiaoVQzSQomyUFE8YEoOLibibmw/0?wx_fmt=png)

我们配置了与 github 仓库的关联，且配置了，在 main 分支的有提交的时候，自动进行部署，无需人工操作。

然后还需配置 `buildpacks`:


![](http://mmbiz.qpic.cn/mmbiz_png/3wD9LKPpvOUoeQH5iajQhnoq1jiaYMYBkeLOGpLRntvjKjakSRQicwLy8PUp54mgicPTFcDtR5mI1u4TVUmt3UNGpw/0?wx_fmt=png)

点击添加 `add buildpack`, 将url(https://github.com/vapor-community/heroku-buildpack)填入即可：

![](http://mmbiz.qpic.cn/mmbiz_png/3wD9LKPpvOUoeQH5iajQhnoq1jiaYMYBkeeAurXxrLqmb7Ys63gc7bt6ZMR2013wFJtrevB37icx8tst40YpUDLicg/0?wx_fmt=png)


## heroku 中 Postgres 的配置

### 添加 PostgreSQL 数据库

在 [dashboard.heroku.com](https://dashboard.heroku.com) 访问您的应用程序，然后转到 `Add-ons` 部分。

从这里输入 `postgres`，您将看到`Heroku Postgres`的选项，选择它。

选择`hobby dev free plan`，并进行配置。 剩下的事由 Heroku 完成。

完成后，您将看到数据库显示在 `Resources` 选项卡下。

### 配置数据库

现在，我们必须告诉我们的应用程序如何访问数据库。在项目的根目录中，运行以下命令：

```sh
$ heroku config
```

这将会有如下输出：

```sh
=== today-i-learned-vapor Config Vars
DATABASE_URL: postgres://cybntsgadydqzm:2d9dc7f6d964f4750da1518ad71hag2ba729cd4527d4a18c70e024b11cfa8f4b@ec2-54-221-192-231.compute-1.amazonaws.com:5432/dfr89mvoo550b4
```

`DATABASE_URL` 此处将代表 postgres 数据库。不要将这个 URL 写入到你的代码中，这也是一个坏习惯。

下面是一个数据库配置的样例

```swift
if let databaseURL = Environment.get("DATABASE_URL") {
    app.databases.use(try .postgres(
        url: databaseURL
    ), as: .psql)
} else {
    // ...
}
```

如果您使用 `Heroku Postgres's standard plan`，则需要 `Unverified TLS `。

不要忘记提交你所做的修改：

```sh
git add .
git commit -m "configured heroku database"
```

### 还原数据库

你可以使用 heroku 的 run 命令执行 `revert` 或者其他命令。默认情况下执行的是 `Run`。

还原数据库：

```sh
$ heroku run Run -- revert --all --yes --env production
```

迁移：

```sh
$ heroku run Run -- migrate --env production

# 或者指定 app
heroku run Run  --app=teamboke  --env production -- migrate
```

# 其他

杀死指定端口的进程

```sh
lsof -i:8080
kill xxxx
```

创建文件夹

```
mkdir -p Resources/Views
```

# Ubuntu 20.04 

* swiftenv
* clang
* vapor
* zlib: sudo apt install zlib1g-dev

# Leaf 的使用

模板复用，需要用到 `#extend`，`#import` 和 `#export`，那么如何理解这三个tag:

`#extend` 标签允许您将一个模板的内容复制到另一个模板中。

`#import` 是暴露一个插槽。

`#export` 是实现特定的插槽。

举例：

```html
<!-- base.html -->
<html>
    <head>
        <title>#(title)</title>
    </head>
    <body>#import("body")</body>
</html>
```

`base.html` 是个模板，它里面通过 `#import` 定义了 body 这么一个插槽，方便扩展它的文件可以自定义实现。

复用这个`base.html`模板，假设我们创建了 `welcome.html`：

```html
<!-- welcome.html -->
#extend("base"):
    #export("body"):
        <p>Welcome to TEAM-BOKE!</p>
    #endexport
#endextend
```

`#extend` 后面是我们要扩展的文件名，比如我们要扩展 `base.html`, 那么就传入 `base` 即可。

`#export` 是我们对基模板中的插槽的自定义实现，指明需要实现的插槽的名字。

那么当 `["title": "Hi there!"]` 从`Swift`传递过来时，`welcome.html`将被渲染为：

```html
<html>
    <head>
        <title>Hi there!</title>
    </head>
    <body><p>Welcome to TEAM-BOKE!</p></body>
</html>
```

# 配置远程 vscode remote

非常方便编写服务器代码

1.在插件市场中搜索并安装 Remote Development
2.执行 ssh-keygen 命令创建密钥

```shell
ssh-keygen -t rsa -C  'your email@xxx.com'
```

3.生成ssh key了之后，需要将ssh key放到远程服务器上。

使用 scp 命令将本地的公钥文件 id_rsa.pub 复制到需要连接的Linux服务器：

```shell
scp ~/.ssh/id_rsa.pub 用户名@ip:/home/id_rsa.pub
```

4.登录服务器，把公钥追加到服务器ssh认证文件中：

```shell
cat /home/id_rsa.pub >> ~/.ssh/authorized_keys
```

5.使用 `cmd+shift+p` 的快捷键调用命令，执行 `Remote-SSH:Connect to Host...`, 然后选择配置文件的路径

图文教程可[参考文章](https://zhuanlan.zhihu.com/p/68330319)


# 配置 VSCode，编写 Swift 代码更舒心

在 Linux 的环境中，建议用swiftenv 安装Swift，因为这样安装可以快速管理多个swift版本。

在用 VSCode 编写 Swift 代码，首先我们需要代码高亮，代码自动补全。这是两个非常基础的需求。

对于代码高亮VSCode 已经帮我们支持了。

那么自动补全的话，我们需要安装 SourceKit-LSP 的插件。

LSP的全程是Language Sever Protocol，是微软提出的一项标准化协议，旨在统一开发工具与Lanuguage Server之间的通信。LSP为支持的语言提供了一套通用的功能集，包括：语法高亮、自动补全、定义跳转、查找引用等等。

Swift ToolChain 中已经集成了 `LSP`, 不行，你可以快速找下路径：

```shell
$ which sourcekit-lsp
/home/mac/.swiftenv/shims/sourcekit-lsp
```

> sourcekit-lsp 这个路径等下配置 vscode 的时候我们需要用到。

第二步，就是安装插件，很幸运，苹果给我们写好了文档，操作下来也没啥问题

[VSCode SourceKit-LSP 插件文档](https://github.com/apple/sourcekit-lsp/blob/main/Editors/vscode/README.md)

第三步，配置 sourcekit 的路径。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a962fba79bff48338656781bf33d2dcd~tplv-k3u1fbpfcp-watermark.awebp)

将 Sourcekit-lsp: Server Path 中的路径配置为 `/home/mac/.swiftenv/shims/sourcekit-lsp`。
然后重启 VSCode，便可支持代码自动补全、定义跳转等功能。

如果还需要更丰富的配置，如代码格式化，Debug 等，那么可以参考这篇文章：[在Linux系统上搭建Swift开发调试环境](https://juejin.cn/post/6929392693806120968#heading-20)

