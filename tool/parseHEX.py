import sys
import os
import pandas as pd
import json
class ParseHex:
    """
    读写ROM HEX文件(quartus HEX文件地址和IntelHex文件的规定不太一样)
    """
    def __init__(self,hexFile=None,mapFile="map.json"):
        with open("map.json","r") as f:
            self._map = json.load(f)
        if  hexFile:
            self.loadHex(hexFile)
            self.LastLine = ":00000001FF"
        else:
            self.lines = None
            self.txt = None
            self.LastLine = ":00000001FF"
   

    def parseCode(self,code):
        _dict = self._map
        R = _dict["mapR"]
        Pos = _dict['mapNum']
        Opt = _dict['mapOpt']
        code = code.strip()
        codeHex = []
        for line in code.splitlines():
            words = line.split(" ")
            opt = Opt[words[0]]
            positions = Pos[words[0]]
            del words[0]
            opts = ["000","000","000"]
            for num,pos in zip(words, positions):
                opts[pos] = R[num]
            codeBinLine = opt+"0"+"".join(opts)
            codeHex.append("{:04X}".format(int(codeBinLine,2)))
            print("{} : {:04X}".format(line,int(codeBinLine,2)))
        return codeHex
    
    def string2code(self,codestring):
        return self.parseCode(codestring)
        
    def string2hex(self,codestring,hexFile):
        codeHex = self.string2code(codestring)
        txt = codeHex
        if len(txt)<256:
            for i in range(len(txt), 256):
                txt.append("0"*6)
        for i in range(len(txt)):
            txt[i] = int(txt[i],16)
        Hex = list()
        for i in range(0, 256):
            newLineToBeChecked = "02"+"{:04X}".format(i)+"00"+"{:04X}".format(txt[i])
            newLine = ":"+newLineToBeChecked+self.check(newLineToBeChecked)[-2:]
            Hex.append(newLine)
        Hex.append(self.LastLine)
        with open(hexFile,"w") as f:
            for hexLine in Hex:
                f.writelines(hexLine+"\n")
        return self
        
    def loadHex(self,file):
        with open(file) as f:
            self.lines = f.readlines()
            if len(self.lines[-1])!=18:
                self.lastLine = self.lines[-1]
                self.lines.pop()
            self.txt = self.loadTXT(self.lines)
        return self
            
    def loadTXT(self,lines):
        self.txt = list()
        for line in lines:
            self.txt.append(line[9:9+6])
        return self.txt
    
    def txt2hex(self, txtFile, hexFile=None):
        with open(txtFile) as txtF:
            txt = txtF.readlines()
        return self.list2hex(txt)
    
    def list2hex(self, txt, hexFile):
        if len(txt)<128:
            for i in range(len(txt), 128):
                txt.append("0"*6)
        for i in range(len(txt)):
            txt[i] = int(txt[i],16)
        Hex = list()
        for i in range(0, 128):
            newLineToBeChecked = "03"+"{:04X}".format(i)+"00"+"{:06X}".format(txt[i])
            newLine = ":"+newLineToBeChecked+self.check(newLineToBeChecked)[-2:]
            Hex.append(newLine)
        Hex.append(self.LastLine)
        if not hexFile:
            hexFile = txtFile+".hex"
        with open(hexFile,"w") as f:
            for hexLine in Hex:
                f.writelines(hexLine+"\n")
        return 
    
    def csv2hex(self,inputCSV,outputHEX):
        originCSV = pd.read_csv(inputCSV)
        proCSV = originCSV.iloc[:,1:-1]
        
        map_A89 = self._map['map_A89']
        map_A = self._map['map_A']
        map_B = self._map['map_B']
        map_C = self._map['map_C']

        reverse_A = {x[1]:x[0] for x in map_A.items()}
        reverse_B = {x[1]:x[0] for x in map_B.items()}
        reverse_C = {x[1]:x[0] for x in map_C.items()}
        reverse_A89 = {x[1]:x[0] for x in map_A89.items()}
        x = [reverse_A,reverse_B,reverse_C,reverse_A89]
        for dict_ in x:
            if '000' in dict_.keys():
                dict_['0'] = dict_['000']
            print(dict_)

        #for line in c.iloc[1,:].to_dict()

        txt = []
        for i in range(len(proCSV)):
            line = proCSV.iloc[i,:].to_dict()
            l = {x[0]:str(x[1]) for x in line.items()}
            #print(l)
            txtline = l['S3']+l['S2']+l['S1']+l['S0']+l['M']+l['CN']+l['WE']+reverse_A89[l['A9']]+reverse_A[l['A']]+reverse_B[l['B']]+ reverse_C[l['C']]+"{:06b}".format(int(l['UA5-UA0'],8))
            txt.append("{:06X}".format(int(txtline,2)))

        self.list2hex(txt,outputHEX)
        return self
        
    def __call__(self):
        return self.toPd()
    
    def check(self,DD):
        """
        输出一行的校验和
        """
        length=len(DD)  #求长度
        #print(DD)
        #创建一个list，将传入的str的每两个数合在一起，再求和
        list1=[]
        if(length%2==1):    #如果str长度为单数，则抛出错误
            print('[!] 数据长度有误')
        else:   
            for i in range(0, length, 2):  #range（开始，结束-1，每次加多少）  这里即0——length-1  每次循环i+2
                hex_digit=DD[i:i + 2]      #将传入的str的每两个数合在一起
                list1.append('0x'+hex_digit)    #再每个字符前+0x  但是它仍然是字符，但更便于下面通过int(list1[i], 16)转换成16进制
    #     print(list1)

        sum=0
        for i in range(int(length/2)):   #求和
            sum=int(list1[i], 16)+sum      #int(list1[i], 16)将16进制转换成10进制 int类型
        sum=sum%256
        sum=256-sum
        return "{:02X}".format(sum)   #将sum和结果转换成16进制  hex(sum)

    
    def toPd(self,txt=None):
        if not txt:
            txt = self.txt
        df = self.parse(txt[0])
        for i in range(1,len(txt)):
