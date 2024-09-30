# NoSQL

## master选举

--- start-multi-column: ID_2cos
```column-settings
Number of Columns: 3
Largest Column: standard
Border: off
Shadow: off
```



--- column-break ---



--- end-multi-column
## ElasticSearch写入和架构

--- start-multi-column: ID_2cos
```column-settings
Number of Columns: 3
Largest Column: standard
Border: off
Shadow: off
```

~~~ad-one
title: 节点角色

- 候选主节点(Master-eligible Node): 可被选为主节点的节点, 主节点负责集群本身的管理, 如创建索引
- 仅投票节点(Voting-only Node): 只参与主从选举, 自身不会被选举为主节点
- 协调节点(Coordinating Node): 负责协调请求的处理过程, 一个查询请求会被发送到协调节点上, 协调节点确定数据节点让数据节点执行查询, 最后协调节点合并数据节点返回的结果集, 大多数节点的角色
- 热数据节点(Hot Data Node), 暖数据节点(Warm Data Node), 冷数据节点(Cold Data Node)等
- 有钱专款专用, 没钱兼任
~~~
![[Pasted image 20240913162629.png|577]]

</br>

~~~ad-two
title: 写入流程

- 文档写入ES自己的buffer中
- 定时refresh到PageCache, 默认1次/s
- 刷新到磁盘, 同步记录一个Commit Point
~~~
![[Pasted image 20240913163031.png|577]]

--- column-break ---

~~~ad-two
title: Segment与合并

- 写入PageCache会产生很多段, 每个段包含多个文档, 只有写入到这里才能被搜索到
- 不断写入产生的段要合并, 合并时不能影响正在被查询的段, 因此类似数据迁移
- 1, 已有的段不动
- 2, 创建新的段, 把已有段写过去, 标记删除的不写
- 3, 等到合并完成产生新的Commit point, 里面有合并后的段没有旧的段, 因此此时查询的是新的段
- 4, 等使用老的段的查询结束, 删掉老段
~~~
![[Pasted image 20240913173617.png|577]]

</br>

~~~ad-two
title: Translog

- 类似mysql的redo log, 宕机后可以用来恢复数据
- es也是写到buffer里然后记录Translog, 也是追加顺序写, wal
- 固定默认5s刷盘, 最差会丢失5s数据
~~~
![[Pasted image 20240913173931.png|577]]

--- column-break ---

~~~ad-three
title: 索引与分片

- 索引 = 逻辑表
- 分片 = 分库分表
- 每个分片的主从复制集 = 主从复制
- 不同分片尽量分散在不同节点
- 类似Redis Sentinel, 主节点宕机, 从节点选主
~~~
![[Pasted image 20240913174541.png|577]]

</br>

~~~ad-three
title: ov

- ES高可用的核心是分片, 而且是主从分片
- 同时由Translog保证刷盘前的崩溃恢复
~~~

--- end-multi-column

## ES高可用方案

--- start-multi-column: ID_2cos
```column-settings
Number of Columns: 3
Largest Column: standard
Border: off
Shadow: off
```

~~~ad-one
title: 限流保护节点

- 1, ES有插件机制来实现自定义的限流, 可以结合ES的内存使用率和CPU设计限流策略
- 或者根据不同业务的价值来进行熔断或者降级, 拒绝非核心业务的请求
- 2, ES是基于rest请求的, 前也可以加一个网关, 在网关层面治理
- 3, 客户端做限流, 业务方控制查询频率和大小
- 4, ES本就是支持高并发大数据, 因为最佳是考虑扩容
~~~
![[Pasted image 20240913175856.png|577]]

</br>

~~~ad-one
title: 消息队列削峰

- 对业务实时性不高的情况下, 可以通过消息队列来写入ES从而代替业务上对数据库和es的双写
- 如图甚至可以区分topic为核心与非核心, 做一个简单的降级, 甚至高峰期时候选择只支持读, 停掉写
~~~
![[Pasted image 20240913180313.png|577]]

--- column-break ---

~~~ad-two
title: 保护协调节点

