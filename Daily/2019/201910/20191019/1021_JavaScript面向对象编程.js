// JavaScript面向对象编程

// 全局命名空间
var MYAPP = MYAPP || {};

// 子命名空间
MYAPP.event = {};

// 给普通方法和属性创建一个叫做MYAPP.commonMethod的容器
MYAPP.commonMethod = {
	regExForName: "",// 定义名字的正则验证
	regExForPhone: "",// 定义电话的正则验证
	validateName: funciton(name){
		// 对名字name做些操作，你可以通过使用“this.regExForname”
		// 访问regExForName变量
	},
	validatePhone: funciton(phoneNo){
		// 对电话号码做操作
	}
}

MYAPP.event = {
	addListener: function(el, type, fn){
		// code
	},
	removeListener: funciton(el, type, fn){
		//code
	},
	getEvent: function(e){
		//code
	}
}

//使用addListener方法的写法:
MYAPP.event.addListener("yourel", "type", callback);

