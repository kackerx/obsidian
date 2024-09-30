# 构造模式

## build

```go
type User struct {  
   Name string  
   Age  int  
}  
  
func (u *User) WithName(name string) *User {  
   u.Name = name  
   return u  
}
```

## options

- base 
```go  
type User struct {  
   Name string  
   Age  int  
}  
  
type UserOptions struct {  
   Name string  
   Age  int  
}  
  
func NewUser(opt *UserOptions) *User {  
   return &User{  
      Name: opt.Name,  
      Age:  opt.Age,  
   }
}  
  
func main() {  
   fmt.Println(NewUser(&UserOptions{Name: "kk"}))  
}
```

- 地
```go
type Options func(*User)  
  
func WithName(name string) Options {  
   return func(u *User) {  
      u.Name = name  
   }  
}  
  
func WithAge(age int) Options {  
   return func(u *User) {  
      u.Age = age  
   }  
}  
  
func NewUser(opts ...Options) *User {  
   u := new(User)  
  
   for _, opt := range opts {  
      opt(u)  
   }  
   return u  
  
}  
  
func main() {  
   user := NewUser(WithName("kacker"), WithAge(1))  
   fmt.Println(user)  
}
```