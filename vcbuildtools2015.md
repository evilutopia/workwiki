
1. 下载visual c++ build tools
    - 登录：https://my.visualstudio.com/ 
    - 搜索并下载：Visual C++ Build Tools 2015 Update 3(en_visual_cpp_build_tools_2015XXX)
    - 查看帮助 en_visual_cpp_build_tools_2015_update_3_x86_x64_8923157.exe  /?
    - en_visual_cpp_build_tools_2015_update_3_x86_x64_8923157.exe /Layout  离线程序存储目录路  /L download.log.txt
    ```
    通过/Layout 参数下载安装镜像，支持断点续传 
    ```
    
2. 安装visual c++ build tools

    en_visual_cpp_build_tools_2015_update_3_x86_x64_8923157.exe /NoRefresh /NoWeb /L install.log.txt
    ```
    安装过程中可能出错，再次执行命令直接执行就可以了
    ```
    
3. 编译程序   
   - 启动visual c++ build tools自带的本地命令行工具: Visual C++ 2015 x86 Native Build Tools Command Prompt
   - 输入 cl测试编译工具是否正常安装 
