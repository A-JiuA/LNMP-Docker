# LNMP-Docker
LNMP-Docker是一个使用Docker快速部署的LNMP环境

## 使用
### Dockerfile
```
git clone https://github.com/A-JiuA/LNMP-Docker.git && cd LNMP-Docker
docker build -t lnmp:latest .
docker run -d -p 50002:22 -p 80:80 --restart=always --name lnmp lnmp
```
