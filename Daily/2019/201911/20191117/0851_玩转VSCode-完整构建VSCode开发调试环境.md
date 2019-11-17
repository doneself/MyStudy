# 玩转VSCode-完整构建VSCode开发调试环境

随着VSCode的不断完善和强大，是时候将部分开发迁移到VS Code中了。

目前使用VS2019开发.NET Core应用，一直有一个想法，在VS Code中复刻VS的开发环境，同时迁移到VS Code。

那么现在就开始吧。

首先，安装最新版的VS Code：[https://code.visualstudio.com/](https://code.visualstudio.com/)，安装完成后可能会提示升级，升级即可，升级后的版本信息：

``` 1c-enterprise
版本: 1.40.1 (system setup)
提交: 8795a9889db74563ddd43eb0a897a2384129a619
日期: 2019-11-13T16:49:35.976Z
Electron: 6.1.2
Chrome: 76.0.3809.146
Node.js: 12.4.0
V8: 7.6.303.31-electron.0
OS: Windows_NT x64 10.0.16299
```

接下来的操作分为几个步骤：

1\. 安装各种强大VS Code插件

2\. 创建.NET Core解决方案和工程

3\. 调试运行

好的，那我们开始吧。

**一、安装各种强大的VS Code插件**

1. C# extension for Visual Studio Code

这个插件最重要的功能：

*   Lightweight development tools for [.NET Core](https://dotnet.github.io/ "https://dotnet.github.io").
*   Great C# editing support, including Syntax Highlighting, IntelliSense, Go to Definition, Find All References, etc.
*   Debugging support for .NET Core (CoreCLR). NOTE: Mono debugging is not supported. Desktop CLR debugging has [limited support](https://github.com/OmniSharp/omnisharp-vscode/wiki/Desktop-.NET-Framework "https://github.com/OmniSharp/omnisharp-vscode/wiki/Desktop-.NET-Framework").
*   Support for project.json and csproj projects on Windows, macOS and Linux.

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116223107121-1374307824.png)

2. C# Extensions

这个插件最有用的功能是可以右键新建C#类和C#接口，同时支持各种code snippets，例如 ctor 、prop等，具体功能特性，可以查看插件的说明。

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116223647555-152515035.png)

 3. Auto\-Using for C#

这个插件自动添加using引用。

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116223819671-972028203.png)

4. vscode\-solution\-explorer

这个插件给VS Code增加了解决方案tab, 支持新建解决方案、新建工程、添加引用、Nuget包，这个插件非常有用

Adds a Solution Explorer panel where you can find a Visual Studio Solution File Explorer.

*   Can load any .sln version

*   Supports csproj, vcxproj, fsproj and vbproj (from vs2017 and before)

*   Supports dotnet core projects

*   You can create, delete, rename or move project folders and files.

*   You can create, delete, rename or move solution, solution folders and projects.

*   You can add or remove packages and references when the project is of kind CPS (dotnet core).

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116224115650-1909428785.png)

5\. Code Runner（韩俊老师出品，必属精品）

Run code snippet or code file for multiple languages: **C, C++, Java, JavaScript, PHP, Python, Perl, Perl 6, Ruby, Go, Lua, Groovy, PowerShell, BAT/CMD, BASH/SH, F# Script, F# (.NET Core), C# Script, C# (.NET Core), VBScript, TypeScript, CoffeeScript, Scala, Swift, Julia, Crystal, OCaml Script, R, AppleScript, Elixir, Visual Basic .NET, Clojure, Haxe, Objective\-C, Rust, Racket, Scheme, AutoHotkey, AutoIt, Kotlin, Dart, Free Pascal, Haskell, Nim, D, Lisp, Kit**, and custom command

即选中一段代码，直接run

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116224309233-439651238.png)

6. vscode\-icons

通过这个插件，给各个文件和文件夹一个你更熟悉的图标

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116224415866-1514804724.png)

7. Visual Studio IntelliCode

VS代码智能提示，根据上下文语境，自动推荐你下一步用到的代码，后台基于AI的

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116224557664-231040006.png)

8. NuGet Package Manager

Nuget包管理，快速查询定位Nuget包，并安装。不过尝试了一下午自定义Nuget源，没搞定，估计是URL不对

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116224730570-1935243959.png)

9\. Docker

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116224800451-1404785321.png)

10. Kubernetes

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116224832214-2073861928.png)

其他的还需要配置GitHub、TFS类似的源代码管理，TFS搞了两个插件，都不好使，后续搞定后再更新一次。

**二、创建.NET Core解决方案和工程**

此时，VS Code的环境基本配置差不多了，接下来有两种模式，创建解决方案和工程。

**1\. 通过vscode\-solution\-explorer**

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116225123269-1255973048.png)

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116225214960-1302636527.jpg)

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116225236311-965364529.png)

解决方案有了，很熟悉的感觉。

我们可以继续创建工程：右键sln，Add new project：

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116225409915-638684587.png)

此时会弹出工程模板，此时我们选择ASP.NET Core Web API工程

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116225441838-1748805414.png)

**选择C#**

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116225619826-463729342.png)

然后继续输入工程名称：例如 TestWebApi

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116225821497-1463083834.png)

熟悉的感觉来了。此时就可以开始coding了。

以上是我们通过vscode\-solution\-explorer新建解决方案和工程。同时我们可以通过命令行来搞定。

****2\. 通过Dotnet CLI命令行****

新建sln：

dotnet "new" "sln" "\-n" "EricTest" "\-o" "e:\\Work\\ServiceDependency"

新建ASP.NET Core WebAPI工程

dotnet "new" "webapi" "\-lang" "C#" "\-n" "TestWebApi" "\-o" "TestWebApi"

将TestWebApi工程添加到解决方案EricTest

dotnet "sln" "e:\\Work\\ServiceDependency\\EricTest.sln" "add" "e:\\Work\\ServiceDependency\\TestWebApi\\TestWebApi.csproj"

**三、调试运行**

在Debug选项卡中新增调试配置，重点设置要调试的program

![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116232300570-1372643971.png)

**保存后，启动调试：**

**![](https://img2018.cnblogs.com/blog/23525/201911/23525-20191116232421614-1735396197.png)**

程序中增加断点，然后

输入URL：https://localhost:5001/WeatherForecast

 既可以调试了。

以上是今天集中配置VS Code开发调试环境的总结，分享给大家。
