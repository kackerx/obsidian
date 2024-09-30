# 七种join

![[Pasted image 20230115015658.png|777]]
![[Pasted image 20230115141334.png|777]]

## inner join -> 符合条件的才有结果

```sql
select *  
from tbl_dept as t1  
join tbl_emp t2 on t1.id = t2.deptId;
```
![[Pasted image 20230115141148.png|555]]

## left join -> 左表全部显示, 右表没有对应的就全null

```sql
select *  
from tbl_dept as t1  
left join tbl_emp t2 on t1.id = t2.deptId;
```
![[Pasted image 20230115141441.png|555]]

## 左表独有 -> 左表left右表, 加上b.id is null, 就是a独有

```sql
select *  
from tbl_dept as t1  
left join tbl_emp t2 on t1.id = t2.deptId  
where t2.id is null
```
![[Pasted image 20230115141913.png|555]]

## 左表独有 + 右表独有(并集去掉交叉部分) -> 使用union连接两个左独和右独两个select, 两个select分别要有a.id is null和b.id is null

## 并集 -> 上一条去掉is null条件, 就是全部结果