# LNMP-Docker
LNMP-Docker是一个使用Docker快速部署的LNMP环境

## 使用
### 使用Dockerfile构建镜像
```
git clone https://github.com/A-JiuA/LNMP-Docker.git && cd LNMP-Docker
docker build -t lnmp:latest .
```
整个过程大约需要1-10分钟,镜像体积约为625MB
### 启动
将网站目录挂载到容器启动
```
docker run -itd --name lnmp --restart=always -v 你的网站目录:/var/www/html -p 80:80 lnmp
```
例如
```
docker run -itd --name lnmp --restart=always -v /var/www/html:/var/www/html -p 80:80 lnmp
```
### 注意
使用`docker exec -it lnmp bash`可以进入容器内的终端,`exit`退出
镜像基于ubuntu20.04,php版本为7.4,nginx与mysql默认为最新版
mysql的root密码默认为`root`,请及时修改
