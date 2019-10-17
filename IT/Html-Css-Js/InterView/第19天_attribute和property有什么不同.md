# [js] 第19天 "attribute"和"property"有什么不同？ #64

*   property是DOM中的属性，是JavaScript里的对象
*   attribute是HTML标签上的特性，它的值只能够是字符串

在操作 DOM 时，我们经常会操作 `attribute` 和 `property`。不过从两者的所属关系上来说： `property` 属于 DOM Object，而 `atrribute` 属于 HTML。

`property` 通常比较容易获取，并且有固定的值（当然，类似 JavaScript 的对象，我们可以添加自定义的值，只是这些不会被 DOM 所认识）。
比如 `el.id`、`el.value`、`el.style` 都是 `property` 而设置也只需要 `el.id=newId` 即可。
`attribute` 的值不是固定的，我们可以自己为 DOM 添加需要的属性（以前常常用来存放数据或者标志位，在 HTML5 有了 `data-*` 的属性后，一般就利用 `data-*` 来存放数据了）。
对于 `attribute` 的设定和获取我们使用 `setAttribute` 和 `getAttribute` 两个方法。

在书写方面 `property` 对于大小写敏感；而 `attribute` 对于大小写不敏感。

总的来看 `property` 的值更偏向于标准而 `attribute` 的值更偏向于自定义和非标准。
