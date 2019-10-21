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


function Person(fitst, last, age, gender, interests){
	this.name = {
		'first': first,
		'last': last
	};
	this.age = age;
	this.gender = gender;
	this.interests = interests;
	this.bio = function(){
		alert(this.name.first + ' ' + this.name.last + ' is ' + this.age + ' years old. He likes ' + this.interests[0] + ' and ' + this.interests[1] + '.');
	};
	this.greeting = function(){
		alert('Hi! I\'m ' + this.name.first + '.');
	};
}

var person3 = new Person('Bob', 'Smith', 32, 'male', ['music', 'skiing']);

//Object()构造函数
//首先, 您能使用Object()构造函数来创建一个新对象。 是的， 一般对象都有构造函数，它创建了一个空的对象。

var person4 = new Object();
person4.name = 'Chris';
person4['age'] = 38;
person1.greeting = function(){
	alert('Hi! I\'m ' + this.name.first + '.');
}

//还可以将对象文本传递给Object() 构造函数作为参数， 以便用属性/方法填充它。请尝试以下操作：
var person5 = new Object({
  name : 'Chris',
  age : 38,
  greeting : function() {
    alert('Hi! I\'m ' + this.name + '.');
  }
});

// 使用create()方法
// JavaScript有个内嵌的方法create(), 它允许您基于现有对象创建新的对象。

var person6 = Object.create(person1);


// 您可以看到，person2是基于person1创建的， 它们具有相同的属性和方法。这非常有用， 因为它允许您创建新的对象而无需定义构造函数。缺点是比起构造函数，浏览器在更晚的时候才支持create()方法（IE9,  IE8 或甚至以前相比）， 加上一些人认为构造函数让您的代码看上去更整洁 —— 您可以在一个地方创建您的构造函数， 然后根据需要创建实例， 这让您能很清楚地知道它们来自哪里。

// 但是, 如果您不太担心对旧浏览器的支持， 并且您只需要一个对象的一些副本， 那么创建一个构造函数可能会让您的代码显得过度繁杂。这取决于您的个人爱好。有些人发现create() 更容易理解和使用。

// 稍后我们将更详细地探讨create() 的效果。
