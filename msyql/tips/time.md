# time

## sumup

![[Pasted image 20221209163708.png|777]]
## timestamp & datetime

- timestamp
    - 存放和获取都会自动根据时区转换
    - 表的滴一个timestamp列在插入和更新的时候会更新当前时间, 第二timestamp列默认0
    - update_time timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 手动设置
- datetime
	- 不能设置默认值, 要设置时区 
