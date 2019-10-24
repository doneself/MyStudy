# [css] 第26天 说说你对z-index的理解 #91

## z\-index理解

当网页上出现多个由绝对定位（position:absolute）或固定定位（position:fixed）所产生的浮动层时，必然就会产生一个问题，就是当这些层的位置产生重合时，谁在谁的上面呢？或者说谁看得见、谁看不见呢？这时候就可以通过设置`z-index`的值来解决，这个值较大的就在上面，较小的在下面。

> `z-index`的意思就是在z轴的顺序，如果说网页是由x轴和y轴所决定的一个平面，那么z轴就是垂直于屏幕的一条虚拟坐标轴，浮动层就在这个坐标轴上，那么它们的顺序号就决定了谁上谁下了。

## 参考：

*   关于z\-index 那些你不知道的事：[https://webdesign.tutsplus.com/zh\-hans/articles/what\-you\-may\-not\-know\-about\-the\-z\-index\-property\-\-webdesign\-16892](https://webdesign.tutsplus.com/zh-hans/articles/what-you-may-not-know-about-the-z-index-property--webdesign-16892)
*   MDN\[z\-index\]： [https://developer.mozilla.org/zh\-CN/docs/Web/CSS/z\-index](https://developer.mozilla.org/zh-CN/docs/Web/CSS/z-index)


`z-index` 可以想象成是一根垂直于屏幕的轴，或者说类似 Photoshop 中图层的概念。`z-index` 越大，越靠近用户，同时也会覆盖底下的内容。需要注意的是，`z-index` 只对于同类型的元素有效。可以参考 Day 20 的解答\-\-请描述 HTML 元素的显示优先级
