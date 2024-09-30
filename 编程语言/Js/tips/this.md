# this

## 作用域

- 全局this是window和global, 函数中的this谁调用就是谁
```js
function foo() {
	console.log(this) // 谁调用是谁
}

console.log(this) // window, node里时global
```