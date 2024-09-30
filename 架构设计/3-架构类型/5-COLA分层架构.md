# COLA分层架构

````col
```col-md
~~~ad-tips

~~~
![[Pasted image 20230506155549.png]]
```

```col-md
![[Pasted image 20230506155337.png|555]]
```

![[Pasted image 20230506155353.png|555]]
````
## Adapter && Client
````col

```col-md
### Adapter
~~~ad-tips
title: Adapter
- 基本相当于Controller层, 为了适配不同终端, 调用<mark class="hltr-pink">client层</mark>, client就是服务接口的定义
- 负责路由和适配
~~~
![[Pasted image 20230506164102.png|500]]
```

```col-md
### Client
~~~ad-tips
title: Client
- 服务接口的定义, 可以说是proto文件和其生成的dto, 其具体实现由<mark class="hltr-pink">app层</mark>来
- 分api和dto等目录
~~~
![[Pasted image 20230506164441.png|500]]
```

````
	## App && Domain && Infra
````col
```col-md
### App
~~~ad-tips
- 作为Client层接口服务的实现
- 业务分包, 再功能分包
- 获取输入, 校验参数, 调用Domain层处理业务, 发消息通知等
- 层次开放, 可以绕过Domain直接访问Ifra层
- executor -> 处理request, command, query等
- consumer -> 处理mq的msg
- scheduler -> 处理cron任务等
~~~
![[Pasted image 20230506165310.png|500]]
```

```col-md
### Domain
~~~ad-go
- 核心业务逻辑, 应用核心不依赖其他任何层次
- 领域实体, 充血模型
- 领域能力, domainservice目录下的对外暴露的服务能力, 如usecase
- 领域网关, gateway目录下的接口定义, 依赖倒置由<mark class="hltr-blue">infra层</mark>去实现的接口
~~~


![[Pasted image 20230506170047.png|500]]
![[Pasted image 20230506170333.png|500]]
```

```col-md
### infrastructure
~~~ad-note
- 实现Domain层的网关和config等
- 数据库, 缓存, 搜索引擎, 文件系统, rpc调用等
- 领域防腐, 外部依赖需要通过gateway转义处理被app和domain层使用
~~~
~~~ad-go
title: 防腐
domain业务域和外部依赖的解耦
- 通过依赖倒置, domain层通过gateway接口, 数据源可以是db, 也可以是外部API
- 比如我们domain是订单域, 调用外部商品服务, 商品域返回的是一个大而全的DTO
- 而我们订单域只需要部分字段, 在这里转换为自己领域的item
~~~

![[Pasted image 20230506171534.png|500]]
![[Pasted image 20230506173056.png|500]]
```

````



