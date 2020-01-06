html script标签的事件属性

``` html
<script language= "javascript " for= "window " event= "onload ">
```

- EVENT   event   设置或获取脚本编写用于的事件  
- FOR   htmlFor   设置或获取绑定到事件脚本的对象。

可以这样理解。

``` html
<script   language= "javascript "   for= "window "   event= "onload ">
	//   TODO
</script>
```

相当于

``` html
<script   language= "javascript ">
//   绑定
window.attachEvent( "onload ",function()   {
//   TODO
})
</script>
```

