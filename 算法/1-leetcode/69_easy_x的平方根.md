:::::::::::::::::::::::::::::::::::::::: {.columns border=off col-count=2 largest-column=firs}

```go
func MySqrt(x int) int { // 二分查找缩小范围
	l := 0
	r := x

	for l <= r {
		if r-l <= 1 { // 只剩两个值, l和mid会相同无限循环, 跳出选择
			return If(r*r > x, l, r)
		}

		mid := (l + r) / 2
		if mid*mid == x {
			return mid
		} else if mid*mid > x {
			r = mid - 1
		} else {
			l = mid
		}
	}

	return l
}
```

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::columnbreak
:::

~~~ad-tips
title: undefined

- 缩小范围
~~~

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
