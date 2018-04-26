

Traffic Control
=======================================================

Tutorial
-------------------------------------------------------
http://tldp.org/HOWTO/Traffic-Control-HOWTO/index.html


R:TC 实践
-------------------------------------------------------
http://perthcharles.github.io/2015/06/12/tc-tutorial/





R:TC 应用
-------------------------------------------------------

+ 模拟网络时延
<pre>
增加网络时延
sudo tc qdisc add dev eth0 root netem delay 1000ms
删除策略：
sudo tc qdisc del dev eth0 root netem delay 1000ms

修改丢包率：
sudo tc qdisc add dev eth0 root netem loss 10%
删除策略：
sudo tc qdisc del dev eth0 root netem loss 10%
</pre>



pfifo_fast队列详解
-------------------------------------------------------
https://blog.csdn.net/u011641885/article/details/45674633
