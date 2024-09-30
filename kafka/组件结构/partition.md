# Partition

## sumup

> 分区属于Topic的一部分, 一个Topic有多个Partition且同一Topic的多个Partition可以分布在不同的Broker, 提供较好的并发能力(负载均衡), 
> 某topic有N个partition, 集群有N个broker, 那么, 每个broker存储该topic的一个partition

## 节点分布

![[Pasted image 20221116143921.png|500]]
- Topic有N个Partition, 集群有N+M个Broker, 那么N个Broker每个节点存储该Topic的一个Partition (broker > partition)
- N个Partition, Broker < N, 那么会有Broker存储多余一个Partition
- Topic只是逻辑概念, 真正分布式的是Partition
- 所以当Partition数量 < Broker时, Partition数越大吞吐越高, 线性提升

## 分区策略

- 轮询策略(默认)
- 随机策略, 实现partition方法
- 按消息键保存策略 -> <mark class="hltr-orange">key.hashCode() % partitions.size()</mark>
