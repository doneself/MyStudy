# [js] 第22天 你对new操作符的理解是什么？手动实现一个new方法 #76

``` javascript
function _new(Fn, ...arg) {
	const obj = Object.create(Fn.prototype);
	const obj1 = Fn.apply(obj, arg);
	return obj1 instanceof Object ? obj1 : obj;
}
```

之前在github看另外一个人写的

## new 的理解

> new 运算符创建一个用户定义的对象类型的实例或具有构造函数的内置对象类型之一

## new步骤

模拟new操作前，要先知道new操作是发生了什么，就拿`new Object()`举例:

1.  创建一个新对象
2.  把新对象的原型指向构造函数的prototype
3.  把构造函数里的this指向新对象
4.  返回这个新对象

## 构造函数：

先准备一个构造函数来`new`使用。

``` javascript
function constructorFunction(name, age){
  this.name = name;
  this.age = age;
}
constructorFunction.prototype.say = function(){
  return 'Hello '+ this.name
}

```

## 原生new：

``` javascript
var obj = new constructorFunction('willian', 18)
console.log(obj.name, obj.age);//'willian', 18
console.log(obj.say())//Hello willian

```

## 模拟new

模拟的`new` 暂称为`newNew` （囡..囡 哈哈~）
使用： `newNew(constructor, arg1, arg2, ..)` 第0个参数传入构造函数，1~n个参数是构造函数的形参。
使用上面的构造函数试一下：

``` javascript
function newNew(){
 var newObj = {}
 // 1. 创建一个新对象
 var Con = [].shift.call(arguments)
 // 得到构造函数
 newObj.__proto__ = Con.prototype;
 // 2. 把新对象的原型指向构造函数的prototype
 var res = Con.apply(newObj, arguments)
 // 3. 把构造函数里的this指向新对象
 return typeof res === 'object' ? res : newObj;
 // 4. 返回新对象
}
var obj = newNew(constructorFunction, 'willian', 18)
console.log(obj.name, obj.age);//'willian', 18
console.log(obj.say())//Hello willian

```

得到和new 一样的答案，说明模拟成功。
你也可以F12 打开控制台试一试。
以上参考：

1.  [mqyqingfeng/Blog#13](https://github.com/mqyqingfeng/Blog/issues/13)
2.  [https://blog.csdn.net/liwenfei123/article/details/80580883](https://blog.csdn.net/liwenfei123/article/details/80580883)


```js
/**
 * 模拟实现 new 操作符
 * @param  {Function} ctor [构造函数]
 * @return {Object|Function|Regex|Date|Error}      [返回结果]
 */
function newOperator(ctor){
    if(typeof ctor !== 'function'){
      throw 'newOperator function the first param must be a function';
    }
    // ES6 new.target 是指向构造函数
    newOperator.target = ctor;
    // 1.创建一个全新的对象，
    // 2.并且执行[[Prototype]]链接
    // 4.通过`new`创建的每个对象将最终被`[[Prototype]]`链接到这个函数的`prototype`对象上。
    var newObj = Object.create(ctor.prototype);
    // ES5 arguments转成数组 当然也可以用ES6 [...arguments], Aarry.from(arguments);
    // 除去ctor构造函数的其余参数
    var argsArr = [].slice.call(arguments, 1);
    // 3.生成的新对象会绑定到函数调用的`this`。
    // 获取到ctor函数返回结果
    var ctorReturnResult = ctor.apply(newObj, argsArr);
    // 小结4 中这些类型中合并起来只有Object和Function两种类型 typeof null 也是'object'所以要不等于null，排除null
    var isObject = typeof ctorReturnResult === 'object' && ctorReturnResult !== null;
    var isFunction = typeof ctorReturnResult === 'function';
    if(isObject || isFunction){
        return ctorReturnResult;
    }
    // 5.如果函数没有返回对象类型`Object`(包含`Functoin`, `Array`, `Date`, `RegExg`, `Error`)，那么`new`表达式中的函数调用会自动返回这个新的对象。
    return newObj;
}
```

参考 [https://juejin.im/post/5bde7c926fb9a049f66b8b52#heading\-5](https://juejin.im/post/5bde7c926fb9a049f66b8b52#heading-5)
