## Whistle

```ad-go
~~~go
# 域名代理转发到本地
# https://testing-private-api.mihoyo.com/fbi/ http://127.0.0.1:8900/fbi/

# 直接的host配置替换
# 127.0.0.1:8900 testing-private-api.mihoyo.com

# 端口转发, 3000端口转发到3001
# dev.jd.com:3001 dev.jd.com:3000

# 查看域名控制台
# https://devop.mihoyo.com/ log://

# 替换本地文件
# https://webstatic.mihoyo.com/upload.js file:///Users/mi_kaixuan.wang/k/goo/goo/test.js

# 修改请求参数
# www.ifeng.com urlParams://(test=1)

# 注入 JS
# ``` wise.js
# ;console.log('=====wisewrong=====');
# ```
# www.zhihu.com jsPrepend://{wise.js} # jsAppend, resAppend
# 或, test.js是values目录中
# https://wq.jd.com js://{test.js}

# 正则匹配, 域名中带有pool的, 替换host为本地地址
# /.*?(pool).*?/i host://127.0.0.1:8900

# 通配符匹配
^*://**/fbi/**pool** host://127.0.0.1:8900

# 修改ua
# ke.qq.com ua://{test_ua}

# 隐藏某域名的请求
# /devop.mihoyo.com/ filter://hide

```

