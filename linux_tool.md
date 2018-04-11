
文件编码
==============================
-------------------------------

+ 查看文件编码
<pre>
file test.txt  
ISO-8859 text, with CRLF line terminators 
</pre>

<pre>
file -bi test.txt
text/x-c; charset=iso-8859-1
</pre>



      iconv命令是运行于linux/unix平台的文件编码装换工具。当我们在linux/unix系统shell查看文本文件时，常常会发现文件的中文是乱码的，这是由于文本文件的编码与当前操作系统设置的编码不同而引起的，这时可以使用iconv进行编码转换，从而解决乱码问题。

解决文本文件乱码问题分3步：1.确定文件编码,2.确定iconv是否支持此编码的转换,3.确定Linux/Unix操作系统编码,4.转换文件编码为与系统编码一致；下面通过对test.txt文件来举例。

 

1、 使用file命令来确定文件编码：

 

Shell代码  收藏代码
file test.txt  
ISO-8859 text, with CRLF line terminators  
  

 

也开始使用如下命令得到更加精确的编码：

 

Shell代码  收藏代码
file -bi test.txt | sed -e 's/.*[ ]charset=//' |tr '[a-z]' '[A-Z'  
ISO-8859-1  
 可见test.txt文件编码为ISO-8859-1编码。

 

2、 使用iconv -l确定iconv是否支持此种编码的转换：

Shell代码  收藏代码
$ iconv -l | grep ISO-8859-1  
ISO-8859-1//  
ISO-8859-10//  
ISO-8859-11//  
ISO-8859-13//  
ISO-8859-14//  
ISO-8859-15//  
ISO-8859-16//  
 

3、 确定Linux/Unix操作系统编码：

Shell代码  收藏代码
$ echo $LANG  
zh_CN.UTF-8  
 当前操作系统坏境编码为"UTF-8"

 

4、 转换编码

     注：由于file命令常常会误判编码，如发现转换出来的编码依然是乱码，可将iconv -f的输入编码换成其他常用编码试试: GBK、BIG5、HZ、GB2312、GB18030、ASCII。

另外：编码转换的时候，如果你的源格式设定为 GB2312 的话，而且在转换成 UTF-8 的时候，发现程序会报“illegal input sequence at position xxxx”的错误。这是由于你之前的做的假定有问题。GB2312 是国标里面一个最小也是最早的中文编码标准。其中，只涵盖了 6,763 个汉字。所以你需要转换的文件的原始的格式可能并不是 GB2312 编码。这个时候，你可以用 GB18030 做为源格式来进行转换。GB18030 是最新的国家标准，包含了 27,564 个汉字，而且向下兼容 GB2312 和 GBK。

假定的字符集指定，上述情况还可以在iconv中加入 -c 选项，忽略无效的字符，也可转换成功。

 

iconv命令用于转换指定文件的编码,默认输出到标准输出设备,亦可指定输出文件。

用法： iconv [选项...] [文件...]

有如下选项可用:

输入/输出格式规范：

-f, --from-code=名称 原始文本编码

-t, --to-code=名称 输出编码

信息：

-l, --list 列举所有已知的字符集

输出控制：

-c 从输出中忽略无效的字符

-o, --output=FILE 输出文件

-s, --silent 关闭警告

--verbose 打印进度信息

-?, --help 给出该系统求助列表

--usage 给出简要的用法信息

-V, --version 打印程序版本号

例子:

iconv -f utf-8 -t gb2312 aaa.txt >bbb.txt

这个命令读取aaa.txt文件，从utf-8编码转换为gb2312编码,其输出定向到bbb.txt文件。

 

附：

文件名转换

因为现在用linux,原来在windows里的文件都是用GBK编码的。所以copy到linux下是乱码，文件内容可以用iconv来转换可是好多中文的文件名还是乱码，找到个可以转换文件名编码的命令，就是convmv。

convmv命令详细参数

例如

convmv -f GBK -t UTF-8 *.mp3

不过这个命令不会直正的转换，你可以看到转换前后的对比。如果要直正的转换要加上参数 --notest

convmv -f GBK -t UTF-8 --notest *.mp3

-f 参数是指出转换前的编码，-t 是转换后的编码。这个千万不要弄错了。不然可能还是乱码哦。还有一个参数很有用。就是 -r 这个表示递归转换当前目录下的所有子目录。

三、更好的傻瓜型命令行工具enca，它不但能智能的识别文件的编码，而且还支持成批转换。

1.安装

$sudo apt-get install enca

2.查看当前文件编码

enca -L zh_CN ip.txt

Simplified Chinese National Standard; GB2312

Surrounded by/intermixed with non-text data

3.转换

命令格式如下

$enca -L 当前语言 -x 目标编码 文件名

例如要把当前目录下的所有文件都转成utf-8

enca -L zh_CN -x utf-8 *

enca -L zh_CN file 检查文件的编码

enca -L zh_CN -x UTF-8 file 将文件编码转换为"UTF-8"编码

enca -L zh_CN -x UTF-8 < file1 > file2 如果不想覆盖原文件可以这样，很简单吧。

 

其实还可以用notepad++转换，notepad++转换非常简单，在windows中，使用Notepad++打开文件格式以后，选择“格式”工具栏，然后可以选择转换为某个格式
