# tips #index 

:::::::::::::::::::::::::::::::::::::::: {.columns border=off col-count=2 largest-column=firs}

~~~ad-tips
title: exist

- 相当于如下, `exists`执行len(A)次, 判断子查询是否存在, 不缓存结果集, 需要查库, <mark class="hltr-pink">可以用到子查询表索引</mark>
- 当子表较大时, 不需遍历, 只需查询一次, 使用exists

```sql
select a.*  
from A a  
where exists(select 1 from B b where a.id = b.id)

for i := 0; i < len(A); i++ {  
	if exists(A[i], B) {  
		resSet.Add(A[i])  
	}  
}
```
~~~

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::columnbreak
:::

~~~ad-ex
title: in

- `in`相当于双层循环, 或说使用hash将内外表连接, <mark class="hltr-cyan">可以用到父查询表索引</mark>
- 子表较小时, 使用`in`, 是内存中遍历比较, 比`exists`的查询快

```sql
select * from A
where id in(select id from B)

for i := 0; i < len(A); i++ {  
	for j := 0; j < len(B); j++ {  
		if A[i].id == B[j].id {  
			resSet.Add(a[i])  
		}  
	}  
}
```
~~~

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

---
:::::::::::::::::::::::::::::::::::::::: {.columns border=off col-count=2 largest-column=firs}

```ad-go
title: count

- count(\*): 不对行数据做解析和判断, 行数+1
- count(1): server拿到innodb返回的行数据, 每行+1, 默认不可能为null, 直接+1
- count(主键): 主键不可能为null, 不判断, 直接+1
- count(普通索引): 是否可以为null, 可以话要先判断
- count(普通列): 全表扫描, 判断是否null
- 性能排序如上
```

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::columnbreak
:::

![[Pasted image 20230710182628.png|555]]

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

---
:::::::::::::::::::::::::::::::::::::::: {.columns border=off col-count=2 largest-column=firs}

```ad-bug
title: 一条语句的更新

- 取id=2数据页是否在内存中
- 更新该行, 写入内存
- 写入redo log(prepare), 写入binlog
- 提交事务接口, 引擎更新redo log(commit)(第二阶段)


![[Pasted image 20230710185124.png|555]]
```

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::columnbreak
:::



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
