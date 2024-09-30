# Web

## 工程化

![[Pasted image 20230127173332.png|300]]

- DTO: 数据传输对象
	- 服务层接收和返回的数据, 如「Kratos」中的==Service==层实现接口的入参和返回值, 如「MVC」架构中的Controller层所操作的model

- VO: View Obj视图对象
	- 代表展示层所需要的数据结构, 指定页面或组件的数据封装, 是人所能看到的数据
	- 区别于DTO的是, DTO: {gender: 1, age: 30}, VO: {gender: 公子}, {age: 30+}, VO更具体, 是根据页面要求对DTO的进一步的解释

- 