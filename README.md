# 16bit_computer
16bit_computer with stack
> 在复杂模型机基础上 增加了总线位数/扩展ALU/重写微控制器/增加寄存器(4to8)/重写ROM/增加SP寄存器实现简单FILO/
> 优点: 实现 1.理论扩展指令条数至2^6 2.8寄存器 3.实现部分指令采用三操作数(ADD R0 R2 R3)
> 缺点: 受限于lpm_rom0，ROM字大小仍为24bit，地址存在不足的情况
# 致谢
**感谢郑佳祺学长的部分源码和修改建议**

# tool 使用说明
## 建议在jupyter环境下使用
### 导入
	```python
		from fuckhex import FuckHex as parseHex
		a = parseHex()
	```
### code2hex(汇编代码 to hex 文件)
	```python
code = """
IN R1
IN R2
ADD R4 R1 R2
OUT R4
CLR R2
OUT R2
MOV R3 R4
OUT R3
IN R6
SET R6
PUSH R3
PUSH R1
POP R2
OUT R2
HALT 
"""
a.string2hex(code,r"code.hex")
	```
> IN R1 : 1040
> IN R2 : 1080
> ADD R4 R1 R2 : 250A
> OUT R4 : 1404
> CLR R2 : 1C80
> OUT R2 : 1402
> MOV R3 R4 : 20E0
> OUT R3 : 1403
> IN R6 : 1180
> SET R6 : 8806
> PUSH R3 : 8003
> PUSH R1 : 8001
> POP R2 : 8480
> OUT R2 : 1402
> HALT : 1800

### ROM hex代码可视化
```python
a.loadHex(r"complex.hex)
a() # a() 为dataFrame()格式,在jupyter中显示比较清晰，也可导出到csv文件中
#a().tocsv("test.csv")
```
### csv2hex (csv 文件 to hex 文件,只支持解析可视化hex文件中导出的csv文件，请在导出后修改）
```python
a.csv2hex("test.csv",r"complex.hex").loadHex(r"complex.hex").toPd() # csv2hex+load hex +hex代码可视化
```







