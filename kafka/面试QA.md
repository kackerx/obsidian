# 面试QA

&  kafka的多副本机制和多分区

@  kafka为分区建立了多副本机制(replica), follwer跟随leader竞选, 只是leader的数据副本, 保证消息存储的安全性

---

&  kafka如何保证消息的顺序

@  每次添加消息到Partition都会添加到队尾且分配一个offset, kafka通过offset保证分区顺序性所以可以
     - 一个Topic对应一个Partition
     - 发送消息时可以指定topic, partition, key, data四个参数, 指定分区或者同一key, 可以保证发送到同一分区, 使用表/对象id作为key

---

## 避免消息丢失

- 使用带有回调的send方法, 确保发送到broker成功
- 设置producer的acks = all, 表明所有broker的副本集都要收到消息, 才算<mark class="hltr-pink">已提交</mark>, 最高等级的已提交定义
- 设置producer的retries, 重试发送
- replication.factor >= 3, broker端的参数, 消息冗余几份
- min.insync.replicas > 1, broker端的参数, 消息被写入到多少个副本才算已提交, 大于1提升消息持久性
- 推荐设置成 replication.factor = min.insync.replicas + 1
- 消费端enable.auto.commit = false, 手动提交, 对于多线程消费乱序问题

---

&  consumer可以消费指定分区的消息吗

@  consumer发出fetch请求拉取消息可以指定消息在日志中的offset, 从这个位置开始的消息, 拥有了offset的控制权, 可以回滚重新消费之前的数据

---

&  生产者的分组策略

@  生产者决定数据发送到集群哪个partition, 每一条消息是以kv格式, 由k决定