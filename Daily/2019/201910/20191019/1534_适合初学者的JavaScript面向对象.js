//让我们看看如何通过一个普通的函数定义一个”人“。在您的文件中添加以下代码:
// https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/Objects/Object-oriented_JS

function createNewPerson(name){
	var obj = {};
	obj.name = name;
	obj.greeting = function(){
		alert('HI!I\'m' + this.name + '.');
	}
	return obj;
}

var salva = createNewPerson('salva');
salva.greeting();

//上述代码运行良好，但是有点冗长；如果我们知道如何创建一个对象，就没有必要创建一个新的空对象并且返回它。幸好 JavaScript 通过构建函数提供了一个便捷的方法，方法如下：

function Person(name){
	this.name = name;
	this.greeting = function(){
		alert('HI!I\'m' + this.name + '.');
	}
}

/*
 * 这个构建函数是 JavaScript 版本的类。您会发现，它只定义了对象的属性和方法，
 * 除了没有明确创建一个对象和返回任何值和之外，
 * 它有了您期待的函数所拥有的全部功能。
 * 这里使用了this关键词，即无论是该对象的哪个实例被这个构建函数创建，
 * 它的 name 属性就是传递到构建函数形参name的值，
 * 它的 greeting() 方法中也将使用相同的传递到构建函数形参name的值。
 */

var person1 = new Person('Bob');
var person2 = new Person('Sarah');

person1.greeting();
person2.greeting();

