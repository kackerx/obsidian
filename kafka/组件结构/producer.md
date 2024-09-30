# Producer

## sumup

![[Pasted image 20221116152144.png|1000]]

## 幂等性

- Producer的参数enable.idompotence=true
- 开启幂等的Producer有一个pid, 发送同一Partition的消息会附带Sequence Number, Broker会对<pid, partition, seqNum>做缓存
- 相同主键消息只会持久化一条
- pid重启会变化, 不同partition主键不同, 所以幂等性无法跨分区, 所以更好是在消费端做幂等

## 生产消息

![[Pasted image 20230123003045.png|500]]

