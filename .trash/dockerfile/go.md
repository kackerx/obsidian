# go

```dockerfile
FROM golang:alpine AS builder 
ENV SRCPATH /go/src 
WORKDIR $SRCPATH 
COPY main.go . 
COPY go.mod . 
COPY framework/core.go ./framework/core.go 
ENV GOPROXY https://goproxy.cn,direct 
RUN go mod download 
RUN go build -o main ./main.go 

FROM alpine:latest 
WORKDIR /root 
COPY --from=builder /go/src/main . 
RUN chmod +x /root/main 
EXPOSE 8080 
ENTRYPOINT ["/root/main"]
```