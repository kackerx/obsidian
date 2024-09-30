# defer

## 执行时机

```go
func foo() int {  
    var i int  
  
    defer func() {  
        i++  
    }()  
  
    return i  
}

//
anony = i
i++
return anony
```

- return语句不是原子操作, return = 设置返回值, defer, ret
- 所有具名返回值会被影响

## 执行引用变量

defer 语句定义时，对外部变量的引用是有两种方式的，分别是作为函数参数和作为闭包引用。作为函数参数，则在 defer 定义时就把值传递给 defer，并被缓存起来；作为闭包引用的话，则会在 defer 函数真正调用时根据整个上下文确定当前的值。

```go
now := time.Now()  
  
time.Sleep(time.Second)  
  
defer fmt.Println(time.Since(now)) // 立即计算  
  
defer func(t time.Time) {  
   fmt.Println(time.Since(t)) // 闭包根据当前上下文  
}(now)  
  
time.Sleep(time.Second * 3)


////

s := []int{1, 2}  
  
defer fmt.Println(s)   // 立即计算1, 2, 并缓存起来后续修改不影响
  
defer func() {  
   fmt.Println(s)      // 1, 2, 3, 闭包引用
}()  

defer func(i []int) {
	fmt.Println(i)     // 1, 2, 参数拷贝, 缓存
}(s)
  
s = append(s, 3)
```