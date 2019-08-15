网络问题排查工具

nethogs: 按进程查看流量占用

iptraf: 按连接/端口查看流量

ifstat: 按设备查看流量

ethtool: 诊断工具

tcpdump: 抓包工具

ss: 连接查看工具

其他: dstat, slurm, nload, bmon

netstat

#  udp to tcp 
nc -v -u -l -p 3333 | nc -v 127.0.0.1 50000

socat -v UDP-LISTEN:3333,fork TCP:localhost:50000


<pre>

I suspect your problem is more because whatever sends the UDP packets is not adding a newline character the commands (as in they should send "play\n" and not just "play").

In any case, if you want a new TCP connection to be created for each of the UDP packets, you should use udp-recvfrom instead of udp-listen in socat:

socat -u udp-recvfrom:3333,fork tcp:localhost:50000
Then every UDP packet should trigger one TCP connection that is only brought up to send the content of the packet and then closed.

Test by doing:

echo play | socat -u - udp-sendto:localhost:3333
(which sends a UDP packet whose payload contains the 5 bytes "play\n").

https://unix.stackexchange.com/questions/267118/create-udp-to-tcp-bridge-with-socat-netcat-to-relay-control-commands-for-vlc-med
</pre>
