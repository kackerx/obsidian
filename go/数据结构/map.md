# map

![[Pasted image 20221108002816.png|500]]

## 数据结构

```go
type hmap struct {
	count     int              // 当前哈希表中元素的数量
	flags     uint8            
	B         uint8            // len(buckets) == 2^B
	noverflow uint16           // 使用溢出桶的数量
	hash0     uint32

	buckets    unsafe.Pointer
	oldbuckets unsafe.Pointer  // 扩容时保存之前buckets的字段, 大小是当前buckets的一半
	nevacuate  uintptr

	extra *mapextra
}

type mapextra struct {
	overflow    *[]*bmap
	oldoverflow *[]*bmap
	nextOverflow *bmap
}

// 桶bucket
type bmap struct {
	tophash [bucketCnt]uint8
}

// 桶bucket编译期重构
type bmap struct {
    topbits  [8]uint8
    keys     [8]keytype
    values   [8]valuetype
    pad      uintptr
    overflow uintptr
}
```

![[Pasted image 20221108003540.png|500]]
- 每个桶(bmap)中存储8个kv, 单个桶装满时(超过8个)使用extra.nextOverflow存储溢出的数据来避免扩容

## 读写

![[Pasted image 20221108004731.png|500]]
- hash最底几位用于选择桶号, 高8位用于加速访问: 桶tophash与key的tophash匹配后, 比较keys[0]和key, 相等返回values[0]

## 扩容

- 装载因子超过6.5 = count / (2^B) = 翻倍扩容
- 哈希使用了太多的溢出桶 = 等量扩容
![[Pasted image 20221108005354.png|700]]
- 创建一组新桶和预创建的溢出桶, oldbuckets指向原桶数组, buckets指向新桶数组, extra溢出桶使用相同逻辑
- 我们简单总结一下哈希表扩容的设计和原理，哈希在存储元素过多时会触发扩容操作，每次都会将桶的数量翻倍，扩容过程不是原子的，而是通过 `runtime.growWork`增量触发的，在扩容期间访问哈希表时会使用旧桶，向哈希表写入数据时会触发旧桶元素的分流。除了这种正常的扩容之外，为了解决大量写入、删除造成的内存泄漏问题，哈希引入了 `sameSizeGrow` 这一机制，在出现较多溢出桶时会整理哈希的内存减少空间的占用。

## 图示

![[Pasted image 20221109094302.png|700]]

## 总结

Go 语言使用拉链法来解决哈希碰撞的问题实现了哈希表，它的访问、写入和删除等操作都在编译期间转换成了运行时的函数或者方法。哈希在每一个桶中存储键对应哈希的前 8 位，当对哈希进行操作时，这些 `tophash` 就成为可以帮助哈希快速遍历桶中元素的缓存。

哈希表的每个桶都只能存储 8 个键值对，一旦当前哈希的某个桶超出 8 个，新的键值对就会存储到哈希的溢出桶中。随着键值对数量的增加，溢出桶的数量和哈希的装载因子也会逐渐升高，超过一定范围就会触发扩容，扩容会将桶的数量翻倍，元素再分配的过程也是在调用写操作时增量进行的，不会造成性能的瞬时巨大抖动。