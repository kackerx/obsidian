# channel

## 数据结构

![[Pasted image 20221112155237.png|700]]
- 队列的大小qcount
- 队列数据量datasiz
- buf缓冲指向缓冲区
- 发送队列, 等待队列

## 发送和接收

![[Pasted image 20221112155647.png|700]]


- sendx和recvx指向下一个发送和接收元素的位置
- 12345环形缓冲区满了后, 发送6会在sendq队列生成一个sudog, 包含要发送的元素6, 等待发送的goro g1, 具体的chan
- g2消费一个值后, 根据sudog, 维护recvx, sendx, 6入buf

## 关于发送和接收的阻塞非阻塞

![[Pasted image 20221112160354.png|700]]
- 发送10 -> buf未满, 接收队列有sudug等待接收, 不阻塞
- 发送10 -> ch == nil, 没有缓冲区, 接收队列没有sudug, 或缓冲区满了, 阻塞, 利用select非阻塞




