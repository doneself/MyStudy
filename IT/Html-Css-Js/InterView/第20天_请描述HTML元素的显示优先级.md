[html] 第20天 请描述HTML元素的显示优先级 #66


#### 在html中，帧元素（frameset）的优先级最高，表单元素比非表单元素的优先级要高。

*   表单元素:
    *   文本输入框，密码输入框，单选框，复选框，文本输入域，列表框等等
*   非表单元素
    *   链接（a），div, table, span 等等

#### 有窗口元素比无窗口元素的优先级高

*   有窗口元素
    *   select元素，object元素，以及frames元素等等
*   无窗口元素
    *   大部分html元素都是无窗口元素


HTML 元素显示优先级简单来说就是：帧元素（frameset) 优先级最高（frameset 已经不提倡使用了）。
其次**表单元素** > **非表单元素**，即 `input type="radio"` 之类的表单控件 > 普通的如 `a`,`div` 等元素。

从有窗口和无窗口元素来分，有**窗口元素** > **无窗口元素**。有窗口元素如 Select 元素、Object 元素。

另外 `z-index` 属性也可以改变显示优先级，但只对同种类型的元素才有效。
如果两个元素分别为 **表单元素** 和 **非表单元素** 那么 `z-index` 是无效的。
[在这个例子中可以看到，select 就是在 div 的上面，尽管 div 设置了 `z-index:100;`](https://codepen.io/Konata9/pen/VVoJKM)

参考文章：[HTML 元素的优先级](https://blog.csdn.net/wulex/article/details/76222563)
