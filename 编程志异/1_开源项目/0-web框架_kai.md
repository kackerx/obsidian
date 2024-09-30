## Context
--- start-multi-column: ID_2cos
```column-settings
Number of Columns: 2
Largest Column: standard
Border: off
Shadow: off
```

~~~ad-primary
title: Input

- 反序列化输入: Body字节流转换为具体的类型
- 表单输入: Form(URL的查询参数和表单数据, 全部数据), PostForm(body参数, 只有编码是`x-www-form-urlencoded`), ParseForm(解析数据)
- 查询参数: 
- 路径参数:
- 重复读取Body
- 读取Header:
- 模糊读取: 
~~~

--- column-break ---

~~~ad-grey
title: Output

- 序列化输出: json或xml
- 渲染页面: 模板
- 处理状态码: 
- 错误页面:
- 设置cookie:
- 设置header:
~~~

--- end-multi-column
### AOP
--- start-multi-column: ID_2cos
```column-settings
Number of Columns: 2
Largest Column: standard
Border: off
Shadow: off
```

```go
func TestContext_BindJSON(t *testing.T) {
	var mids []Middleware
	root := func(c *Context) {
		time.Sleep(time.Second)
		fmt.Println("i am root")
	}

	mids = append(mids,
		func(next HandleFunc) HandleFunc {
			return func(c *Context) {
				st := time.Now()
				defer func() { fmt.Println("one: ", time.Since(st)) }()

				fmt.Println("one before")
				time.Sleep(time.Second * 4)
				next(c)
				fmt.Println("one after")
			}
		},
		func(next HandleFunc) HandleFunc {
			return func(c *Context) {
				st := time.Now()
				defer func() { fmt.Println("two: ", time.Since(st)) }()

				fmt.Println("two before")
				time.Sleep(time.Second * 2)
				next(c)
				fmt.Println("two after")
			}
		})

	for i := len(mids) - 1; i >= 0; i-- { // 把核心业务逻辑root封装到最后一个执行, 洋葱模式调到底, 从底返回
		root = mids[i](root)
	}

	root(&Context{})
}
```

--- column-break ---



--- end-multi-column
