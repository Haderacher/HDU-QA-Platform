# 基础镜像选择 Golang 作为构建环境
FROM golang:1.23-alpine as builder

# 设置工作目录
WORKDIR /app

# 将项目的 go.mod 和 go.sum 文件复制到工作目录
COPY go.mod go.sum ./

# 拉取项目依赖
RUN go mod download

# 将整个项目代码复制到工作目录
COPY . .

# 构建项目
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app cmd/main.go

# 使用更小的基础镜像运行
FROM alpine

# 设置时区（可选）
RUN apk add --no-cache tzdata
ENV TZ=Asia/Shanghai

# 安装依赖
RUN apk --no-cache add ca-certificates

# 设置工作目录
WORKDIR /root/

# 从构建环境中复制已编译的二进制文件到当前容器
COPY --from=builder /app/app .

# 将配置文件复制到容器中
COPY ./config /root/config

# 暴露服务端口
EXPOSE 8082

# 运行应用程序
CMD ["./app"]
