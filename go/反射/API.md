# API

## sumup 

![[Pasted image 20221204105852.png|500]]
- 可以从reflect.Value得到reflect.Type, 反之则不行

## 概念

- Type和Kind的区别
    - Kind是种类, 数组, 切片, 结构体...(可枚举) [2]int == [3]int
    - Type是实际类型, [2]int != [3]int

## api

```go
res := make(map[string]any)

typ := reflect.TypeOf(val)
refVal := reflect.ValueOf(val)

FieldNums := typ.NumField() 


for i := 0; i < FieldNums; i++ {

	fdType := typ.Field(i) // 字段的type

	res[fdType.Name] = refVal.Field(i).Interface() // 字段的value

}
```

## Elem

![[Pasted image 20221204215919.png|700]]
- Elem()获取指针类型的type和value对应的结构特的type和value

> [!abstract]+
> dfasdf
> adf
> df
> 确实是
> 


```ad-bug
title: hehe

~~~go
func test() {
	println("hello")
}
~~~

```








