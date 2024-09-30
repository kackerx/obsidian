# ast [[ast.canvas]]

## API

- 使用`token.NewFileSet`创建FileSet
- 使用`parser.ParseFile`解析源码, 指定mode
- 实现`ast.Vistor`接口, 作为遍历ast的handler, 读取篡改ast树
- `ast.Walk`开始遍历ast

## 节点的分类

### 三个关键子接口

- 表达式: Expr, 内置类型, 方法调用, 数组索引
- 语句: Stmt, 赋值语句, if语句
- 声明: Decl, 各种声明

![[Pasted image 20221231203655.png|555]]

