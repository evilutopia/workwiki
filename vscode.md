
GCC & clang on windows + bash terminal + debugging!
==========================

Prerequisites
-------------------------
+ Install lib by msys2 (mingw, gcc, gdb,... etd.) 
+ Install clang
+ Install vscode
+ Install extension
+ 配置vscode


Install lib by msys2 (mingw, gcc, gdb,... etd.) 
-----------------------
设置环境变量
Path
  C:\msys64\usr\bin
  C:\msys64\mingw64\bin
使用pacman安装boost




MSYS2 is a software distro and building platform for Windows
--------------------------
https://www.msys2.org/


配置vscode
--------------------------

.vscode\c_cpp_properties.json
--------------------------
<pre>
{
    "configurations": [
        {
            "name": "Win32",
            "browse": {
                "path": [
                    "${workspaceFolder}",
                    "C:\\msys64\\mingw64\\lib"
                ],
                "limitSymbolsToIncludedHeaders": true
            },
            "includePath": [
                "${workspaceFolder}",
                "C:\\msys64\\mingw64\\include",
                "C:\\msys64\\mingw64\\lib"
            ],
            "defines": [
                "_DEBUG",
                "UNICODE",
                "_UNICODE"
            ],
            "cStandard": "c11",
            "cppStandard": "c++17",
            "intelliSenseMode": "clang-x64"
        }
    ],
    "version": 4
}
</pre>


launch.json
--------------------------
<pre>
{
    // 使用 IntelliSense 了解相关属性。 
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(gdb) Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/a.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": true,
            "MIMode": "gdb",
            "miDebuggerPath": "C:/msys64/mingw64/bin/gdb.exe",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
</pre>

task.json
--------------------------
<pre>
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "echo",
            "type": "shell",
            "command": "clang++"
        }
    ]
}
</pre>

user_setting
--------------------------
<pre>
{
    "editor.multiCursorModifier": "ctrlCmd",
    "editor.formatOnPaste": true,
    "team.showWelcomeMessage": false,
    "terminal.integrated.shell.windows": "C:\\msys64\\usr\\bin\\bash.exe",
    "terminal.integrated.shellArgs.windows": [
        "-i"
    ]
}
</pre>

https://msdn.microsoft.com/en-us/library/ms235639.aspx

https://www.zhihu.com/question/30315894


Excluding Dirs
--------------------------
https://stackoverflow.com/questions/30140112/how-do-i-hide-certain-files-from-the-sidebar-in-visual-studio-code


install extention offline
----------------------------------------
code --install-extension 插件名称

https://marketplace.visualstudio.com/,  点击想要的插件， 点击  Download Extension 下载插件



Using cmder as integrated shell in VSCode
---------------------------
<pre>
{
    "terminal.integrated.shell.windows": "C:\\Windows\\Sysnative\\cmd.exe",
    "terminal.integrated.shellArgs.windows": [
        "/k C:\\Program Files (x86)\\Cmder\\vendor\\init.bat"
    ]
}

https://amreldib.com/blog/CustomizeWindowsCmderPrompt/
</pre>

remote development
----------------------------------------

<pre>
First get commit id(vscode->about->commit:XXXXXXXX)
Download vscode server from url: https://update.code.visualstudio.com/commit:${commit_id}/server-linux-x64/stable
Upload the vscode-server-linux-x64.tar.gz to server
Unzip the downloaded vscode-server-linux-x64.tar.gz to ~/.vscode-server/bin/${commit_id} without vscode-server-linux-x64 dir
Create 0 file under ~/.vscode-server/bin/${commit_id}

commit_id=f06011ac164ae4dc8e753a3fe7f9549844d15e35

# Download url is: https://update.code.visualstudio.com/commit:${commit_id}/server-linux-x64/stable
curl -sSL "https://update.code.visualstudio.com/commit:${commit_id}/server-linux-x64/stable" -o vscode-server-linux-x64.tar.gz

mkdir -p ~/.vscode-server/bin/${commit_id}
# assume that you upload vscode-server-linux-x64.tar.gz to /tmp dir
tar zxvf /tmp/vscode-server-linux-x64.tar.gz -C ~/.vscode-server/bin/${commit_id} --strip 1
touch ~/.vscode-server/bin/${commit_id}/0
</pre>



