# for update 锁

## for update

> 行级锁, 排他锁, 保证你查询和更新的操作的原子性, 即你查询的这行被人修改不了, ==库存100 & 100-1=99==

- 查询条件包含主键: 锁行, 否则锁表

## 何时使用

- 如订票, 出票时要重新确定有没被其他客户端修改

## 参数

- for update // 阻塞
- for update nowait // 不等待, 提示冲突, 不返回
- for update wait 5 // 等待5s返回
- for update skip locked // 返回结果忽略行锁记录