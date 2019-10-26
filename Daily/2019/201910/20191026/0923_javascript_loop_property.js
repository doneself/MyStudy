//javascript loop property

var origin = {
	address:"China",
	time:"201910"
}

var o = {
	name:"Rocky",
	age:30,
	description:"This is a man."
};


for(var key in o)
{
	// console.log(key);
	origin[key]= o[key]
}

console.log(origin);
console.log(origin._proto);
