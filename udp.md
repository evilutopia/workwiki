
=== igmp

https://network.51cto.com/art/201901/590835.htm

<pre>
https://www.cisco.com/c/zh_cn/support/docs/ip/ip-multicast/13726-57.html


https://www.cisco.com/c/en/us/support/docs/ip/ip-multicast/119383-technote-ip-multicast-00.html


You can generate a multicast stream using your switches on one end.

# ip sla 1

# udp-echo 224.1.1.1 12345 source-ip x.x.x.x control disable

# frequency 2

# timeout 0

# ip sla schedule 1 start-time now

Then on other end, join the multicast group

# int xxx

# ip igmp join-group 224.1.1.1


udp-echo 232.1.1.1 5521 source-ip x.x.x.x control disable

ip igmp join-group 232.1.1.1 source x.x.x.x

</pre>

=== socket option

https://docs.microsoft.com/en-us/windows/win32/winsock/ipproto-ip-socket-options
