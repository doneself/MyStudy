# 该把JS文件放在HTML文档的那个位置

https://zhuanlan.zhihu.com/p/26440626

**首先我们需要了解的一点就是，在浏览器渲染页面之前，它需要通过解析HTML标记然后构建DOM树。在这个过程中，如果解析器遇到了一个脚本(script)，它就会停下来，并且执行这个脚本，然后才会继续解析HTML。如果遇到了一个引用外部资源的脚本(script)，它就必须停下来等待这个脚本资源的下载，而这个行为会导致一个或者多个的网络往返，并且会延迟页面的首次渲染时间。**

**还有一点是需要我们注意的，那就是外部引入的脚本(script)会阻塞浏览器的并行下载，[HTTP/1.1](https://link.zhihu.com/?target=https%3A//www.w3.org/Protocols/rfc2616/rfc2616-sec8.html%23sec8.1.4)规范表明，浏览器在每个主机下并行下载的组件不超过两个(也就是说，浏览器一次只能够同时从同一个服务器加载两个脚本)；如果你网站的图片是通过多个服务器提供的，那么按道理来说，你的网站可以一次并行下载多张图片。但是，当我们网站在加载脚本的时候；浏览器不会再启动任何其它的下载，即使这些组件来自不同的服务器。**

看到这里，也许很多开发者都会想：既然把脚本(script)资源放在head里面是个不好的主意，并且可能会阻塞浏览器渲染页面；那我们是不是要把所有的JavaScript文件都放置到文档的底部呢？这个当然也是太过极端了，因为还是有一些情况需要我们在头部引用脚本的；到底是哪些情况需要我们这么做呢，下面我们来看看一些大公司的做法：

![](https://pic3.zhimg.com/v2-33fa56fdbb82d193c612a2f443a7248a_b.jpg)

![](https://pic3.zhimg.com/80/v2-33fa56fdbb82d193c612a2f443a7248a_hd.jpg)

我们可以看到，这个搜索页面在头部加载了5个JavaScript文件(箭头标注的地方)，其中两个JavaScript文件是内联的(inline)，另外三个大家可以看到script标签上都添加了async属性，那这个属性是干嘛的呢？我们会在下面解释。

![](https://pic4.zhimg.com/v2-2217c000db7348d6085721abd81261eb_b.jpg)

![](https://pic4.zhimg.com/80/v2-2217c000db7348d6085721abd81261eb_hd.jpg)

我们可以看到，百度也在头部引入了一些JavaScript文件，这些文件引入的方式与Google的做法差不多，都在引入外部资源的script标签上添加了async属性，除了第一个JavaScript文件没有那样做。

![](https://pic4.zhimg.com/v2-41ac10743bd60b9624ac12f077c9a437_b.jpg)

![](https://pic4.zhimg.com/80/v2-41ac10743bd60b9624ac12f077c9a437_hd.jpg)

![](https://pic2.zhimg.com/v2-1f005a7f62231c9a10896efc55789e95_b.jpg)

![](https://pic2.zhimg.com/80/v2-1f005a7f62231c9a10896efc55789e95_hd.jpg)

最后一个是facebook的首页，令我比较出乎意料的是，facebook的首页的头部引入了大量的脚本(script)，大家可以看一下截图

![](https://pic4.zhimg.com/v2-a679564e66444c33e91e6aa211566a17_b.jpg)

![](https://pic4.zhimg.com/80/v2-a679564e66444c33e91e6aa211566a17_hd.jpg)

![](https://pic3.zhimg.com/v2-ae980ea6c39dd6566b6b79922f6c568e_b.jpg)

![](https://pic3.zhimg.com/80/v2-ae980ea6c39dd6566b6b79922f6c568e_hd.jpg)

不过基本上facebook的script标签上面都添加了async属性，下面我们先来来说一下script标签上面这个async属性的作用。

**这个属性是HTML5给script新添加的属性，而且只适用于外部的JavaScript文件，如果在script标签上添加了这个属性，那么表明这个脚本资源就不再是同步加载的了，而是异步加载的，所以不会阻塞浏览器对页面的渲染。当然这个属性会存在一些兼容性问题，一些浏览器还未实现对这个属性的支持。**

我们可以看到，虽然这些网站大部分的script标签(针对引入的外部文件)都添加了async属性，但是还是有一些script标签没有添加async属性，那就表示这些资源是同步加载执行的，在这里你可能会问，那这些资源为什么不使用异步加载呢？**原因很大程度上是因为，这些脚本需要在浏览器渲染页面之前就执行的；**比如Yahoo在[Best Practices for Speeding Up Your Web Site](https://link.zhihu.com/?target=https%3A//developer.yahoo.com/performance/rules.html)中就指出，如果你的脚本中使用了document.write在页面中插入内容的话，那就不能够将这条脚本放置到文档的底部了。类似的还有weibo，weibo的head中也使用了一个要在页面渲染之前就执行的脚本，如下：

```js
<script type="text/javascript">
    try {document.execCommand("BackgroundImageCache", false, true);
        } catch (e) {}
</script>

```

还有百度首页的head中也有两条需要在页面渲染之前就执行的JavaScript文件：

```js
<script data-compress="strip">
function h(obj){
    obj.style.behavior='url(#default#homepage)';
    var a = obj.setHomePage('//www.baidu.com/');
}
</script>
<script>window._ASYNC_START=new Date().getTime();</script>

```

还有一些比如Google和Baidu他们搜索页面同步加载的那些JavaScrip文件一些是为了在页面渲染之前做一些全局的处理(比如Google)添加了全局变量google。

![](https://pic3.zhimg.com/v2-3bf207a192c9a29876e0acccb7b8896a_b.jpg)

![](https://pic3.zhimg.com/80/v2-3bf207a192c9a29876e0acccb7b8896a_hd.jpg)

还有的就是单纯的满足自己业务上的一些需求了，比如百度同步加载的那个JavaScript文件：

![](https://pic4.zhimg.com/v2-784ca5e1e7f4fc5b9081714a94f59d3b_b.jpg)

![](https://pic4.zhimg.com/80/v2-784ca5e1e7f4fc5b9081714a94f59d3b_hd.jpg)

**所以说，除了上面这些情况外，其它的情况下我们的脚本资源都需要放在文档的底部；**当然这里还有一些需要我们注意的问题，首先，脚本加载的顺序很重要，比如如果你的脚本需要使用jQuery库，那么你就应该在加载你的脚本之前先加载jQuery库。其次，有些脚本是需要等到某些元素加载完成之后才可以执行的，那么你可以将你的脚本紧挨在那个元素的后面；还有一些元素是通过脚本动态创建的，所以它们也需要放在合适的位置。比如微博的：

![](https://pic2.zhimg.com/v2-0c713319bd500a9822ce89c0b5239261_b.jpg)

![](https://pic2.zhimg.com/80/v2-0c713319bd500a9822ce89c0b5239261_hd.jpg)

如果使用过一些框架的脚手架你就会发现，这些框架打包后的那个index.html里面引入的外部JavaScript资源都是放在文档的底部的，并且它们也是按照顺序来的，vendor.js文件(项目使用的框架，库打包形成的文件)先引入，然后才是app.js文件(我们写的代码文件打包形成的)，这就说明了引入脚本文件的顺序也是很重要的。

到现在为止，我们已经讨论了很多关于把JavaScript文件放在文档的头部还是尾部的原因，那么下面我们可以总结出一些加载JavaScript文件的最佳实践；

*   **对于必须要在DOM加载之前运行的JavaScript脚本，我们需要把这些脚本放置在页面的head中，而不是通过外部引用的方式，因为外部的引用增加了网络的请求次数；并且我们要确保内敛的这些JavaScript脚本是很小的，最好是压缩过的，并且执行的速度很快，不会造成浏览器渲染的阻塞。**

*   **对于支持使用script标签的async和defer属性的浏览器，我们可以使用这两个属性；其中需要注意的点就是，async表示的意思是异步加载JavaScript文件，它的下载过程可以在HTML的解析过程中进行，加载完成之后立即执行这个文件的代码，执行文件代码的过程中会阻塞HTML的解析，它不保证文件加载的顺序。defer表示的意思是在HTML文档解析之后在执行加载完成的JavaScript文件，JavaScript文件的下载过程可以在HTML的解析过程中进行，它是按照script标签的先后顺序来加载文件的。更多详细的解释可以参考[async vs defer attributes](https://link.zhihu.com/?target=http%3A//www.growingwiththeweb.com/2014/02/async-vs-defer-attributes.html)**

到这里为止，整篇文章就算是结束了，如果你还想进一步的了解关于JavaScript文件加载的一些知识，可以看看这篇[文章](https://link.zhihu.com/?target=https%3A//www.html5rocks.com/en/tutorials/speed/script-loading/)

> 插播一个提问[我就想知道，知乎为什么不添加使用Markdown编辑答案和写文章的功能？ \- 知乎](https://www.zhihu.com/question/58532466)，提问好几天，木有人回答，不知道大家怎么看待这个问题的？

参考的一些资料：

*   [Remove Render\-Blocking JavaScript](https://link.zhihu.com/?target=https%3A//developers.google.com/speed/docs/insights/BlockingJS)

*   [Put Scripts at the Bottom](https://link.zhihu.com/?target=https%3A//developer.yahoo.com/performance/rules.html%23js_bottom)

*   [Best Practice: Where to include your script tags](https://link.zhihu.com/?target=https%3A//teamtreehouse.com/community/best-practice-where-to-include-your-script-tags)

*   [Script Element](https://link.zhihu.com/?target=https%3A//developer.mozilla.org/zh-CN/docs/Web/HTML/Element/script)

*   [execCommand](https://link.zhihu.com/?target=https%3A//developer.mozilla.org/en-US/docs/Web/API/Document/execCommand)

*   [What is difference between using JavaScript in head and body?](https://link.zhihu.com/?target=https%3A//www.sololearn.com/Discuss/88797/what-is-difference-between-using-javascript-in-head-and-body/)

*   [Where To Include JavaScript Files In A Document](https://link.zhihu.com/?target=https%3A//robertnyman.com/2008/04/23/where-to-include-javascript-files-in-a-document/)

*   [Should I always put my JavaScript file in the head tag of my HTML file so that the code is loaded at the start?](https://link.zhihu.com/?target=https%3A//www.quora.com/Should-I-always-put-my-JavaScript-file-in-the-head-tag-of-my-HTML-file-so-that-the-code-is-loaded-at-the-start)

*   [Why put JavaScript in head](https://link.zhihu.com/?target=http%3A//stackoverflow.com/questions/8249013/why-put-javascript-in-head)

*   [Deep dive into the murky waters of script loading](https://link.zhihu.com/?target=https%3A//www.html5rocks.com/en/tutorials/speed/script-loading/)

*   [Asynchronous and deferred JavaScript execution explained](https://link.zhihu.com/?target=http%3A//peter.sh/experiments/asynchronous-and-deferred-javascript-execution-explained/)
