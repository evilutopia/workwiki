
死锁
--------------------------------------------------
<pre>
GDB shows that thread 69 and 96 are deadlocked.

12345678901234567890123456789012345678901234567890123456789012345678901234567890

[Switching to thread 69 (Thread 0x7fcb3c0ea700 (LWP 19566))]#0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:136
136	2:	movl	%edx, %eax
(gdb) bt
#0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:136
#1  0x00007fcb3fa193a3 in _L_lock_892 () from /lib64/libpthread-2.12.so
#2  0x00007fcb3fa19287 in __pthread_mutex_lock (mutex=0x7fca2829a220) at pthread_mutex_lock.c:82
#3  0x00000000004712e5 in ast_channel_by_uniqueid_cb (obj=0x7fca2829a278, arg=0x7fcb0004bec9, data=<value optimized out>, flags=<value optimized out>) at channel.c:1528
#4  0x0000000000447742 in internal_ao2_callback (c=0x1fd3e58, flags=0, cb_fn=<value optimized out>, arg=0x7fcb0004bec9, data=0x7fcb3c0e8d98, type=WITH_DATA, tag=0x0, 
    file=0x0, line=0, func=0x0) at astobj2.c:1081
#5  0x0000000000447ca1 in __ao2_callback_data (c=<value optimized out>, flags=<value optimized out>, cb_fn=<value optimized out>, arg=<value optimized out>, 
    data=<value optimized out>) at astobj2.c:1201
#6  0x000000000047568c in ast_channel_get_by_name_prefix (name=0x7fcb0004bec9 "SIP/sansay-sd-0000301a") at channel.c:1638
#7  ast_channel_get_by_name (name=0x7fcb0004bec9 "SIP/sansay-sd-0000301a") at channel.c:1643
#8  0x00007fcb3dff239f in action_add_agi_cmd (s=0x7fcb3c0e9b10, m=0x7fcb3c0e9260) at res_agi.c:1172
#9  0x00000000005075e4 in process_message (s=0x7fcb3c0e9b10, m=0x7fcb3c0e9260) at manager.c:5123
#10 0x000000000050a1fe in do_message (data=0x7fcb20000948) at manager.c:5336
#11 session_do (data=0x7fcb20000948) at manager.c:5451
#12 0x00000000005613f9 in handle_tcptls_connection (data=0x7fcb20000948) at tcptls.c:272
#13 0x000000000056e2bb in dummy_start (data=<value optimized out>) at utils.c:1028
#14 0x00007fcb3fa17851 in start_thread (arg=0x7fcb3c0ea700) at pthread_create.c:301
#15 0x00007fcb40f8911d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:115
(gdb) fr 3
#3  0x00000000004712e5 in ast_channel_by_uniqueid_cb (obj=0x7fca2829a278, arg=0x7fcb0004bec9, data=<value optimized out>, flags=<value optimized out>) at channel.c:1528
1528		ast_channel_lock(chan);
(gdb) p chan
$1 = (struct ast_channel *) 0x7fca2829a278
(gdb) fr 2
#2  0x00007fcb3fa19287 in __pthread_mutex_lock (mutex=0x7fca2829a220) at pthread_mutex_lock.c:82
82	      LLL_MUTEX_LOCK (mutex);
(gdb) p *mutex
$2 = {__data = {__lock = 2, __count = 1, __owner = 24649, __nusers = 1, __kind = 1, __spins = 0, __list = {__prev = 0x0, __next = 0x0}}, 
  __size = "\002\000\000\000\001\000\000\000I`\000\000\001\000\000\000\001", '\000' <repeats 22 times>, __align = 4294967298}

So, in the agi thread we're blocked on ast_channel_lock(chan) while holding
a lock on the ao2_container *channels object during internal_ao2_callback().

The mutex owner is 24649 which is thread 96:

