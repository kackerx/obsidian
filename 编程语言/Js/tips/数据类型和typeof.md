# 数据类型

## sumup

> Js有6基本类型, 1复杂类型

- Undefined
- Null
- Boolean
- Number
- String
- Sombol
- Object

## typeof

- undefined
- boolean
- string
- number
- object
- function // 函数严格是对象不是类型, 但是比较特殊也可以typeof, null则是空的object
- spmbol

## undefined

- var和let声明但未初始化的变量都是undefined类型, 值是特殊值==undefined==, 但是声明都没声明的会报错

- typeof对于未初始化和未声明的都是返回字符串==undefined==

## Null

- typeof 一个null对象, 返回object
- `null == undefined // true` 
- 永远不要显示的设置变量值为undefined, 但是null可以, 区别于undefined表明一个对象定义暂时空