编译程序
---------------------------
https://winsmarts.com/using-cmder-as-integrated-shell-in-vscode-c3340714fe3c


<pre>
#include <iostream>
#include <string>   
#include <boost/lexical_cast.hpp>
#include <boost/thread.hpp>

void Counter(int x)
{
    while(x > 0)
    {
        std::cout << boost::lexical_cast<std::string>(x) << std::endl;
        --x;
    }
    return;
}
  
int main()
{
    int x = 10;
    std::cout << "hello vscode " << boost::lexical_cast<std::string>(x) << std::endl;
    
    boost::thread t1(Counter, x);

    t1.join();
    
    return 0;
}
</pre>

<pre>
felix@DESKTOP-BNO3JQ3  /f/pworkspace/cpp11
$ clang++ -lboost_system -lboost_thread main.cpp
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZN5boost6thread4joinEv]+0x28): undefined reference to `boost::this_thread::get_id()'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZN5boost6thread4joinEv]+0x3a): undefined reference to `boost::thread::get_id() const'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZN5boost6thread4joinEv]+0xb1): undefined reference to `boost::thread::join_noexcept()'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZN5boost6threadD2Ev]+0x14): undefined reference to `boost::thread::detach()'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZNK5boost6system14error_category12std_category10equivalentEiRKSt15error_condition]+0xf6): undefined reference to `boost::system::generic_category()'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZNK5boost6system14error_category12std_category10equivalentEiRKSt15error_condition]+0x12e): undefined reference to `boost::system::generic_category()'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZNK5boost6system14error_category12std_category10equivalentERKSt10error_codei]+0xfa): undefined reference to `boost::system::generic_category()'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZNK5boost6system14error_category12std_category10equivalentERKSt10error_codei]+0x132): undefined reference to `boost::system::generic_category()'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZNK5boost6system14error_category12std_category10equivalentERKSt10error_codei]+0x272): undefined reference to `boost::system::generic_category()'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZN5boost16thread_exceptionC2EiPKc]+0x2d): more undefined references to `boost::system::generic_category()' follow
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZN5boost6thread12start_threadEv]+0x18): undefined reference to `boost::thread::start_thread_noexcept()'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZN5boost6detail16thread_data_baseC2Ev]+0x11): undefined reference to `vtable for boost::detail::thread_data_base'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.text[_ZN5boost6detail11thread_dataINS_3_bi6bind_tIvPFviENS2_5list1INS2_5valueIiEEEEEEED2Ev]+0xf): undefined reference to `boost::detail::thread_data_base::~thread_data_base()'
C:\Users\felix\AppData\Local\Temp\main-fcd69f.o:(.rdata[_ZTIN5boost6detail11thread_dataINS_3_bi6bind_tIvPFviENS2_5list1INS2_5valueIiEEEEEEEE]+0x10): undefined reference to `typeinfo for boost::detail::thread_data_base'
clang++.exe: error: linker command failed with exit code 1 (use -v to see invocation)
</pre>

<pre>
连接的库需要放在后面才能编译
felix@DESKTOP-BNO3JQ3  /f/pworkspace/cpp11
$ clang++ main.cpp -lboost_system -lboost_thread

felix@DESKTOP-BNO3JQ3  /f/pworkspace/cpp11
$
https://stackoverflow.com/questions/15280882/why-undefined-reference-to-boostsystemgeneric-category-even-if-i-do-link
https://stackoverflow.com/questions/492374/g-in-what-order-should-static-and-dynamic-libraries-be-linked/492498#492498
</pre>





user snippet
-----------------------------
https://code.visualstudio.com/docs/editor/userdefinedsnippets


参考资料
-----------------------------
https://www.youtube.com/watch?v=TLh--v8OxHE&t=910s&list=PL18844R4xSKTZqTPzz9ZbXiWrcsXsBc9d&index=2

常用插件
-----------------------------
CodeIf
local history
Partial Diff
TODO Tree
Better Comments
Bracket Pair Colorizer
Better Align（Ctrl+Shift+p输入“Align”）
change-case（Ctrl+Shift+p输入“change）
vim
Text Power  Tools
Markdown All in One
TextMaker(Highlighter)
HexEditor
Draw.io
Diff Folders
Doxygeb Dicynebtatuib Geberatir



