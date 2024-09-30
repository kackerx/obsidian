# JOIN执行逻辑

## Index Nested-Loop Join -> NLJ
![[Pasted image 20230314140716.png|555]]
![[Pasted image 20230313181143.png|700]]
- a上有索引的情况, 驱动表t1扫描了100rows(全表扫描), 每次从t1取一行去t2(被驱动表)中匹配
- 这种嵌套查询且被驱动表可以用上索引的称之为NLJ
- 小表驱动大表

### 优化 -> Batched Key Access
- 结合mrr优化, NLJ把要驱动表符合条件的查询一次性拿出放入join_buffer

## Simple Nested-Loop Join
- 如果被驱动表的联结字段没有索引, a表和b表都要全表扫描, MxN, 笛卡尔积性能太差, Mysql也没采用, 而是优化了BLJ

## Block Nested-Loop Join, 分块去join, join_buffer_size -> BNL
![[Pasted image 20230313181908.png|700]]
- 同样的被驱动表没有可用的索引
- 会把驱动表t1数据读入线程内存join_buffer
- 扫描被驱动表t2, 全表和join_buffer中数据对比
- 和SNLJ是一样的扫描量, 但由于block在内存中, 速度性能更好, 同样最好也是小表驱动大表


理论上没有用到<mark class="hltr-pink">Index Nested-Loop Join</mark>的都要优化, 即join的字段要索引

### 优化 -> 临时小表+联合字段索引+bka优化
- create table tmp_t()
- insert into tmp_t
- join tmp_t
