# rebase 

## sumup

![[Pasted image 20221221120800.png|777]]

- 以和目标分支的公共祖先(c1)为起点所做的每个提交c2, c3, c4暂存
- 以目标分支指向的为起点(c6), 分别添加提交c2', c3', c4'
- 最后特性分支和目标分支是一条直线, 最终merge和rebase的文件都是相同的

## 交互式rebase -i master

![[Pasted image 20221221122404.png|777]]

- squash -> 整合前一个commit
- drop -> 丢弃提交
	- pick -> 默认, 可修改顺序
- 调整修饰本地commit, -i HEAD~6, 去合并和删除

## rebase远程分支

- git rebase origin/dev
- fix CONFLICT
- git add -A
- git rebase --continue