(gdb) thr 96
[Switching to thread 96 (Thread 0x7fcacabbb700 (LWP 24649))]#0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:136
136	2:	movl	%edx, %eax
(gdb) bt
#0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:136
#1  0x00007fcb3fa193a3 in _L_lock_892 () from /lib64/libpthread-2.12.so
#2  0x00007fcb3fa19287 in __pthread_mutex_lock (mutex=0x1fd3e00) at pthread_mutex_lock.c:82
#3  0x000000000047e648 in ast_do_masquerade (original=0x7fca2840b9d8) at channel.c:6861
#4  0x000000000051b129 in ast_async_goto (chan=0x7fca2829a278, context=0x7fca2829b0c8 "ivr", exten=0x7fcb3d72b0de "fax", priority=1) at pbx.c:9517
#5  0x00007fcb3d6b5773 in sip_read (ast=0x7fca2829a278) at chan_sip.c:8410
#6  0x0000000000484e88 in __ast_read (chan=0x7fca2829a278, dropaudio=0) at channel.c:4016
#7  0x0000000000489b13 in ast_read (c0=0x7fca29178e18, c1=0x7fca2829a278, config=0x7fcacabb4b90, fo=0x7fcacabb4ac8, rc=0x7fcacabb4ac0) at channel.c:4370
#8  ast_generic_bridge (c0=0x7fca29178e18, c1=0x7fca2829a278, config=0x7fcacabb4b90, fo=0x7fcacabb4ac8, rc=0x7fcacabb4ac0) at channel.c:7563
#9  ast_channel_bridge (c0=0x7fca29178e18, c1=0x7fca2829a278, config=0x7fcacabb4b90, fo=0x7fcacabb4ac8, rc=0x7fcacabb4ac0) at channel.c:8023
#10 0x00000000004c3736 in ast_bridge_call (chan=0x7fca29178e18, peer=0x7fca2829a278, config=0x7fcacabb4b90) at features.c:4464
#11 0x00000000004c5c7c in bridge_exec (chan=0x7fca29178e18, data=<value optimized out>) at features.c:8301
#12 0x000000000051b8a4 in pbx_exec (c=0x7fca29178e18, app=0x2029580, data=0x7fcb0001408c "SIP/sansay-sd-00003082,kK") at pbx.c:1589
#13 0x00007fcb3dfeece2 in handle_exec (chan=0x7fca29178e18, agi=0x7fcacabb64c0, argc=3, argv=0x7fcacabb4e60) at res_agi.c:2521
#14 0x00007fcb3dff17a1 in agi_handle_command (chan=0x7fca29178e18, agi=0x7fcacabb64c0, buf=0x7fcb00014080 "EXEC", dead=0) at res_agi.c:3418
#15 0x00007fcb3dff335c in launch_asyncagi (chan=0x7fca29178e18, data=<value optimized out>, enhanced=<value optimized out>, dead=0) at res_agi.c:1329
#16 launch_script (chan=0x7fca29178e18, data=<value optimized out>, enhanced=<value optimized out>, dead=0) at res_agi.c:1631
#17 agi_exec_full (chan=0x7fca29178e18, data=<value optimized out>, enhanced=<value optimized out>, dead=0) at res_agi.c:3899
#18 0x000000000051b8a4 in pbx_exec (c=0x7fca29178e18, app=0x2008cf0, data=0x7fcacabb8680 "agi:async") at pbx.c:1589
#19 0x0000000000526014 in pbx_extension_helper (c=0x7fca29178e18, con=0x0, context=<value optimized out>, exten=<value optimized out>, priority=3, label=0x0, 
    callerid=0x7fca284e8870 "5400114247042177", action=E_SPAWN, found=0x7fcacabbacfc, combined_find_spawn=1) at pbx.c:4665
#20 0x000000000052ced5 in ast_spawn_extension (c=0x7fca29178e18, args=0x0) at pbx.c:5781
#21 __ast_pbx_run (c=0x7fca29178e18, args=0x0) at pbx.c:6256
#22 0x000000000052e65b in pbx_thread (data=<value optimized out>) at pbx.c:6586
#23 0x000000000056e2bb in dummy_start (data=<value optimized out>) at utils.c:1028
#24 0x00007fcb3fa17851 in start_thread (arg=0x7fcacabbb700) at pthread_create.c:301
#25 0x00007fcb40f8911d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:115
(gdb) fr 5
#5  0x00007fcb3d6b5773 in sip_read (ast=0x7fca2829a278) at chan_sip.c:8410
8410					if (ast_async_goto(ast, target_context, "fax", 1)) {
(gdb) p ast
$3 = (struct ast_channel *) 0x7fca2829a278

So, this thread is running sip_read() on the aforementioned locked channel.
If you look at chan_sip.c, you'll see that the channel is locked before
calling ast_async_goto().

(gdb) fr 3
#3  0x000000000047e648 in ast_do_masquerade (original=0x7fca2840b9d8) at channel.c:6861
6861		ao2_lock(channels);
(gdb) fr 2
#2  0x00007fcb3fa19287 in __pthread_mutex_lock (mutex=0x1fd3e00) at pthread_mutex_lock.c:82
82	      LLL_MUTEX_LOCK (mutex);
(gdb) p *mutex
$4 = {__data = {__lock = 2, __count = 1, __owner = 19566, __nusers = 1, __kind = 1, __spins = 0, __list = {__prev = 0x0, __next = 0x0}}, 
  __size = "\002\000\000\000\001\000\000\000nL\000\000\001\000\000\000\001", '\000' <repeats 22 times>, __align = 4294967298}

And, we're waiting on thread 69 [tid 19566]. Deadlock.
</pre>
