
# 博客项目

自定义工作目录

![](https://docs.vapor.codes/4.0/images/xcode-scheme-options.png)

如果是 xcode 运行，需要设置为当前项目根目录

## 路由


## 数据库

### macos

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

### 注意
1. 更改数据库后，需要写迁移代码，完成后记得执行 `vapor run migrate`
2. 模型间有依赖关系，注意迁移类的调用顺序


## 认证

1. 用户+密码换取 access_token 和 refresh_token 
2. 通过 access_token 校验，判断是否登录
3. 如果 access_token 过期，通过 refresh_token 重新生成 access_token
4. 如果 access_token 过期，那么需要用户重新登录


## Heroku 部署

[Heroku](https://www.heroku.com/) 平台的灵活性极高且支持多种编程语言。若想把程序部署到 Heroku 上，开发者可以直接使用 Git 把程序推送到 Heroku 的 Git 服务器上。在服务器上, git push 命令会自动触发安装、配置和部署程序。

### 注册 Heroku 账户

您将需要一个heroku帐户，如果您没有，请在此处注册：[https://signup.heroku.com/](https://signup.heroku.com/)

### 安装 CLI

确保已安装 heroku cli 工具。

* HomeBrew

    ```sh
    brew install heroku/brew/heroku
    ```

* 其他安装选项
  在此处查看替代安装选项：[https://devcenter.heroku.com/articles/heroku-cli#download-and-install](https://devcenter.heroku.com/articles/heroku-cli#download-and-install).

### 登录
安装cli后，请输入以下内容：

```sh
$ heroku login
```

用以下命令来验证邮箱是否登录：

```sh
$ heroku auth:whoami
```

### 创建一个应用程序

访问 `[dashboard.heroku.com](https://dashboard.heroku.com)`，登录您的帐户，并从右上角的下拉列表中创建一个新应用程序。按照 Heroku 提供的提示进行操作即可。


### Git

Heroku 使用 Git 部署您的应用程序，因此您需要将项目放入 Git 存储库（如果尚未安装）。

#### 初始化 Git

如果需要将 Git 添加到项目中，请在终端中输入以下命令：

```sh
$ git init
```

#### Master 分支

默认情况下，Heroku 部署 master 分支。在推送之前，请确保所有更改都已签入该分支。

检查您当前的分支：

```sh
$ git branch
```

星号表示当前分支：

```sh
* master
  commander
  other-branches
```

如果您当前不在 `master` 分支上，请输入以下命令切换到 `master` 分支：

```sh
$ git checkout master
```

#### 提交变更

如果此命令产生输出，则您有未提交更改：

```sh
$ git status --porcelain
```

使用以下命名进行提交：

```sh
$ git add .
$ git commit -m "我代码修改的描述"
```

#### 与 Heroku 连接

将您的应用程序与 heroku 连接（替换为您的应用程序名称）

```sh
$ heroku git:remote -a your-apps-name-here
```

#### 设置 Buildpack

设置 buildpack 告诉 heroku 如何处理这个 vapor 项目。

```sh
$ heroku buildpacks:set vapor/vapor
```

#### Swift 版本文件

buildpack 会寻找一个.swift-version 文件，获知使用的 swift 版本。 （可根据自己的项目来替换下面的 5.2.1）

```sh
echo "5.2.1" > .swift-version
```

这将创建 `.swift-version` 文件，内容为 5.2.1。

#### Procfile

Heroku 使用 Procfile 知道如何运行您的应用程序，我们可以使用下面：

```sh
web: Run serve --env production --hostname 0.0.0.0 --port $PORT
```

可以使用以下终端命令进行创建:

```sh
echo "web: Run serve --env production" \
  "--hostname 0.0.0.0 --port \$PORT" > Procfile
```

#### 提交变更

我们只是添加了这些文件，但尚未提交。如果我们推送，heroku 将找不到它们。

提交，使用下面命令：

```sh
$ git add .
$ git commit -m "adding heroku build files"
```

#### 部署到 Heroku

您已经准备好部署，可以在终端上运行它。构建可能需要一段时间。

```sh
$ git push heroku master
```

#### Scale Up

成功构建之后，您需要添加至少一台服务器，一台网络是免费的，您可以通过以下方式获得它：

```sh
heroku ps:scale web=1
```

#### 持续部署

每当您想更新时，只需将最新的更改放入master并推送到heroku，它将重新部署。

#### Postgres

##### 添加PostgreSQL数据库

在 [dashboard.heroku.com](https://dashboard.heroku.com) 访问您的应用程序，然后转到 `Add-ons` 部分。

从这里输入 `postgres`，您将看到`Heroku Postgres`的选项，选择它。

选择`hobby dev free plan`，并进行配置。 剩下的事由 Heroku 完成。

完成后，您将看到数据库显示在 `Resources` 选项卡下。

##### 配置数据库

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

##### 还原数据库

你可以使用 heroku 的 run 命令执行 `revert` 或者其他命令。默认情况下执行的是 `Run`。

还原数据库：

```sh
$ heroku run Run -- revert --all --yes --env production
```

迁移：

```sh
$ heroku run Run -- migrate --env production
```



## 其他
杀死指定端口的进程

```sh
lsof -i:8080
kill xxxx
```

创建文件夹

```
mkdir -p Resources/Views
```


