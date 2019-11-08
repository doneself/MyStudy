# [js] 第26天 说说bind、call、apply的区别？并手写实现一个bind的方法 #92

`call`和`apply`都是为了解决改变`this`的指向。作用都是相同的，只是传参的方式不同。

除了第一个参数外，`call`可以接收一个参数列表，`apply`只接受一个参数数组。 `bind`绑定完之后返回一个新的函数，不执行。

``` javascript
Function.prototype.myCall = function (context = window) {
  context.fn = this;

  var args = [...arguments].slice(1);

  var result = context.fn(...args);
  // 执行完后干掉
  delete context.fn;
  return result;
}

Function.prototype.myApply = function (context = window) {
  context.fn = this;

  var result
  // 判断 arguments[1] 是不是 undefined
  if (arguments[1]) {
    result = context.fn(...arguments[1])
  } else {
    result = context.fn()
  }

  delete context.fn
	return result;
}

Function.prototype.myBind = function (context) {
  if (typeof this !== 'function') {
    throw new TypeError('Error')
  }
  var _this = this
  var args = [...arguments].slice(1)
  // 返回一个函数
  return function F() {
    // 因为返回了一个函数，我们可以 new F()，所以需要判断
    if (this instanceof F) {
      return new _this(...args, ...arguments)
    }
    return _this.apply(context, args.concat(...arguments))
  }
}	
```

# JavaScript 中 call()、apply()、bind() 的用法

其实是一个很简单的东西，认真看十分钟就从一脸懵B 到完全 理解！

先看明白下面：

``` javascript
var name='小王'
var obj = {
	name:'小张',
	objAge:this.age,
	myFun:function(){
		console.log(this.name + '年龄' + this.age);
	}
}
obj.objAge;//17
obj.myFun();//小张年龄 undefined

var fav = '盲曾';
function shows(){
	console.log(this.fav);
}
shows();//盲曾
```
比较一下这两者 this 的差别，第一个打印里面的 this 指向 obj，第二个全局声明的 shows() 函数 this 是 window ；

## 1，call()、apply()、bind() 都是用来重定义 this 这个对象的！

``` javascript
var name = '小王'
var age = 17;
var obj={
	name:'小张',
	objAge:this.age,
	myFun:function(){
		console.log(this.name + '年龄' + this.age);
	}
}

var db ={
	name:'德码',
	age:99
}

obj.myFun.call(db)；　　　　// 德玛年龄 99
obj.myFun.apply(db);　　　 // 德玛年龄 99
obj.myFun.bind(db)();　　　// 德玛年龄 99
```

以上出了 bind 方法后面多了个 () 外 ，结果返回都一致！

由此得出结论，bind 返回的是一个新的函数，你必须调用它才会被执行。

## 2，对比call 、bind 、 apply 传参情况下

``` javascript
var name= '小王';
var age = 17;
var obj={
	name:'小张',
	objAge:this.age,
	myFun:function(fm,t){
		console.log(this.name + ' 年龄 ' + this.age + "来自" + fm + '去往' + t);
	}
}
var db = {
	name:'德码',
	age:99
}

obj.myFun.call(db,'成都','上海')；　　　　 // 德玛 年龄 99  来自 成都去往上海
obj.myFun.apply(db,['成都','上海']);      // 德玛 年龄 99  来自 成都去往上海  
obj.myFun.bind(db,'成都','上海')();       // 德玛 年龄 99  来自 成都去往上海
obj.myFun.bind(db,['成都','上海'])();　　 // 德玛 年龄 99  来自 成都, 上海去往 undefined
```

微妙的差距！

从上面四个结果不难看出:

call 、bind 、 apply 这三个函数的第一个参数都是 this 的指向对象，第二个参数差别就来了：

call 的参数是直接放进去的，第二第三第 n 个参数全都用逗号分隔，直接放到后面 obj.myFun.call(db,'成都', ... ,'string' )。

apply 的所有参数都必须放在一个数组里面传进去 obj.myFun.apply(db,\['成都', ..., 'string' \])。

bind 除了返回是函数以外，它 的参数和 call 一样。

当然，三者的参数不限定是 string 类型，允许是各种类型，包括函数 、 object 等等！

> 原文地址：https://www.cnblogs.com/Shd\-Study/p/6560808.html
