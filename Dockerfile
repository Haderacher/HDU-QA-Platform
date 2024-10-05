# Step 1: 使用官方 Go 镜像作为构建环境
FROM golang:1.23-alpine AS build

# Step 2: 设置工作目录
WORKDIR /app

# Step 3: 将 go.mod 和 go.sum 文件复制到容器中
COPY go.mod go.sum ./

# Step 4: 下载依赖
RUN go mod download

# Step 5: 复制项目的所有源代码
COPY . .

# Step 6: 编译项目
# 假设 main.go 文件在 cmd 目录下，你可以调整路径
RUN go build -o hdu-qa-platform ./cmd

# Step 7: 使用更小的基础镜像来运行构建好的二进制文件
FROM alpine:latest

# Step 8: 设置工作目录
WORKDIR /root/

# Step 9: 复制构建阶段生成的二进制文件
COPY --from=build /app/hdu-qa-platform .

# Step 10: 复制配置文件，假设在 conf 或 config 文件夹中
COPY --from=build /app/conf ./conf
COPY --from=build /app/config ./config

# Step 11: 暴露服务端口
EXPOSE 8082

# Step 12: 运行二进制文件
CMD ["./hdu-qa-platform"]
