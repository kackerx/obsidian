# sync.Map

## 结构

```go
type Map struct { 
	mu Mutex          // 涉及到脏数据(dirty)操作时加锁
	read atomic.Value // readOnly struct
	dirty map[interface{}]*entry // 新加kv的时候会先加入dirty, 所以比read更新, 脏
	misses int                   // read中没读到, 且amended=True, 从dirty读取, misses++, 大于len(dirty)时, read=dirty, 重置misses和dirty
}

type readOnly struct {
	m map[interface{}]*entry
	amended bool // true 表示m的数据不是最新的, dirty数组包含一些m中没有的key
}
```

## sumup

> 采用空间换时间的方式, 冗余了read和dirty两个数据结构

&  syncMap做了一些优化, 可以无锁访问read map, 优先访问read map, read满足就不去操作write map (dirty), 所以发生锁的竞争频率小于map + RWMutex, 所以适合读多写少, 写多的场景会导致read map缓存失效, 加锁, 性能下降

- syncMap有read和dirty(脏)两个数组, 写入map时, read没有就写到dirty数组里1:1, 2:2
- 读k=1发现read数组里没有, misses++, 加锁从dirty数组查找, miss > len(dirty), 会把dirty数据拷贝到read数组, dirty数据清除
- 改为1: 11, 

## ex

sync.map的核心思想就是空间换时间。  
假设现在有个画展对外展示（`read`）n幅画，一群人来看，大家在这个画展上想看什么就看什么，不用等待、不用排队。这时上了副新画，但是由于画展现在在工作时间，不能直接挂上去，而且新画可能还要保养什么，暂时不放在画展（`read`）上，于是就先放在备份的仓库中（`dirty`），如果真有人要看这幅新画，那么只能领他到仓库中（`dirty`）中去看，假设这时来了个新画，此时仓库中有n+1副画了，这时有人来问：有没有这幅新画呀，经理说：有，你和我到仓库中去看下。这时又有人来问：有没有这幅新画呀，经理说：有，你和我到仓库中去看下。当问有没有这幅新画的次数达到了n+1的时候，这时画展的老板发现这幅新画要看的人还不少。于是对经理说：你去看下，等下没人看画展（`read`）的时候，把画展（`read`）的画全部下掉，把仓库（dirty）里面的画全部换上。当经理全部换结束后，此时画展（`read`）上已经是最全最新的画了。  
sync.map的原理大概就类似上面的例子，在少量人对新画(`新的k、v`)感兴趣的时候，就带他去仓库（`dirty`）看，此时因为经理只有一个，所以每次只能带一个人（`加锁`），效率低，其他的画，在画展（`read`）上，随便看，效率高。