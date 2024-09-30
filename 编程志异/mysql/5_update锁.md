# update锁

![[Pasted image 20230129233611.png|777]]

## ov 表中有id=10, 50两条数据

- update的id精准匹配表中的索引: 锁该行
![[Pasted image 20230129233800.png|500]]

- update的id不能精准匹配索引, 锁两索引的间隙
	- 更新id=7, 表中无该记录, insert操作block ==负∞ - 10==
	- 更新id=12, 表无, insert操作block ==10 - 50==
![[Pasted image 20230129234118.png|500]]

- update的id是范围, 锁定所有囊括的间隙和索引值, id >= 8 and id <= 11, 等于8锁负∞-10, 等于11锁10-50, 然后锁8-11, 包含索引10
![[Pasted image 20230129234558.png|500]]