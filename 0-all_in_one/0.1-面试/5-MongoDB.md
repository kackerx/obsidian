# MongoDB

## 分片机制

--- start-multi-column: ID_2cos
```column-settings
Number of Columns: 3
Largest Column: standard
Border: off
Shadow: off
```

~~~ad-tips
title:  

- 和关系型数据库相比较为灵活, 横向扩展能力强, 模型经常变动的, 难以预料用户输入的
~~~

</br>

~~~ad-one
title: 分片机制

- 『分片集合(collection)』集合就是逻辑表, 分片就是物理表
- 每个分片由多个块(chunk), 一个块128M
- 超过128m或者文档过多会自动分块
~~~
![[Pasted image 20240914103448.png|577]]

</br>

~~~ad-one
title: 再平衡

- 不同于分库分表要自己考虑不同物理表之间的数据均衡, MongoDB自动再平衡尽量每个分片差不多的数据量的负载均衡, <mark class="hltr-blue">挪动块</mark>
~~~
![[Pasted image 20240914103615.png|577]]

--- column-break ---

~~~ad-one
title: 再平衡过程

- 『平衡器』发送`moveChunk`命令到源分片上
- 源分片执行该命令, 目标分片创建索引和同步A数据
- 当块A最后一个文档同步给目标分片后, 启用一个同步过程, 把迁移过程中的数据变更也同步过来
- 同步完成后源分片更新元数据, 告知块A已经迁移
- 源分片删除块A
~~~
![[Pasted image 20240914103916.png|577]]

~~~ad-one
title: 配置服务器 config Server

- MongoDB启用配置服务器来存储分片的元数据, 包括『分片信息, 权限控制信息』用来控制分布式锁, 分片信息被负责执行查询mongos使用
- 
~~~
![[Pasted image 20240914104622.png|577]]

--- column-break ---

~~~ad-two
title: 主从复制集

- 主从实例合并一起称为一个『复制集(Replica Set)』
- 类似binlog, 主从同步是通过所谓的oplog实现
~~~
![[Pasted image 20240914105257.png|577]]

</br>

~~~ad-two
title: 写入语义

- <mark class="hltr-blue">Write Concern</mark>, w, j, wtimeout三个参数, 类似kafka的acks
- w: 
	- majority: 默认值, 写操作同步给大部分节点, 可用性强, 写入性能差
	- N: N=1是写入主节点, N>1包括主节点的从节点数, N=0发射后不管
	- 自定义写入节点策略: 比如一些节点打上标签, 写入的时候一定写入标签节点
- j: 控制数据有没有刷盘
- wtimeout: 在w>1时生效, 超时后也有可能写入成功的
~~~

--- end-multi-column
### 面试
--- start-multi-column: ID_2cos
```column-settings
Number of Columns: 3
Largest Column: standard
Border: off
Shadow: off
```

~~~ad-one
title: 主从结构

- 启用主从结构, 其实类似于mysql分库分表主从同步, redis和kafka的主从
- oplog
~~~

</br>

~~~ad-one
title: 仲裁节点

- 只参与投票的仲裁节点, 轻量级服务器成本低, 从节点崩溃也有足够的节点可以投票
~~~
![[Pasted image 20240914111140.png|577]]

</br>

~~~ad-one
title: 主从的配置服务器

- 主节点崩溃后依旧可读
~~~
![[Pasted image 20240914111319.png|577]]

--- column-break ---

~~~ad-two
title: 引入分片

- 
~~~
![[Pasted image 20240914111445.png|577]]

</br>

~~~ad-two
title: 调整写入语义

- `Write Concern`
~~~

--- end-multi-column
