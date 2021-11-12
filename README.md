# Vapor实战项目

<!-- TOC -->

- [Vapor实战项目](#vapor%E5%AE%9E%E6%88%98%E9%A1%B9%E7%9B%AE)
- [参考](#%E5%8F%82%E8%80%83)
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

<!-- /TOC -->

# 项目模仿参考

* 后台模板参考：[https://github.com/tailwindadmin/admin](https://github.com/tailwindadmin/admin)
* 前端站点参考：[https://sharecuts.cn/shortcut/5681](https://sharecuts.cn/shortcut/5681)


# 分支管理

* main 是稳定分支
* dev 是开发分支

main 的改动会触发项目的自动部署，无需人工改动

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

# Ubantu 20.04 

* swiftenv
* clang
* vapor
* zlib: sudo apt install zlib1g-dev


# Leaf

ww