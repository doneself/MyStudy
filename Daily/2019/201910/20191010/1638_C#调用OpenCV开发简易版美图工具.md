# C#调用OpenCV开发简易版美图工具

https://www.cnblogs.com/kiba/p/11321438.html

## 前言

在C#调用OpenCV其实非常简单，因为C#中有很多OPenCV的开源类库。

本文主要介绍在WPF项目中使用OpenCVSharp3-AnyCPU开源类库处理图片，下面我们先来做开发前的准备工作。


## 准备工作

首先，我们先创建一个WPF项目。

然后，在Nuget上搜索OpenCVSharp，如下图：


## C#中应用OPenCV

现在，我们进入项目，进行OPenCV的调用。

我们先引入OpenCV相关的命名空间，如下：

``` csharp
using OpenCvSharp;
using OpenCvSharp.Extensions;
```

然后我们在项目中使用Mat类来进行图片操作。
