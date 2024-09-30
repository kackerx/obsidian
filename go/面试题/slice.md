# slice

## 结构

```go
type slice struct { 
	array unsafe.Pointer 
	len int 
	cap int 
}
```

## 扩容

![[Pasted image 20221107170856.png|500]]
- 扩容原则: 容量小于1024为2倍, 容量超过1024为1.5倍
