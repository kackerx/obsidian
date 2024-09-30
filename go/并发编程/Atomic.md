# atomic

```go
func Do() {  
   cnt := atomic.AddUint32(&count, 1) // 原子操作, 必然只有一个cnt符合条件  
   defer atomic.AddUint32(&count, -1)  
  
   if cnt > 100 {  
      return  
   }  
  
   time.Sleep(time.Second)   
}
```


