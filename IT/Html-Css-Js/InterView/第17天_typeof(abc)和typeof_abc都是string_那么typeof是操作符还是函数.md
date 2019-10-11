## [js] 第17天 typeof('abc')和typeof 'abc'都是string, 那么typeof是操作符还是函数？

typeof 是操作符，不是函数。可以添加括号，但是括号的作用是进行分组而非函数的调用。

假设typeof是函数
则调用typeof(typeof)应该返回一个字符串'function'
但是实际操作会报错
所以typeof不是函数

typeof 是操作符，明确定义在MDN当中,作用是对后方表达式的返回做类型定义。
在后面添加括号其实是改变计算优先级，和四则运算中的括号可以等效理解。
简单举例

``` javascript
typeof 123 //"number"
typeof 123+'abc'// "numberabc"
typeof(123+'abc') // "string"
```

