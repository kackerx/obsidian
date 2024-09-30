# protobuf

## sumup

```bash
# 安装protoc
brew install protobuf

# 安装grpc插件
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

# 生成
protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative user.proto
protoc --go_out=. --go_opt=paths=source_relative \  
       --go-grpc_out=require_unimplemented_servers=false:. --go-grpc_opt=paths=source_relative \
	    api/user/user.proto
```

|     |     |     |
| --- | --- | --- |

