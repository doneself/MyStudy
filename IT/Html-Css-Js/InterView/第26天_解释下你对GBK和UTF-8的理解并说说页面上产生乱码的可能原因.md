# [html] 第26天 解释下你对GBK和UTF-8的理解？并说说页面上产生乱码的可能原因 #90

## gbk和utf8的理解

我们这里将以最简单最容易理解的方式来描述GBK和UTF8的区别，以及它们分别是什么。

GBK编码：是指中国的中文字符，其它它包含了简体中文与繁体中文字符，另外还有一种字符“gb2312”，这种字符仅能存储简体中文字符。

UTF\-8编码：它是一种全国家通过的一种编码，如果你的网站涉及到多个国家的语言，那么建议你选择UTF\-8编码。

## GBK和UTF8有什么区别？

UTF8编码格式很强大，支持所有国家的语言，正是因为它的强大，才会导致它占用的空间大小要比GBK大，对于网站打开速度而言，也是有一定影响的。

GBK编码格式，它的功能少，仅限于中文字符，当然它所占用的空间大小会随着它的功能而减少，打开网页的速度比较快。

## 产生乱码的原因

*   html乱码原因与网页乱码解决方法： [http://www.akhtm.com/manual/charset\-error.htm](http://www.akhtm.com/manual/charset-error.htm)
*   网页乱码的产生原因与解决：[http://www.akhtm.com/manual/charset\-error.htm](http://www.akhtm.com/manual/charset-error.htm)

## 参考：

*   让你彻底搞定各种编码来源ASCII、ANSI、GBK、unicode、UTF\-8等[https://blog.csdn.net/wskzgz/article/details/88710263](https://blog.csdn.net/wskzgz/article/details/88710263)
*   web程序网页出现乱码的原因分析：[https://blog.csdn.net/senlin1202/article/details/50800187](https://blog.csdn.net/senlin1202/article/details/50800187)
