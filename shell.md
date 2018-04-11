


shell 工具积累
=============================

查看文件的编码类型
-----------------------------
<pre>
for f in `find | egrep "h$|cpp$"`;
do
    echo "$f" ' ' `file -bi "$f"`;
done    
</pre>
