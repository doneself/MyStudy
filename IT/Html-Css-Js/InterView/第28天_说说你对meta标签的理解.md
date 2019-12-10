#  第28天 说说你对<meta>标签的理解

之前梳理移动端知识点的时候，总结了一些常用的meta，原文地址：[https://blog.csdn.net/u013778905/article/details/78077149](https://blog.csdn.net/u013778905/article/details/78077149)

以下是回答：

## 什么是meta

Meta标签是HTML语言head区的一个辅助性标签，它位于HTML文档头部的head标记和title标记之间，它提供用户不可见的信息。

Meta ： 即 \*\*元数据（Metadata）\*\*是数据的基本信息。

元数据可以被使用浏览器（如何显示内容或重新加载页面），搜索引擎（关键词），或其他 Web 服务调用。

用我们的大白话来说，**它本身是一个没什么用的标签，但是一旦在它内部通过其他属性设置了某些效果，它就起作用了，所以我们称之为“ 元数据 ”。**

它内部可填写的属性如下：

| 属性            | 值                                                          | 描述                                              |
| ---             | ---                                                         | ---                                               |
| charset (HTML5) | character\_set                                              | 定义文档的字符编码。                              |
| content         | text                                                        | 定义与 http\-equiv 或 name 属性相关的元信息。     |
| http\-equiv     | content\-type、default\-style、refresh                      | 把 content 属性关联到 HTTP 头部。                 |
| name            | application\-name、author、description、generator、keywords | 把 content 属性关联到一个名称。                   |
| scheme          | format/URI                                                  | HTML5不支持。 定义用于翻译 content 属性值的格式。 |

## 移动端meta

1、移动端页面设置视口宽度等于设备宽度，并禁止缩放。

```
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

```

2、移动端页面设置视口宽度等于定宽（如640px），并禁止缩放，常用于微信浏览器页面。

```
<meta name="viewport" content="width=640,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

```

3、禁止将页面中的数字识别为电话号码

```
<meta name="format-detection" content="telephone=no" />

```

4、忽略对邮箱地址的识别

```
<meta name="format-detection" content="email=no" />

```

5、当网站添加到主屏幕快速启动方式，伪装webapp，可隐藏工具栏/菜单栏/地址栏，仅针对ios的safari

```
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- ios7.0版本以后，safari上已看不到效果 -->

```

6、添加到主屏幕后，全屏显示

```
<meta name="apple-touch-fullscreen" content="yes">

```

7、设置ios的safari浏览器顶端状态条的样式

```
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<!-- 可选default、black、black-translucent -->

```

8、添加到主屏后的标题

```
<meta name="apple-mobile-web-app-title" content="标题">

```

9、添加智能 App 广告条 Smart App Banner
告诉浏览器这个网站对应的app，并在页面上显示下载banner。

```
<meta name="apple-itunes-app" content="app-id=myAppStoreID, affiliate-data=myAffiliateData, app-argument=myURL">

```

10、其他meta

```
<!-- 针对手持设备优化，主要是针对一些老的不识别viewport的浏览器，比如黑莓 -->
<meta name="HandheldFriendly" content="true">

<!-- 微软的老式浏览器 -->
<meta name="MobileOptimized" content="320">

<!-- uc强制竖屏 -->
<meta name="screen-orientation" content="portrait">

<!-- QQ强制竖屏 -->
<meta name="x5-orientation" content="portrait">

<!-- UC强制全屏 -->
<meta name="full-screen" content="yes">

<!-- QQ强制全屏 -->
<meta name="x5-fullscreen" content="true">

<!-- UC应用模式 -->
<meta name="browsermode" content="application">

<!-- QQ应用模式 -->
<meta name="x5-page-mode" content="app">

<!-- windows phone 点击无高光 -->
<meta name="msapplication-tap-highlight" content="no">

```

## 针对苹果手机说明：

配合 Web App 的 icon 和启动界面需要额外的两端代码进行设定，如下所示：

```
<link rel="apple-touch-icon-precomposed" href="iphone_logo.png" />

```

说明：这个 link 就是设置 Web App 的放置主屏幕上 icon 文件路径

使用：该路径需要注意的就是放到将网站的文档根目录下但不是服务器的文档的根目录。图片尺寸可以设定为 57*57（px）或者 Retina 可以定为 114*114（px），iPad 尺寸为 72\*72（px）

```
<link rel="apple-touch-startup-image" href="logo_startup.png" />

```

说明：这个 link 就是设置启动时候的界面。

使用：放置的路径和上面一样。
官方规定启动界面的尺寸必须为 320\*640（px），原本以为 Retina 屏幕可以支持双倍，但是不支持，图片显示不出来。
如果对 Web App 的这两个 meta 还有不能详细理解的可以查看官方解释：[Meta Tags](https://developer.apple.com/safari/resources/#documentation/appleapplications/reference/SafariHTMLRef/Articles/MetaTags.html)

关于 link 方面还有更多的参数设置（例如：iPod、iPad、iPhone 不同尺寸不同图标），可以查看官方标准文档：[Configuring Web Applications](https://developer.apple.com/safari/resources/#documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html)

参考：
1\. [前端 Meta 用法大汇总](http://www.jianshu.com/p/850d2a209ba8)
2\. [移动端meta汇总](http://www.cnblogs.com/futai/p/5343969.html)
