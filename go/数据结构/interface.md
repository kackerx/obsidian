# 接口

## 空接口 eface (_type, data) 

![[Pasted image 20221107181044.png|700]]
- 空接口变量赋值一个具体类型, \_type指向类型原数据, data只想f指针, 类型原数据包含方法原数据数组

## 非空接口 iface (tab, data)

![[Pasted image 20221107181418.png|700]]

![[Pasted image 20221107181545.png|700]]

## interface和nil判断

^53037e

如果赋值给interface的变量有具体的类型, 那eface的字段就存在, 并不为nil

```go

var s interface{}  
  
fmt.Println(s == nil)  // true
  
var a []int  
  
s = a  
  
fmt.Println(s == nil)  // false
```