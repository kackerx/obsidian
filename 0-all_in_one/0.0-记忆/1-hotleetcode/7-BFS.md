#算法 

--- start-multi-column: ID_2cos
```column-settings
Number of Columns: 2
Largest Column: standard
Border: off
Shadow: off
```

### 752 - 打开转盘锁/M
![[Pasted image 20240913233259.png|577]]
?
```go
func openLock(deadends []string, target string) int {
	visited := make(map[string]bool)
	for _, deadend := range deadends {
		visited[deadend] = true
	}

	if visited["0000"] {
		return -1
	}

	q := &queu{"0000"}
	step := 0
	for !q.IsEmpty() {
		sz := q.Len()
		for i := 0; i < sz; i++ {
			cur := q.Get()

			if cur == target {
				return step
			}

			for j := 0; j < 4; j++ {
				up := plusOne(cur, j)
				if !visited[up] {
					q.Put(up)
					visited[up] = true
				}

				down := minusOne(cur, j)
				if !visited[down] {
					q.Put(down)
					visited[down] = true
				}
			}
		}

		step++
	}

	return -1
}

func plusOne(s string, j int) string {
	bs := []byte(s)
	if bs[j] == '9' {
		bs[j] = '0'
	} else {
		bs[j]++
	}
	return string(bs)
}

func minusOne(s string, j int) string {
	bs := []byte(s)
	if bs[j] == '0' {
		bs[j] = '9'
	} else {
		bs[j]--
	}
	return string(bs)
}
```

--- column-break ---



--- end-multi-column