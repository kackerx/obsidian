# Binlog-归档日志

## ov

```ad-tips
server产生的逻辑日志, 而<mark class="hltr-pink">redo_log</mark>是innodb的物理日志, 保证持久性, <mark class="hltr-pink">undo_log</mark>是innodb产生的逻辑日志保证原子性和隔离性
```

## 录入格式

- statement: 每一条修改数据的sql都会记录binlog不需要记录每一行的变化, 减少日志量, 节约io提高性能, 要保存相关执行上下文
- row: 不记录sql语句上下文, 记录单元为每一行的改动, 基本全量记录, 但很多操作会大量改动如alter table, 日志量太大
- mixed: 折中方案, 普通操作使用statement, 无法使用切换row