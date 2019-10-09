# javascript 解构赋值语法

解构赋值语法是一种 Javascript 表达式。
通过解构赋值, 可以将属性/值从对象/数组中取出,赋值给其他变量。

``` javascript
var a, b, rest;
[a, b] = [10, 20];

console.log(a);
// expected output: 10

console.log(b);
// expected output: 20

[a, b, ...rest] = [10, 20, 30, 40, 50];

console.log(rest);
// expected output: [30,40,50]
```

``` javascript
var a, b, rest;
[a, b] = [10, 20];
console.log(a); // 10
console.log(b); // 20

[a, b, ...rest] = [10, 20, 30, 40, 50];
console.log(a); // 10
console.log(b); // 20
console.log(rest); // [30, 40, 50]

({ a, b } = { a: 10, b: 20 });
console.log(a); // 10
console.log(b); // 20


// Stage 4（已完成）提案中的特性
({a, b, ...rest} = {a: 10, b: 20, c: 30, d: 40});
console.log(a); // 10
console.log(b); // 20
console.log(rest); // {c: 30, d: 40}
```


## 描述节
对象和数组逐个对应表达式，或称对象字面量和数组字面量，
提供了一种简单的定义一个特定的数据组的方法。

var x = [1, 2, 3, 4, 5];

解构赋值使用了相同的语法，不同的是在表达式左边定义了要从原变量中取出什么变量。

``` javascript
var x = [1, 2, 3, 4, 5];
var [y, z] = x;
console.log(y); // 1
console.log(z); // 2
```

JavaScript 中，解构赋值的作用类似于 Perl 和 Python 语言中的相似特性。

## 解构数组

变量声明并赋值时的解构
``` javascript
var foo = ["one", "two", "three"];

var [one, two, three] = foo;
console.log(one); // "one"
console.log(two); // "two"
console.log(three); // "three"
```

变量先声明后赋值时的解构
``` javascript
var a, b;

[a, b] = [1, 2];
console.log(a); // 1
console.log(b); // 2
```

默认值  
为了防止从数组中取出一个值为undefined的对象，可以在表达式左边的数组中为任意对象预设默认值。

``` javascript
var a, b;

[a=5, b=7] = [1];
console.log(a); // 1
console.log(b); // 7
```

