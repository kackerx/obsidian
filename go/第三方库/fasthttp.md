# fasthttp

## client

### simple

```go

url := `http://httpbin.org/get`

status, resp, err := fasthttp.Get(nil, url)

if err != nil {
	fmt.Println("请求失败:", err.Error())
	return

}

if status != fasthttp.StatusOK {
	fmt.Println("请求没有成功:", status)
	return
}

// post
args := &fasthttp.Args{} 
args.Add("name", "test") 
args.Add("age", "18")
```

### complex

```go
url := `http://httpbin.org/post?key=123`

req := &fasthttp.Request{}

req.SetRequestURI(url)

requestBody := []byte(`{"request":"test"}`)

req.SetBody(requestBody)

// 默认是application/x-www-form-urlencoded

req.Header.SetContentType("application/json")

req.Header.SetMethod("POST")

resp := &fasthttp.Response{}

client := &fasthttp.Client{}

if err := client.Do(req, resp);err != nil {

	fmt.Println("请求失败:", err.Error())

	return

}

b := resp.Body()
```