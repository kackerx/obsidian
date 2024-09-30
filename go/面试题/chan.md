## 面试

- nil的chan接收? 已关闭的chan接收
    nil的会被阻塞, 关闭的bufchan的会消费完剩余, 然后读取零值, 通过ok判断是还有可用值

- chan泄漏
    - 只发送或只接收但, 没有另一方来对接

- 代码题
    - chan任务池
    - chan控制goro数量
    - chan实现生产者消费者

