


shell 工具积累
=============================

查看文件的编码类型
-----------------------------
+ 使用file命令来确定文件编码：
<pre>
$ file -bi gbk.txt
注：由于file命令常常会误判编码，如发现转换出来的编码依然是乱码，可将iconv -f的输入编码换成其他常用编码试试: GBK、BIG5、HZ、GB2312、GB18030、ASCII
</pre>

+ 使用iconv -l确定iconv是否支持此种编码的转换：
<pre>
$ iconv -l | grep ISO-8859-1
ISO-8859-1//
ISO-8859-10//
ISO-8859-11//
ISO-8859-13//
ISO-8859-14//
ISO-8859-15//
ISO-8859-16//
</pre>

+ 转换编码
<pre>
$ iconv -f ISO-8859-1 -t UTF-8 test.txt

+ 列出目录中所有.h 和 .cpp文件的编码类型
<pre>
for f in `find | egrep "h$|cpp$"`;
do
    echo "$f" ' ' `file -bi "$f"`;
done    
</pre>


xargs
-----------------------------
http://man.linuxde.net/xargs
