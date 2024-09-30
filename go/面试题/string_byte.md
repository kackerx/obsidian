# string & byte

## 结构

```go
type stringStruct struct { 
	str unsafe.Pointer 
	len int 
}
```

## 字符集

![[Pasted image 20221107173229.png|500]]

& 定长编码

![[Pasted image 20221107173416.png|500]]
& utf-8编码
![[Pasted image 20221107173619.png|500]]



## go的str & byte

![[Pasted image 20221107173922.png|500]]