# Date

> UTC是现在的时间标准, GMT是老标准是格林威治时间, 前者是根据原子钟计算, 后者是地球自转经过0度时刻计算
> ==本地时间 = UTC + 时区==, ==GMT = UTC + 0==, ==CST = UTC + 8==

## API

- 构造函数
```js
var now = new Date() // 无时区国际标准时间对象  
  
// Date.parse()  
var t = new Date(Date.parse("5/23/2019")) // 2019-05-22T16:00:00.000Z  
// “月/日/年”，如"5/23/2019"；  
// “月名 日, 年”，如"May 23, 2019"；  
// “周几 月名 日 年 时:分:秒 时区”，如"Tue May 23 2019 00:00:00 GMT-0700"；  
// ISO 8601 扩展格式“YYYY-MM-DDTHH:mm:ss.sssZ”，如 2019-05-23T00:00:00  

// Date.UTC()  
let allFives = new Date(Date.UTC(2005, 3, 5, 17, 55, 55));  
// 年和月是必须的， 其他可以省略， 就是默认值, 月是零开始， 3=4月
```

- 格式化字符串
```js
 toDateString()显示日期中的周几、月、日、年（格式特定于实现）； 
 toTimeString()显示日期中的时、分、秒和时区（格式特定于实现）； 
 toLocaleDateString()显示日期中的周几、月、日、年（格式特定于实现和地区）； 
 toLocaleTimeString()显示日期中的时、分、秒（格式特定于实现和地区）； 
 toUTCString()显示完整的 UTC 日期（格式特定于实现）
```