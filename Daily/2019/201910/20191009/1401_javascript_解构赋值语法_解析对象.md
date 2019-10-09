# 1401_javascript_解构赋值语法_解析对象.md

## 解构对象
基本赋值

``` javascript
var o = {p: 42, q: true};
var {p, q} = o;

console.log(p); // 42
console.log(q); // true
```

无声明赋值  
一个变量可以独立于其声明进行解构赋值。
``` javascript
var a, b;

({a, b} = {a: 1, b: 2});
```

注意：赋值语句周围的圆括号 ( ... ) 在使用对象字面量无声明解构赋值时是必须的。  
{a, b} = {a: 1, b: 2} 不是有效的独立语法，因为左边的 {a, b} 被认为是一个块而不是对象字面量。  
然而，({a, b} = {a: 1, b: 2}) 是有效的，正如 var {a, b} = {a: 1, b: 2}  
你的 ( ... ) 表达式之前需要有一个分号，否则它可能会被当成上一行中的函数执行。

给新的变量名赋值  
可以从一个对象中提取变量并赋值给和对象属性名不同的新的变量名。

``` javascript
var o = {p: 42, q: true};
var {p: foo, q: bar} = o;
 
console.log(foo); // 42 
console.log(bar); // true
```

默认值  
变量可以先赋予默认值。当要提取的对象没有对应的属性，变量就被赋予默认值。

``` javascript
var {a = 10, b = 5} = {a: 3};

console.log(a); // 3
console.log(b); // 5
```

给新的变量命名并提供默认值  
一个属性可以同时 1）从一个对象解构，并分配给一个不同名称的变量 2）分配一个默认值，以防未解构的值是 undefined。

``` javascript
var {a:aa = 10, b:bb = 5} = {a: 3};

console.log(aa); // 3
console.log(bb); // 5
```

