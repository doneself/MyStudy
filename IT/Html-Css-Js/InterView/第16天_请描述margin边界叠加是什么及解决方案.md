# [css] 第16天 请描述margin边界叠加是什么及解决方案 #51

1. 使用padding代替，但是父盒子要减去相应的高度
2. 使用boder（透明）代替（不推荐，不符合书写规范，如果父盒子子盒子时有颜色的不好处理）
3. 给父盒子设置overflow：hidden(如果有移除元素无法使用)
4. 给父盒子设置1px的padding
5. 给父盒子设置1px的透明border，高度减1px
6. 子盒子使用定位position
7. 子盒子浮动, 但是居中比较难以控制
8. 给子盒子设置display: inline-block;
9. 子盒子上面放一个table标签


margin 的边界叠加发生在竖直方向上（左右方向上不会叠加）。
兄弟 DOM 节点、父元素中的第一个子节点、以及最后一个尾节点都会产生 margin 边界叠加的现象。
由于 CSS 早期主要用在文字、图片排版上，因此上下 margin 的叠加是符合预期效果的。

margin 边界叠加从结果上来看就是以最大的值为准。

``` html
<style>
  .b1 {
    width: 100px;
    height: 100px;
    margin-bottom: 30px;
  }
  // 最终两个 div 的 margin 为 40px，以最大的值为准。
  .b2 {
    width: 100px;
    height: 100px;
    margin-top: 40px;
  }
</style>

<div class="b1"></div>
<div class="b2"></div>
```

margin 边界叠加只会出现在普通文档流中，所以可以触发 BFC 来解决。
除此之外，也可以使用 padding 来代替 margin 或者增加 border 的值。
