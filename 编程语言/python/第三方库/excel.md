# excel

```python
_# [{}, {}, {}]_ 

df = pd.DataFrame(ret) _#_ _文件列名_ 

order = ['name', 'user', 'view'] 
df = df[order] #修改列名为中文

columns_map = { 'name': '话题', 'user': '视频量', 'view': '播放量', } 

df.rename(columns=columns_map, inplace=True) 

df.to_excel("./challenge.xlsx", encoding='utf-8', index=False)


# 多sheet写入 
writer = pd.ExcelWriter(filepath) 
companydf.to_excel(excel_writer=writer,sheet_name='公司维度表') 
goodsdf.to_excel(excel_writer=writer, sheet_name='货物维度表') 
writer.save() writer.close()
```