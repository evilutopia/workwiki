
Red Hat Developer Toolset with scl
---------------------------------------

https://developers.redhat.com/products/developertoolset/hello-world/



前言
CentOS/RHEL Linux 发行版以稳定性著称，所有的软件都要尽可能 stable，导致的一个结果就是基础软件的版本非常的低，比如 CentOS 6.7（15年发布） 中 gcc 版本还是 4.4.7（12年的版本）。这对开发来说就不是很友好，比如我们想用 C++ 11 中的某个特性，就必须自己编译一个高版本的 gcc 出来，但是这会有另外一个问题，开发环境不好维护，如果自己有多台电脑或者多个人合作的项目，每台机器上都要自己编一份，维护起来就比较麻烦。

那么有没有法子像正常的安装 rpm 包一样，yum install 一个呢？有：

自己打个 rpm 包，维护个 yum 源，这个代价太大 ==!；
用别人提供的 rpm 包。
本文介绍的就是第二种，推荐 devtoolset + scl，也是绝配。

devtoolset 是由 Linux @ CERN 维护的，scl 是方便 RedHat Software Collections 软件包使用的工具。

关于 Software Collections RedHat 官方是这样介绍的：

For certain applications, more recent versions of some software components are often needed in order to use their latest new features. Red Hat Software Collections is a Red Hat offering that provides a set of dynamic programming languages, database servers, and various related packages that are either more recent than their equivalent versions included in the base Red Hat Enterprise Linux system, or are available for this system for the first time.

RedHat 推出 Software Collections 的目的就是为了解决前面说的问题，想在 RedHat 系统下能使用新版本的工具，让同一个工具（如gcc）的不同版本能在系统中共存，在需要的时候切换到对应的版本中，是不是有点像 rvm(ruby) 或者 nvm(node)呢，不过这个可是系统级别的哦，对所有软件都适用。
