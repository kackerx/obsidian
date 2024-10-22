	# 事务和第三方api - 一致性问题

```ad-tips
先db事务, 再请求api, 根据请求结果决定事务提交或是回滚, 反过来的话有致命缺陷禁止使用(请求成功了事务失败了无法回滚)
```

## 问题
````col
```col-md
上述tips有什么问题? api的结果有两种可能性, 要么明确结果(成功 & 失败), 要么结果不明(超时, 请求断开或响应慢)
```


````

## 解决方案

````col
```col-md
~~~ad-tips
- 解决超时问题, 双方协调, callee提供回调查询接口, caller轮询调用获取调用结果
- 好处: 明确获取调用结果
- 坏处: 无明显缺点, 可能接口不正规未提供
~~~
```

```col-md
~~~ad-note
- 解决库占用问题, 请求不放在事务中
- 好处: 避免长事务
- 坏处: 第三方结果不明确, 依然可能不一致, 也无法解决超时问题
~~~
```
~~~ad-go
- 结合1和2, 请求不在事务中, 且轮询结果, 根据结果后续提供补偿的回退操作
- 好处: 依然依赖第三方api提供的回调轮询
- 坏处: 实现麻烦
~~~
````
