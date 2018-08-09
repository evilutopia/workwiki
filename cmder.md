

cmder slow
----------------------------------------------
https://github.com/cmderdev/cmder/issues/993

<pre>
I'm not sure if I had the same exact issue, but I experienced the same thing you described whenever I was connected to a remote VPN. Disconnecting from the VPN resolved the issue, but obviously that's not a viable solution.

What seems to be working for me now:

 mkpasswd -l -c > C:\cmder\vendor\git-for-windows\etc\passwd
 mkgroup -l -c > C:\cmder\vendor\git-for-windows\etc\group
Then, in C:\cmder\vendor\git-for-windows\etc\nsswitch.conf:

# Begin /etc/nsswitch.conf

passwd: files # db
group: files # db

db_enum: cache builtin

db_home: env windows cygwin desc
db_shell: env windows # cygwin desc
db_gecos: env # cygwin desc

# End /etc/nsswitch.conf
The change here was that I commented out the db portion under passwd (I think group had that there already). Now, everything seems to be running quickly again.
</pre>
