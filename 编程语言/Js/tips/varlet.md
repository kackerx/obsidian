# var和let

## sumup

- var会把变量提升至当前函数作用域顶部
```js
function foo() {  
    console.log(a) // 相当于顶部 var a; 所以不报错, 打印undefined
    var a = 1      // 如果省略var, a = 1, 则a是全局变量, 下方会打印输出
}

console.log(a)     // 报错，因为foo里的声明是局部变量
```

- var和let区别
```js
--- let是块级作用域, var是函数级作用域
if (true) {
	let a = 0
}
console.log(a) // ReferenceError, 如果是var的话, 声明提升这里肯定可以输出

--- let不能重复绑定(同一个块作用域中)
let a = 0
let a = 1      // SyntaxError

--- let不存在声明提升
console.log(a) // ReferenceError
let a = 0

--- 全局声明
var a = 1
console.log(window.a) // 1, 全局作用域中var声明会成伟window的属性

let a = 1
console.log(window.a) // undefined

--- 循环渗透
for (var i = 0; i < 5; ++i) { 
	// 循环逻辑 
} 
console.log(i); // 5, 引用了循环的i, let不会

for (var i = 0; i < 5; ++i) { 
	setTimeout(() => console.log(i), 0) 
} // 5555引用了同i, let每次循环重新绑定则不会
```

- const
```js
--- const作用域也是块, 和let相似

--- const声明的常量不可修改, 但如果const引用的是对象, 对于对象内部属性的修改是允许的(浅拷贝)
```