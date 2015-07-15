1、Highlight several words in different colors simultaneously
   kamar 
   \M 显示或隐藏标记
   \N 清除标记
   \m 标记
2. 中文编码乱码
a. 文件编码与默认编码不符，文件编码为GBK, 终端编码为utf8 ，可使用iconv进行转换
b. 文件编码识别错误， 如文件编码是utf8 但识别为GBK
   :set fenc?         查看当前编码
   :e! ++enc=utf8     设置当前编码为正确编码
