:::::::::::::::::::::::::::::::::::::::: {.columns border=off col-count=2 largest-column=firs}

~~~ad-primary
title: 三颜色分类, 三路排序法

```go
func color(nums []int, l, r int) {
	lt := -1
	gt := r + 1
	i := 0

	for i < gt {
		if nums[i] < 1 {
			lt++
			nums[lt], nums[i] = nums[i], nums[lt]
			i++
		} else if nums[i] == 1 {
			i++
		} else {
			gt--
			nums[gt], nums[i] = nums[i], nums[gt]
		}
	}
}
```
~~~

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::columnbreak
:::

![[Pasted image 20230409210137.png|555]]
- 三个区间, [0, lt] < v, [lt+1, i-1] = v, [gt, r] > v
- 得出初始值, lt = -1, gt = r+1, 循环终止 i < gt
- <1, =\=1, >1 三指针分别如何运动

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
