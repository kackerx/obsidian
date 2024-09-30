# GMP

## sumup

- G: 一个调度任务, 包含上下文
- M: machine, 系统线程
- P: 虚拟处理器, M必须绑定P, 可以理解为一个token, 有他才有物理cpu核心执行的权利

## 处理阻塞

sysmon: system monitor, 在专有线程中执行, 不需要绑定p

- syscall / cgo 阻塞时间久, 把p剥离
- 用户g运行时间久, 发信号sigurg抢占

- 读写channel, select, timeSleep, 网络io等不会阻塞调度循环, 而是挂起goroutine, 待ready执行, 不会占用线程, 此时线程会进入schedule, 继续消费队列执行其他的g
- 如果是系统调用等阻塞M, P和M解绑, 寻找空闲的M没有则创建一个M去绑定调度

## gmp过程存在哪些阻塞

- io, select, channel, 锁, 系统调用, runtime.Gosched()

## 调度组件与调度循环

### 生产端

![[Pasted image 20221108173907.png|700]]
- 新创建的g, 会赋值给runnext
- runnext非空时, 替换老g, 把老g送入本地队列, 
- 本地队列满的话其一半塞入全局队列

![[Pasted image 20221108174402.png|700]]

### 消费端

![[Pasted image 20221108174633.png|700]]
- 每61次会从全局队列获取
- runqget优先从runnext, 然后从本地队列(256array)
- 本地队列空的话从全局队列(linkedlist)头部拿一半放入本地队列
- 全局队列空, 偷取其他p的本地队列一半

## 系统调用

![[Pasted image 20221111153510.png|500]]
- G0发生系统调用, M0将释放P, 空闲的其他M1(或缓存池或新建)继续绑定p执行剩下的goro, M0陷入系统调用阻塞
- G0系统调用结束后如果有空闲的P, M0获取一个p继续执行g0, 没有空闲的P, G0放入全局队列等待被其他P调度, M0进入缓存池或释放

![[Pasted image 20221120173857.png|700]]

