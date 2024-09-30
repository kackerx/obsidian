# casbin.org

## PERM元模型

 - Polico策略: ``p = {sub, obj, act, eft=allow}``, 各种策略一般存储到数据库(很多条)

 - Matchers匹配规则:  `m = r.sub == p.sub && r.act == p.act && r.obj == p.obj`

 - Request: 请求类型, `r = {sub, obj, act}`

 - role_def: 角色域, 
    - g = \_, \_ 表示以角色为基础
    - g = \_, \_, \_ 表示以域为基础(多商户模式) 

 - Effect影响: 只有以下四种情况
![[Pasted image 20221223215313.png|500]]

## 角色域

- 设置了g = \_, \_后, Matchers里会有一条规则: `g(r.sub == p.sub)`, 把用户替换成具体的角色
```js
p(策略): p, alice, data1, read
p(策略): p, bob, data2, write
p(策略): p, data2_admin, data2, read
p(策略): p, data2_admin, data2, write

p(策略): g, alice, data2_admin // alice替换角色data2_admin

---

r(请求): alice data2 read // true, 匹配规则3

---

如果要加入root超管
[matchers]
m = r.sub == p.sub && r.obj == p.obj && r.act == p.act || r.sub == "root"

```
