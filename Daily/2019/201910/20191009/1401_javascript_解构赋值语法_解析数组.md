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

交换变量节  
在一个解构表达式中可以交换两个变量的值。  
没有解构赋值的情况下，交换两个变量需要一个临时变量（或者用低级语言中的XOR-swap技巧）。

``` javascript
var a = 1;
var b = 3;

[a, b] = [b, a];
console.log(a); // 3
console.log(b); // 1
```

解析一个从函数返回的数组节  
从一个函数返回一个数组是十分常见的情况。解构使得处理返回值为数组时更加方便。  
在下面例子中，要让 [1, 2] 成为函数的 f() 的输出值，可以使用解构在一行内完成解析。

``` javascript
function f() {
  return [1, 2];
}

var a, b; 
[a, b] = f(); 
console.log(a); // 1
console.log(b); // 2
```

忽略某些返回值节  
你也可以忽略你不感兴趣的返回值：

``` javascript
function f() {
  return [1, 2, 3];
}

var [a, , b] = f();
console.log(a); // 1
console.log(b); // 3
```

你也可以忽略全部返回值：  
[,,] = f();

将剩余数组赋值给一个变量节  
当解构一个数组时，可以使用剩余模式，将数组剩余部分赋值给一个变量。
``` javascript
var [a, ...b] = [1, 2, 3];
console.log(a); // 1
console.log(b); // [2, 3]
```

注意：如果剩余元素右侧有逗号，会抛出 SyntaxError，因为剩余元素必须是数组的最后一个元素。
``` javascript
var [a, ...b,] = [1, 2, 3];
// SyntaxError: rest element may not have a trailing comma
```

用正则表达式匹配提取值节  
用正则表达式的 exec() 方法匹配字符串会返回一个数组，该数组第一个值是完全匹配正则表达式的字符串，然后的值是匹配正则表达式括号内内容部分。解构赋值允许你轻易地提取出需要的部分，忽略完全匹配的字符串——如果不需要的话。

``` javascript
function parseProtocol(url) { 
  var parsedURL = /^(\w+)\:\/\/([^\/]+)\/(.*)$/.exec(url);
  if (!parsedURL) {
    return false;
  }
  console.log(parsedURL); // ["https://developer.mozilla.org/en-US/Web/JavaScript", "https", "developer.mozilla.org", "en-US/Web/JavaScript"]

  var [, protocol, fullhost, fullpath] = parsedURL;
  return protocol;
}

console.log(parseProtocol('https://developer.mozilla.org/en-US/Web/JavaScript')); // "https"
```

