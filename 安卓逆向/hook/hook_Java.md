# hook_java

## 基本使用

```python
def on_message(message, data):  
    if message['type'] == 'send':  
        print(f'[*] {message["payload"]}')  
    else:  
        print(message)  
  
  
script_text = """  
	js
"""  
  
# 启动方式: 已经启动的app  
process = frida.get_usb_device(-1).attach('com.ex.package')  
script = process.create_script(script_text)  
script.on('message', on_message)  
script.load()  
  
# 启动方式2: hook app启动的阶段  
device = frida.get_usb_device(-1)  
pid = device.spawn(["com.ex.package"])  
process = device.attach(pid)  
script = process.create_script(script_text)  
script.on('message', on_message)  
script.load()  
device.resume(pid)  
  
sys.stdin.read()
```

```js
Java.perform(function() {        
	    console.log('hook start')                
	    var MainActivity = Java.use('com.ex.package.MainActivity')  
        MainActivity.onClick.implementation = function(v) {  
            console.log("log: " + this.m.value)            
			
            this.onClick(v)        
        }                
		
        var tt = Java.use('com.ex.pack.MainActivity$1') // hook匿名类, $1从smali文件名去看
        tt.run.implementation = function(v) {  
			var val = this.this$0.value.外部类的属性名.value // 访问外部类的属性值的固定写法
			console.log("log: " + val)
   
            var ret = this.run(v)        
			console.log(ret) // 验证下返回值
			return ret
        }            

		var stringbuffer = Java.use("java.lang.StringBuffer").$new(构造参数) // js构造java类
    })  
```

- 或者直接使用js编写脚本
```js
1. frida -U 包名 -L js脚本名
2. frida -U -L js脚本 -f com.xx.xx --no-pause
```

- hook函数调用堆栈
```js
function printStack() {
	console.log(
		Java.use("android.util.Log").
		getStackTraceString(Java.use("java.lang.Exception").$new())
	)
}
```

- hook重载方法, overload
```js
var aa = Java.use("")
aa.someMethod.overload("报错出来的选择").implement = function() {}
```
