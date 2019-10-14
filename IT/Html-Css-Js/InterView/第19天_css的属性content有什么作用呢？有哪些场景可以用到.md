# [css] 第19天 css的属性content有什么作用呢？有哪些场景可以用到？ #63

content属性与 ::before 及 ::after 伪元素配合使用生成文本内容

通过attr()将选择器对象的属性作为字符串进行显示，如：
a::after{content: attr(href)} 
<a href="http://www.baidu.com">
a标签的href的值是：</a> 结果：a标签的href的值是：http://www.baidu.com


## 认识 :before 和 :after

* 默认 display: inline；
* 必须设置 content 属性，否则一切都是无用功， content 属性也只能应用在 :before 和 :after 伪元素上；
* 默认user-select: none，就是 :before 和 :after 的内容无法被用户选中；
* 伪元素可以和伪类结合使用形如：.target:hover:after。
* :before 和 :after 是在CSS2中提出来的，所以兼容IE8；
* ::before 和 ::after 是CSS3中的写法，为了将伪类和伪元素区分开；
* CSS 中其他的伪元素有：::before、::after、::first-letter、::first-line、::selection 等；
* 不可通过DOM使用，它只是纯粹的表象。在特殊情况下，从一个访问的角度来看，当前屏幕阅读不支持生成的内容。

## content 定义用法
content 属性与 :before 及 :after 伪元素配合使用，在元素头或尾部来插入生成内容。

说明： 该属性用于定义元素之前或之后放置的生成内容。默认地，这往往是行内内容，不过该内容创建的盒子类型可以用属性 display 控制。

MDN 对 content 的取值描述：

``` css
content: normal                                /* Keywords that cannot be combined with other values */
content: none

content: 'prefix'                              /* <string> value, non-latin characters must be encoded e.g. \00A0 for &nbsp; */
content: url(http://www.example.com/test.html) /* <uri> value */
content: chapter_counter                       /* <counter> values */
content: attr(value string)                    /* attr() value linked to the HTML attribute value */
content: open-quote                            /* Language- and position-dependant keywords */
content: close-quote
content: no-open-quote
content: no-close-quote

content: open-quote chapter_counter            /* Except for normal and none, several values can be used simultaneously */

content: inherit
```

content: <string> value 字符串
可以加入任何字符，包括 Unicode 编码等各种字符。

``` html
<a class="demo" href="https://www.xunlei.com/" title="精彩，一下就有">精彩，一下就有</a>

.demo:after{
	content: "↗"
}
```

我们还可以通过 content 内字符串的变化，实现类似 加载中... 的动画效果

``` css
.demo:after{
	animation: dot 1.6s linear both;
}
@keyframe dot{
	0%{ content: "." }
	33%{ content: ".." }
	66%{ content: "..." }
	100%{ content: "." }
}
```

类似的，还有种实现方式，steps阶梯函数实现元素位移

``` html
<a class="demo" href="https://www.xunlei.com/" title="精彩，一下就有">精彩，一下就有<dot>...</dot></a>
```

``` css
dot {
   display: inline-block;
    height: 1em;
    line-height: 1;
    text-align: left;
    vertical-align: -.25em;
    overflow: hidden;
}

dot::before {
    display: block;
    content: '...\A..\A.';
    white-space: pre-wrap;
    animation: dot2 1.6s infinite step-start both;
}

@keyframes dot2 {
    33% {
        transform: translateY(-2em);
    }

    66% {
        transform: translateY(-1em);
    }
}
```

content: <uri> value 外部资源  
用于引用媒体文件，图片，图标，SVG等。

受 background-image: url() 可以用渐变实现背景启发，类似的，一些函数是不是可以放在 content 中来实现？

``` css
.demo:after {
  content: radial-gradient(circle at 35% 35%, white 10%, pink 70%);
  display: inline-block;
  border-radius: 50%;
  width: 100px;
  height: 100px;
  overflow: hidden;
}
```

完美！当然本来就伪元素背景就可以实现，又为什么要放 content 呢？


### content: attr() value 属性值的引用

调用当前元素的属性，可以方便的比如将图片的 Alt 提示文字或者链接的 Href 地址显示出来。

```css
.demo:after{
	content: attr(href);
}
```

