# webservice 生成代理类

https://www.cnblogs.com/dengxinglin/p/3333531.html


## [Web Serveice服务代理类生成及编译](https://www.cnblogs.com/dengxinglin/p/3333531.html)

###### **本文链接地址：[http://www.cnblogs.com/dengxinglin/p/3334158.html](http://www.cnblogs.com/dengxinglin/p/3334158.html)
**

**一、生成代理类**

对于web service服务和wcf的webservice服务，我们都可以通过一个代理类来调用。

怎么写那个代理类呢？通过一个工具生成即可！！微软为我们提供了一个wsdl.exe的Web服务描述语言工具，wsdl.exe从 WSDL 协定文件、XSD 架构和 .discomap 发现文档为 XML Web services 和 XML Web services 客户端生成代码。我们不需要写任何代码，只要使用这个工具就可以自动生成的代理类文件。

那如何使用这个工具呢？

这个工具是在命令行下面执行的，我们只要打开VS的命令提示工具，我的英文版vs2010是打开方法是：开始菜单\-\-》Microsoft Visual Studio 2010\-\-》Visual Studio Tools\-\-》Visual Studio Command Prompt (2010)，我输入了如下命令

wsdl　/l:cs /n:mynamespace /out:d:\\weather.cs  [http://www.webservicex.net/globalweather.asmx](http://www.webservicex.net/globalweather.asmx)?WSDL

/l:cs是/language:cs是简写， 为输出语言，支持输出CS(默认)、VB (Visual Basic)、JS (Jscript) 或 VJS (Visual J#) 语言

/n:mynamespace 是生成代理类所使用的命名空间

/out：表示输出文件的路径了，这表示在输出文件放在D盘，文件名为weather.cs

最后那个就是web service的wsdl地址了，按回车在D盘为我生成weather.cs代理类。

更多wsdl的命令可以去微软的msdn网站上：[http://msdn.microsoft.com/zh\-cn/library/7h3ystb6(v=vs.80).aspx](http://msdn.microsoft.com/zh-cn/library/7h3ystb6(v=vs.80).aspx)

**二、编译代理类**

wsdl工具非常强大，为我生成了一个代理类，把该代理类放到我的项目用，就可以直接去调用了。可是有很多个web service，这样生成了很多的代理类文件。这需要建立一个项目，把这些代理类都添加进去，之后编译生成一个dll，供别的项目直接调用！把那些代理类都添加到一个项目中去编译成一个dll，这些微软也提供了一个csc的工具。实现了把代码文件编译成dll。

和上面一样，csd也是在命令行下面运行的。打开Visual Studio 命令提示，输入

csc /t: library /out:d:\\webservice.dll  d:\\weather.cs d:\\weather2.cs

/t:表示以类库方式输出的

/out:输出的dll路径

d:\\weather.cs d:\\weather2.cs是包含的两个代理类文件

csc.exe是一个功能强大的编译，更多关于csc.exe的使用：[http://msdn.microsoft.com/zh\-cn/library/78f4aasd.aspx](http://msdn.microsoft.com/zh-cn/library/78f4aasd.aspx)

**三、使用**

生成了webservice.dll的文件，在项目中，你只需要添加对webservice.dll的引用，并**需要引用system.web.services**，代理类中使用了system.web.services下面的方法。

之后你就可以像调用本地的代码一样使用了。

我把上面这两个命令行工具做成了一个可视化的工具：

## [web代理类生成工具](http://www.cnblogs.com/dengxinglin/p/3334158.html)

本文链接地址：[http://www.cnblogs.com/dengxinglin/p/3334158.html](http://www.cnblogs.com/dengxinglin/p/3334158.html)
