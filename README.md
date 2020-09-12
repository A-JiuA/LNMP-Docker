# LNMP-Docker
LNMP-Docker是一个使用Docker快速部署的LNMP环境

## 使用
### 使用Dockerfile构建镜像
```
git clone https://github.com/A-JiuA/LNMP-Docker.git && cd LNMP-Docker
docker build -t lnmp:latest .
```
### 启动
将网站目录挂载到容器启动
```
docker run -itd --name lnmp --restart=always -v 你的网站目录:/var/www/html -p 80:80 lnmp
```
例如
```
docker run -itd --name lnmp --restart=always -v /var/www/html:/var/www/html -p 80:80 lnmp
```