![在这里插入图片描述](https://camo.githubusercontent.com/cbcacf88aa0f42a37e003c4b9858250fdfe2a0d8/68747470733a2f2f696d672d626c6f672e6373646e696d672e636e2f32303139303530383038353530343234382e706e67)

```css
.demo:after{
	content: attr(class);
}
```

![在这里插入图片描述](https://camo.githubusercontent.com/6b15e517f8a26aaf938f02ef9a5898091014229f/68747470733a2f2f696d672d626c6f672e6373646e696d672e636e2f32303139303530383038353631323533322e706e67)


### content: `<counter>` values

调用计数器，可以不使用列表元素实现序号功能。具体请参见 `counter-increment` 和 `counter-reset` 属性的用法。

```html
<h1>大标题</h1>
<h2>中标题</h2>
<h3>小标题</h3>
<h3>小标题</h3>
<h2>中标题</h2>
<h3>小标题</h3>
<h3>小标题</h3>
<h1>大标题</h1>
<h2>中标题</h2>
<h3>小标题</h3>
<h3>小标题</h3>
<h2>中标题</h2>
<h3>小标题</h3>
<h3>小标题</h3>
```

```css
h1::before{
    content:counter(h1)'.';
}
h1{
    counter-increment:h1;
    counter-reset:h2;
}
h2::before{
    content:counter(h1) '-' counter(h2);
}
h2{
    counter-increment:h2;
    counter-reset:h3;
    margin-left:40px;
}
h3::before{
    content:counter(h1) '-' counter(h2) '-' counter(h3);
}
h3{
    counter-increment:h3;
    margin-left:80px;
}
```

![在这里插入图片描述](https://camo.githubusercontent.com/f754cbee55ff69d6fa5fb6bc33901c1d25af2ecd/68747470733a2f2f696d672d626c6f672e6373646e696d672e636e2f32303139303530383039303630323132302e706e67)


### 引用符号

属于引用符号的取值有 4 种，共 2 对，在 CSS 中用了语义较为清晰的关键词来表示： open\-quote、 close\-quote、no\-open\-quote、no\-close\-quote。

默认：

```css
.demo::before {
  content: open-quote;
}
.demo::after {
  content: close-quote;
}
```

[![在这里插入图片描述](https://camo.githubusercontent.com/f1833b91f1c40144c4eaa822377e37a8446d694b/68747470733a2f2f696d672d626c6f672e6373646e696d672e636e2f32303139303530383039313232363538362e706e67)](https://camo.githubusercontent.com/f1833b91f1c40144c4eaa822377e37a8446d694b/68747470733a2f2f696d672d626c6f672e6373646e696d672e636e2f32303139303530383039313232363538362e706e67)
自定义引用符号：

```css
.demo {
  quotes: "『" "』";
}
.demo::before {
  content: open-quote;
}
.demo::after {
  content: close-quote;
}
```

[![在这里插入图片描述](https://camo.githubusercontent.com/0da7f13a49e3e5451cca98f9e99784b5b37b9452/68747470733a2f2f696d672d626c6f672e6373646e696d672e636e2f32303139303530383039313331333236392e706e67)](https://camo.githubusercontent.com/0da7f13a49e3e5451cca98f9e99784b5b37b9452/68747470733a2f2f696d672d626c6f672e6373646e696d672e636e2f32303139303530383039313331333236392e706e67)
`quotes` 可以设置多组引用符号，用以应对次级引用：

```css
.demo {
  quotes: "«" "»" "‹" "›";
}
.demo::before {
  content: no-open-quote open-quote;
}
.demo::after {
  content: close-quote;
}
```

[![在这里插入图片描述](https://camo.githubusercontent.com/dc500547cf7dced1838014b52d32c42fd2512752/68747470733a2f2f696d672d626c6f672e6373646e696d672e636e2f32303139303530383039313531393731392e706e67)](https://camo.githubusercontent.com/dc500547cf7dced1838014b52d32c42fd2512752/68747470733a2f2f696d672d626c6f672e6373646e696d672e636e2f32303139303530383039313531393731392e706e67)

## 总结

以上我们主要了解了 `content` 的一些用法和巧用，当然 `:before` 和 `:after` 本身作为元素，也可以实现多种应用效果，比如：三角形（border）、装饰元素、阴影等。希望通过以上介绍，能让大家对 `content` 有更深入的了解，帮助我们在平时的布局和样式以及用户体验中发挥更大的价值。


CSS 的 `content` 一般用在 `::before/after` 这类的伪元素中。并且如果 `::before` 和 `::after` 元素如果不设置 `content` 属性的话，也是没有效果的。

| 序号 | 属性 | 用法 |
| --- | --- | --- |
| 1 | '字符串' | content: 'xxx' 单纯显示内容。一般在文字的前后添加内容或者图标。 |
| 2 | `attr()` | content: attr(attributes) 动态显示对应标签的属性 |
| 3 | `url()` | content: url(url) 插入图片 |
| 4 | `counter()` | content: counter(name) `counter` 的 `name` 可以自己定义。需要配合 `counter-increment` 和 `counter-reset` 一起使用。 |
| 5 | `open-quote` 和 `close-quote` | content: open\-quote; 实现自定义的引号，一般用来匹配多语言的情况。 |
