# 撤销修改 reset

## sumup

| -       | -                | -               |
| ------- | ---------------- | --------------- |
| --soft  |改动放在暂存区| 撤销commit      |
|--mixed|改动暂存区也取消, 默认的| add |
| --hard  | 改动全部撤销     |硬盘                |

```ad-danger
title: reset
collapse: open

~~~go
git reset --soft 5029f0cc08cf
~~~
```
![[Pasted image 20221222152138.png|500]]

```ad-ex
如果你只是在工作区修改了文件，但没有执行git add命令，那么你可以使用**git checkout – 文件名**来撤销对该文件的修改。

如果你已经将文件添加到索引区，但没有执行git commit命令，那么你需要先使用**git reset HEAD 文件名**来将文件从索引区移除，然后再使用git checkout – 文件名来撤销工作区中的修改

如果你已经将文件提交到仓库，那么你可以使用**git reset --hard HEAD^**来回退到上一个版本，但这会丢失你的所有提交记录
```

## revert

revert就是多做一个commit, 去提交一个反作用的commit, 新增的删掉, 删除的加回来, 建立一个抵消操作的commit
