# nacos

```go
func main() { 
	// 创建clientConfig 
	clientConfig := constant.ClientConfig{ 
		NamespaceId: "aff4fe40-c06d-4ab9-a502-45fe17f1ff4c", 
		// 如果需要支持多namespace，我们可以场景多个client,它们有不同的NamespaceId。当namespace是public时，此处填空字符串。 
		TimeoutMs: 5000, 
		NotLoadCacheAtStart: true, 
		LogDir: "tmp/nacos/log", 
		CacheDir: "tmp/nacos/cache", 
		RotateTime: "1h", 
		MaxAge: 3, 
		LogLevel: "debug"
	} 
	
	// 至少一个ServerConfig 
	serverConfigs := []constant.ServerConfig{ { IpAddr: "127.0.0.1", Port: 8848, }, } 
	
	// 创建动态配置客户端的另一种方式 (推荐) 
	configClient, err := client]s.NewConfigClient( 
		vo.NacosClientParam{ ClientConfig: &clientConfig, ServerConfigs: serverConfigs, }, 
	) 
	if err != nil { panic(err) } 
	
	//获取配置 
	content, err := configClient.GetConfig(vo.ConfigParam{ DataId: "user-web.yaml", Group: "dev"}, ) 
	if err != nil { panic(err) } 
	
	fmt.Println(content) 
	
	//监听配置变化 
	err = configClient.ListenConfig(vo.ConfigParam{ 
		DataId: "user-web.yaml", 
		Group: "dev", 
		OnChange: func(namespace, group, dataId, data string) { 
			fmt.Println("group:" + group + ", dataId:" + dataId + ", data:" + data) }, 
		}) 
		if err != nil { panic(err) }
	}
```![[go/第三方库/Untitled Diagram.svg]]