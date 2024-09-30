# goroutine

![[Pasted image 20221109101108.png|700]]
- 使用go关键字生成一个goroutine既是调用newproc函数, 传递拷贝的参数, 参数的大小, 和函数本身
- newproc会切换到g0栈去调用newproc1函数