#     print('{:02o}'.format(i))
            df = df.append(self.parse(txt[i],'{:02o}'.format(i)))
        return df
    
    def getTXT(self):
        return self.lines
    

    def parse(self,A,index=0):
        """
        将数据段解析成列表
        """
        if type(A)==str:
            A = int(A,16)
        B = '{:024b}'.format(A)
        d ={
            'S3':B[0],
            'S2':B[1],
            'S1':B[2],
            'S0':B[3],
            'M':B[4],
            'CN':B[5],
            'WE':B[6],
            'A9':B[7],
            'A8':B[8],
            'A':B[9:12],
            'B':B[12:15],
            'C':B[15:18],
            'UA5-UA0':B[18:],
            'origin':'{:06X}'.format(A)
        }
        map_A89 = self._map['map_A89']
        map_A = self._map['map_A']
        map_B = self._map['map_B']
        map_C = self._map['map_C']
#         map_A89={
#             '00':'SW_B',
#             '01':'RAM_B',
#             '10':"LED_B",
#             "11":"no"
#         }
#         map_A={
#             "000":"000",
#             "001":"LDRI",
#             "010":"LDDR1",
#             "011":"LDDR2",
#             "100":"LDIR",
#             "101":"LOAD",
#             "110":"LDAR",
#             "111":"111"
#         }
#         map_B={
#             "000":"000",
#             #'001':"R0_B",
#             #"010":"R1_B",
#             #"011":"R2_B",
#             "001":"RS_B",
#             "010":"RD_B",
#             "011":"RI_B",
#             "100":"SHE_B",
#             "101":"ALU_B",
#             "110":"PC_B",
#             "111":"111"
#         }
#         map_C={
#             "000":"000",
#             "001":"P(1)",
#             "010":"P(2)",
#             "011":"P(3)",
#             "100":"P(4)",
#             "101":"AR",
#             "110":"LDPC",
#             "111":"111"
#         }
        d_doc = d
        #print("{} {}".format(d_doc["A9"],d_doc['A8']))
        d_doc['A9'] = map_A89[d_doc['A9']+d_doc['A8']]
        d_doc['A8'] = d_doc['A9']
        d_doc['A'] = map_A[d_doc['A']]
        d_doc['B'] = map_B[d_doc['B']]
        d_doc['C'] = map_C[d_doc['C']]
        d_doc["UA5-UA0"]="{:02o}".format(int(d['UA5-UA0'],2))
        self.d_doc = d_doc
        return pd.DataFrame(d_doc,index=[index])