
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

## 部署

### heroku 



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


