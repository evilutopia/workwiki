

Traffic Control
#

Tutorial
##
http://tldp.org/HOWTO/Traffic-Control-HOWTO/index.html


R:TC 实践
##

REF:http://perthcharles.github.io/2015/06/12/tc-tutorial/

Linux内核支持的常见队列
###

+ pfifo_fast: 先进先出队列

![Missing](https://github.com/evilutopia/workwiki/blob/master/resource/tc-fifo-qdisc.png)

![Missing](https://github.com/evilutopia/workwiki/blob/master/resource/tc-pfifo_fast-qdisc.png)

+ TBF(Token Bucket Filter): 令牌桶过滤器

![Missing](https://github.com/evilutopia/workwiki/blob/master/resource/tc-tbf-qdisc.png)

+ SFQ(Stochastic Fairness Queueing): 随机公平队列

![Missing](https://github.com/evilutopia/workwiki/blob/master/resource/tc-sfq-qdisc.png)

+ HTB(Hierarchy Token Bucket): 分层令牌桶

![Missing](https://github.com/evilutopia/workwiki/blob/master/resource/tc-htb-borrow.png)


TC应用场景
###

<pre>
本节摘抄自Traffic Control HOWTO.

Common traffic control solutions  
  1. Limit total bandwidth to a known rate; TBF, HTB with child class(es).
  2. Limit the bandwidth of a particular user, service or client; HTB classes and classifying with a filter. traffic.
  3. Maximize TCP throughput on an asymmetric link; prioritize transmission of ACK packets, wondershaper.
  4. Reserve bandwidth for a particular application or user; HTB with children classes and classifying.
  5. Prefer latency sensitive traffic; PRIO inside an HTB class.
  6. Managed oversubscribed bandwidth; HTB with borrowing.
  7. Allow equitable distribution of unreserved bandwidth; HTB with borrowing.
  8. Ensure that a particular type of traffic is dropped; policer attached to a filter with a drop action.
实践案例
pfifo_fast
pfifo_fast是系统默认的队列类型，只起到调度的作用，不对数据流量进行控制。
其中pfifo中的p是packet的缩写，表示queue的大小计量单位为packet。
可以通过ip命令查看当前网络队列设置

# ip link list
TBF
TBF队列通过设置令牌的产生速度来限制数据包的发送。

// 在eth0上设置一个tbf队列，网络带宽为200kbit，延迟50ms，缓冲区为1540个字节
// rate表示令牌的产生速率
// latency表示数据包在队列中的最长等待时间
// 对burst参数解释一下：
//   burst means the maximum amount of bytes that tokens can be available for instantaneously.
//   如果数据包的到达速率与令牌的产生速率一致，即200kbit，则数据不会排队，令牌也不会剩余
//   如果数据包的到达速率小于令牌的产生速率，则令牌会有一定的剩余。
//   如果后续某一会数据包的到达速率超过了令牌的产生速率，则可以一次性的消耗一定量的令牌。
//   burst就是用于限制这“一次性”消耗的令牌的数量的，以字节数为单位。
# tc qdisc add dev eth0 root tbf rate 200kbit latency 50ms burst 1540  

# tc qdisc ls dev eth0 // 查看eth0上的队列规则  
SFQ
SFQ队列通过一个hash函数将不同会话(如TCP流)分到不同的FIFO队列中，从而保证
数据流的公平性。

// perturb表示每10秒更新一次hash函数  
# tc qdisc add dev eth0 root sfq perturb 10  
HTB
// handle是一组用户指定的标示符，格式为major:minor。  
// 如果是一条queueing discipline，minor需要一直为0。  
# tc qdisc add dev eth0 root handle 1:0 htb  

// parent指明该新增的class添加到那一个父handle上去  
// classid指明该class handle的唯一ID，minor需要是非零值  
// ceil定义rate的上界  
# tc class add dev eth0 parent 1:1 classid 1:6 htb rate 256kbit ceil 512kbit

// 新建一个带宽为100kbps的root class, 其classid为1:1
# tc class add dev eth0 parent 1: classid 1:1 htb rate 100kbps ceil 100kbps
// 接着建立两个子class，指定其parent为1:1，ceil用来限制子类最大的带宽
# tc class add dev eth0 parent 1:1 classid 1:10 htb rate 40kbps ceil 100kbps
# tc class add dev eth0 parent 1:1 classid 1:11 htb rate 60kbps ceil 100kbps
// 随后建立filter指定哪些类型的packet进入那个class
# tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip src 1.2.3.4 match ip dport 80 0xffff flowid 1:10
# tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip src 1.2.3.4 flow 1:11
// 最后为这些class添加queuing disciplines
# tc qdisc add dev eth0 parent 1:10 handle 20: pfifo limit 5
# tc qdisc add dev eth0 parent 1:11 handle 30: sfq perturb 10
其他
// 同时模拟20Mbps带宽，50msRTT和0.1%丢包率  
# tc qdisc add dev eth5 root handle 1:0 tbf rate 20mbit burst 10kb limit 300000  
# tc qdisc add dev eth5 parent 1:0 handle 10:0 netem delay 50ms loss 0.1 limit 300000  
Rules, Guidelines and Approaches
‘’’
A device can only shape traffic in transmits
HTB is an ideal qdisc to use on a link with a know bandwidth
In theory, the PRIO scheduler is an ideal match for links with variable bandwidth
Sharing/splitting bandwidth based on flows or IP
‘’’

</pre>







R:TC 应用
###

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
###
https://blog.csdn.net/u011641885/article/details/45674633
