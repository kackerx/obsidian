# Multi-Range Read

## ov
![[Pasted image 20230314135923.png|555]]
- 回表是一行行的搜索主键索引, 非批量
- 所以根据索引a取到的记录放入<mark class="hltr-pink">read_rnd_buffer</mark>
- 在<mark class="hltr-pink">read_rnd_buffer</mark>中根据id递增排序, 根据排序后的主键id回表, 提高性能
- 需要的是索引a上做范围多值集查询
![[Pasted image 20230314140504.png|700]]
