# rebase

## 理解

![[Pasted image 20221221120800.png|500]]
- b rebase a
- a和b分支开始的b的每一个commit, b1&b2, 以目标分支的最后一个commit, a2为起点, 分别做b1', b2'提交
- 可以选择使用rebase -i去决定丢弃还是合并b分支的commit



- 公共开发分支rebase, 合并自己的可以用merge

![[Pasted image 20230505175946.png]]