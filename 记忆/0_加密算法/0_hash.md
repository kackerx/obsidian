# hash

:::::::::::::::::::::::::::::::::::::::: {.columns shadow=off border=off col-count=2 largest-column=firs}

~~~ad-primary
title: hash
常用hash算法分类有, MD5, SHA-1, SHA-2, SHA-3
~~~

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::columnbreak
:::

![[Pasted image 20240305114226.png|777]]

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
## md5
:::::::::::::::::::::::::::::::::::::::: {.columns shadow=off border=off col-count=2 largest-column=firs}


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::columnbreak
:::

```python
def hash_str(data: str):  
    hash_md5 = md5()  
    hash_md5.update(data.encode('utf-8'))  
    return hash_md5.hexdigest()
```

```go
func hash(data string) string {  
    md5 := md5.New()  
    md5.Write([]byte(data))  
    return hex.EncodeToString(md5.Sum(nil))  
}
```

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
## 