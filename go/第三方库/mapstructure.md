# mapstructure

> map和struct的相互转换

```go
var m map[string]interface{}  
decoder, err := mapstructure.NewDecoder(&mapstructure.DecoderConfig{  
   Result:  &m,  
   TagName: "json",  
})  
  
if err != nil {  
   return nil, err  
}  
  
err = decoder.Decode(v)  
return m, err
```
