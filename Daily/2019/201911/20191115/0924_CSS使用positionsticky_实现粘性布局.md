# CSS使用position:sticky 实现粘性布局

## 简介

前面写了一篇文章讲解了position常用的几个属性：[《CSS 属性之 position讲解》](http://www.cnblogs.com/moqiutao/p/4781830.html)
一般都知道下面几个常用的：

{ position: static; position: relative; position: absolute; position: fixed;
}

在https://developer.mozilla.org/zh\-CN/docs/Web/CSS/position还说了下面这三个值：


``` css
/* 全局值 */
position: inherit;
position: initial;
position: unset;
```

估计大部分都没有用过**position:sticky**吧。这个属性值还在试验阶段。怎样描述它呢？

sticky：对象在常态时遵循常规流。它就像是`relative`和`fixed`的合体，当在屏幕中时按常规流排版，当卷动到屏幕外时则表现如`fixed`。该属性的表现是现实中你见到的吸附效果。

 常用场景：当元素距离页面视口（Viewport，也就是fixed定位的参照）顶部距离大于 0px 时，元素以 relative 定位表现，而当元素距离页面视口小于 0px 时，元素表现为 fixed 定位，也就会固定在顶部。


``` css
{
	position: -webkit-sticky; 
	position: sticky;
	top: 0;
}
```

如下图表现方式：

#### 距离页面顶部大于20px，表现为 `position:relative`;

![](https://images2017.cnblogs.com/blog/595142/201801/595142-20180123182350022-659183544.gif)

#### 距离页面顶部小于20px，表现为 `position:fixed`;

![](https://images2017.cnblogs.com/blog/595142/201801/595142-20180123182423787-1535029845.gif)

## 运用 `position:sticky` 实现头部导航栏固定

``` html
<div class="con">
    <div class="samecon">
        <h2>标题一</h2>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
    </div>
    <div class="samecon">
        <h2>标题二</h2>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
    </div>
    <div class="samecon">
        <h2>标题三</h2>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
    </div>
    <div class="samecon">
        <h2>标题四</h2>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
    </div>
    <div class="samecon">
        <h2>标题五</h2>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
    </div>
    <div class="samecon">
        <h2>标题五六</h2>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
        <p>这是一段文本</p>
    </div>
</div>
```

``` css
.samecon h2{
    position: -webkit-sticky;
    position: sticky;
    top: 0;
    background:#ccc;
    padding:10px 0;
}
```

同理，也可以实现侧边导航栏的超出固定。

## 生效规则

*   须指定 top, right, bottom 或 left 四个阈值其中之一，才可使粘性定位生效。否则其行为与相对定位相同。

    *   并且 `top` 和 `bottom` 同时设置时，`top` 生效的优先级高，`left` 和 `right` 同时设置时，`left` 的优先级高。
*   设定为 `position:sticky` 元素的任意父节点的 overflow 属性必须是 visible，否则 `position:sticky` 不会生效。这里需要解释一下：

    *   如果 `position:sticky` 元素的任意父节点定位设置为 `overflow:hidden`，则父容器无法进行滚动，所以 `position:sticky` 元素也不会有滚动然后固定的情况。
    *   如果 `position:sticky` 元素的任意父节点定位设置为 `position:relative | absolute | fixed`，则元素相对父元素进行定位，而不会相对 viewprot 定位。
*   达到设定的阀值。这个还算好理解，也就是设定了 `position:sticky` 的元素表现为 `relative` 还是 `fixed` 是根据元素是否达到设定了的阈值决定的。

## 兼容性

![](https://images2017.cnblogs.com/blog/595142/201801/595142-20180123183017725-654063927.png)

> 这个属性的兼容性还不是很好，目前仍是一个试验性的属性，并不是W3C推荐的标准。
