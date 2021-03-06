

git 入门
------------------------------------
https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-%E8%AE%B0%E5%BD%95%E6%AF%8F%E6%AC%A1%E6%9B%B4%E6%96%B0%E5%88%B0%E4%BB%93%E5%BA%93

https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-%E8%BF%9C%E7%A8%8B%E4%BB%93%E5%BA%93%E7%9A%84%E4%BD%BF%E7%94%A8


github
------------------------------------
+ 创建目录
<pre>
NewFIle -> 目录名/文件名称
</pre>
+ 在README中增加图片
<pre>

 我们都知道，当我们在Github中新建一个repository时，一般都会同时创建一个README.md文件，该文件是一个markdown文件，一般用来在你的repository下面说明这个项目的简介。这样会有更多的人来参与了解你的项目。现在我们来实现一下如何在README.md中显示一张图片。

（1）首先在你的本地项目目录下新建一个Screenshots文件夹，用于来存放需要显示的图片，我放入1.png一张图片；

（2）在本地编辑README.md文件，来引用这张图片，引用图片的语法如下：

![Alt text](https://github.com/chenyufeng1991/NewsClient/raw/master/Screenshots/2.png)

我来简单解释一下这个语法：

[Alt text]这里面的文字其实是可选的，如果该图片不能正常显示，那么就会显示[]这里面的文本。

图片链接语法：https://github.com/你的用户名/你的repository仓库名/raw/分支名master/刚你新建的图片文件夹名称/***.png ***.jpg

（3）最后把你的项目提交或者更新到Github上时，Github会自动解析这个语法，并把图片在README.me中显示出来。

<pre>
