# tips

## 小命令

### diff
- git show \[hash\] -> 最新的commit相对于倒数第二次commit做了什么改变(就是最新commit的更新内容)
- git diff -> 当前未add相对上一次commit做的改变(现在执行add, 会向暂存区添加什么)
- git diff --cached -> 当前已add未commit相对上一次commit做的改变(现在执行commit, 会提交什么)

### amend
- git commit --amend --only -m 'xxxxxxx' -> 本次commit信息写错需修改
- git commit --amend -> 暂存的内容添加到上一次的提交(已经提交了突然发现还要修改一点, 又不能改了再提交)
- git commit --amend --no-edit -> 使用上一次msg
- git commit --amend -a --no-edit -> -a参数把工作区改动也加入
- git push origin --delete my-branch -> 删除远程分支

### 分支合并
- git reset --hard origin/ORIG_HEAD -> 回退到rebase/merge之前的状态
- git reset --soft dev -> 想要feat分支的所有改变合并为一个去对dev进行mr, 不关心我feat分支的具体commit, 暂存区是相对dev以后的修改内容, 如果是--mixed就是工作区改变
- git merge --squash my-branch -> 一个分支合并成一个提交

### 拉取远程仓库的dev分之到本地
- git fetch origin dev:dev
- git checkout -b dev origin/dev
- git branch --track dev origin/dev

### 想要看和远程分支的某个提交的区别, 去在本地review
- git cherry-pick 5a --no-commit // 拉取提交到本地不暂存不提交



## fast-forward

- head和目标没有分叉, head落后于目标commit, 直接fast
- 远端仓库相比本地有新的提交, 本地的commit远端都包含, 也没有分叉

## 解释

- merge是从分叉开始所有提交的内容生成一个merge的commit到head的下一个commit
- rebase是从分叉开始将自己的所有提交依次从目标的head开始做一个新的提交, rebase结束切到目标分支merge一下, 执行fast使目标head到最新
