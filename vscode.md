
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

配置vscode
--------------------------

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


install extention offline
----------------------------------------
code --install-extension 插件名称

https://marketplace.visualstudio.com/,  点击想要的插件， 点击  Download Extension 下载插件

参考资料
-----------------------------
https://www.youtube.com/watch?v=TLh--v8OxHE&t=910s&list=PL18844R4xSKTZqTPzz9ZbXiWrcsXsBc9d&index=2


