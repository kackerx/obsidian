## govaluate

```go
func main() {  
   // params := map[string]int{"a": 2}  
   expr, err := govaluate.NewEvaluableExpression("a > 3 || b < 11")  
   if err != nil {  
      return  
   }  
  
   res, err := expr.Eval(ExprParams{  
      extra: map[string]interface{}{  
         "a": 2,  
         "b": 12,  
      }},   )  
   if err != nil {  
      panic(err)  
   }  
   fmt.Println(res)  
}  
  
type ExprParams struct {  
   extra map[string]interface{}  
}  
  
func (h ExprParams) Get(name string) (res interface{}, err error) {  
   if res, ok := h.extra[name]; ok {  
      return res, nil  
   }  
  
   return  
}
```

