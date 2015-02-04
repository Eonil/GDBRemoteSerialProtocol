Eonil/GDBRemoteSerialProtocol
=============================
Hoon H.




THIS PROJECT HAS BEEN ABANDONED. DO NOT USE THIS FOR ANYTHING.
POSTED ONLINE FOR ARCHIVE AND REFERENCE PURPOSE.

At first, I thought communicating over stable protocol would be
better but I was wrong. GDB RSP lacks features, and seems
being treated as a legacy stuff. I changed to link to LLDB 
directly. Visit [Eonil/LLDBWrapper](https://github.com/Eonil/LLDBWrapper)
to see my LLDB API wrapper.






GDB RSP manuals
----------------
-	https://sourceware.org/gdb/current/onlinedocs/gdb/Remote-Protocol.html#Remote-Protocol
-	http://www.embecosm.com/appnotes/ean4/embecosm-howto-rsp-server-ean4-issue-2.html

LLDB extensions
-----------------
-	https://github.com/llvm-mirror/lldb/blob/master/docs/lldb-gdb-remote.txt


Test
----
Run LLDB `debugserver` at port `9999` before running workbench programs.



Zombie Processes
----------------
If you force quit the debugger using `Control+C`, then any debugging target process (so 
child of the debugger) may become zombie process. It will not disappear, and does not die
via `kill -9 <pid>`. 

-	Details: http://serverfault.com/questions/12503/what-is-a-zombie-process-and-how-do-i-kill-it
-	You can check zombies by `ps aux`, and zombies will be stated as `Z`.
-	Usually these zombies dies together when its parent process dies.
-	You can check parent of zombie by `ps -o ppid= <pid>`. If this prints `1`, you can kill 
	it only by rebooting.
-	Try `kill -20` (`SIGCHLD`). People say that would work.


License
-------
Licensed under "MIT License". 

