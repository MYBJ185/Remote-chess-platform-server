# 使用 Ubuntu 20.04 作为基础镜像
FROM ubuntu:20.04

# 设置时区（可选）
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更新软件源并安装必要的软件
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev

# 创建工作目录
WORKDIR /GZDServer

# 将当前目录的内容复制到容器中
COPY . /GZDServer

# 编译应用程序
RUN mkdir build && cd build && cmake .. && make

# 暴露应用程序使用的端口（假设为 8080）
EXPOSE 8080

# 设置容器启动时执行的命令
CMD ["./build/GZDServer"]