- 协调节点是用来负责分发请求, 处理结果集, 类似『分库分表代理』
- 避免协调节点崩溃可以部署『纯粹的协调节点』
- 利用隔离的思想, 大请求单独用协调节点, 即便挂了也不影响普通的请求
~~~
![[Pasted image 20240913180527.png|577]]

</br>

--- column-break ---

~~~ad-three
title: 双集群

- 『消息队列双写』来实现双集群
- 集群A超时响应自动切换到集群B, 使用客户端切换或者DNS解析
~~~
![[Pasted image 20240913180828.png|577]]

--- end-multi-column
## 索引机制

--- start-multi-column: ID_2cos
```column-settings
Number of Columns: 3
Largest Column: standard
Border: off
Shadow: off
```

~~~ad-one
title: 倒排索引

- 正排索引: 遍历所有文档去查找关键字『ES』, 索引存放的是文档数据, 比如mysql索引是按照字段的值来排序, 而es索引是记录字段值的每个关键词对应的文档位置
- 倒排索引: 通过关键字找到其对应的文档, 索引存放的是关键字term及其对应的文档位置
- 1, 写入时根据文档的每个字段进行『分词』, 每个字段的每个关键词是term
- 2, 统计每个关键词出现的频率, 构建一个关键词到文档ID, 出现频率, 位置的映射, <mark class="hltr-blue">posting list</mark>
~~~
![[Pasted image 20240913181857.png|577]]

</br>

~~~ad-one
title: 索引的存储 

- 每个字段是分散统计的, ES记录了两个位置信息, 第几个词, 整个term的偏移量
- 倒排索引的存储不是简单的前缀树, 用了优化的FST(Finite State Transducers)连公共前缀后缀一并压缩
- 1, 根据FST找到Block
- 2, Block中遍历找关键词, 找到Floor Block后继续遍历, 最终找到关键词对应的posting list
~~~
![[Pasted image 20240913182918.png|577]]

--- column-break ---



--- end-multi-column
## 优化查询性能

--- start-multi-column: ID_2cos
```column-settings
Number of Columns: 3
Largest Column: standard
Border: off
Shadow: off
```

~~~ad-one
title: 优化分页查询

- 如果分页查询`FROM x SIZE y`, 命中多个不同的分片
- 1, 使用Scroll和Scroll Scan, 类似游标概念
- 2, Search After: 翻页, 查询的时候再当前查询带上上一次查询返回的search_after字段
- Search After类似于分库分表中使用的『禁用跳页查询』方案, 也就是不支持随机翻页, 如mysql的根据created_at分页
- 优点是查询的数量不和偏移量有关, 而是每页大小和命中分片数量相关, 分库分表不支持所以用自己定义的翻页字段, app常用方式`where id > $max_id`
~~~

</br>

~~~ad-one
title: 增大刷新间隔

- `index.refresh_interval`: 调大 
~~~

</br>

~~~ad-one
title: 批量提交 & 异步提交

- 对业务实时性一致性要求不高, 采用异步同步
- 或者利用kafka, 一次拉取100条消息来批量同步
~~~
![[Pasted image 20240913184832.png|577]]

--- column-break ---

~~~ad-two
title: 优化不必要的字段

- 设计索引时只把必要的搜索字段的值加入, 使用动态mapping时可能无意间索引了很多新字段
- 避免全量字段同步es
- 如果缺少一些字段可以选择回表再查
~~~
![[Pasted image 20240913185038.png|577]]

</br>

~~~ad-two
title: 冷热分离

- 冷热数据分离存储, 冷数据在廉价服务器上
- 借助新的索引生命周期特性来实现, 比如日志, 三天内的放在热节点, 迁移是自动的
~~~
![[Pasted image 20240913185311.png|577]]

--- column-break ---

~~~ad-three
title: 优化垃圾回收

- 调整JAVA的垃圾回收算法
~~~

</br>

~~~ad-three
title: 优化swap

- 非常依赖内存, 因此出发swap性能下降很快
- 1, 操作系统层面禁用swap, 或者`vm.swappness`设置小值, 或者`bootstrap.memory_lock = true`
- kafka也有此手段
~~~

</br>

~~~ad-three
title: 文件描述符

- es需要文件描述符, 数量调大
- 业务隔离, 到不同的ES, 以防影响
~~~

--- end-multi-column
