# gomock

## 使用案例

```go
type Person interface {
   Get(id int) string
}

// 客户端使用
1.  `EXPECT()`：返回一个对象，该对象允许调用者设置**期望的返回值**。
2.  `Get()`：设置入参并调用mock对象中的方法。`gomock.Any()`表示匹配任意入参。
3.  `Return()`：设置返回值。
4.  `AnyTimes()`：无限次调用，也就是不管调用多少次都会返回这个结果。

ctrl := gomock.NewController(t)  
  
mockPerson := mock_dao.NewMockPerson(ctrl)  
  
mockPerson.EXPECT().Get(gomock.Any()).Return("person1").AnyTimes()  
mockPerson.EXPECT().Get(2).Return("person2")

service := service.Service{mockPerson}  
person := service.GetPerson("1")  
  
if person != "person1" {  
    t.Errorf("%v", person)  
}  
  
person2 := service.GetPerson("2")  
if person != "person2" {  
    t.Errorf("%v", person2)  
}
```

- 定义一个接口

## 参数

``go mockgen -source=./dal/person.go -destination=./mock_gen/person_mock.go github.com/go-redis/redis/v9 Cmdable

| -                                    | -            |
| ------------------------------------ | ------------ |
| -package                             | mocks        |
| -destination                         | -            |
| -source                              | -            |
| github.com/go-redis/redis/v9 Cmdable | 生成哪个接口 |

