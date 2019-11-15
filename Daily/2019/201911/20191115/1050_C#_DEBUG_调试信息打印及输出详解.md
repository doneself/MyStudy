# C# DEBUG 调试信息打印及输出详解
https://blog.csdn.net/aaaaatiger/article/details/5583301

 

1.debug只在[debug模式下才执行](运行按钮后面的下拉框可选)  


2.debug提供了许多调试指令，如断言  
      System.Diagnostics.Debug.Assert(false,"信息");  
      将出现一个对话框  


 3.debug可以自定义监听器  
  (下例将信息存入磁盘文件)  
  System.Diagnostics.TextWriterTraceListener   t=new   System.Diagnostics.TextWriterTraceListener(@"c:/a.txt");  
  System.Diagnostics.Debug.Listeners.Add(t);  
  System.Diagnostics.Debug.WriteLine("信息");  
  t.Flush();

 

 

4. debug和console.write()有什么区别？

   debug在运行状态时向ide的限时窗口输出（用于windows   窗体程序)  
   console.write用于控制台程序，使用程序在运行时可以向控制台（就是dos界面的那个)输出信息   

  二者同样是输入，但Debug是输出到output窗口，而Console是输出到控件台窗口，  
  而且Debug必须要在Debug情况下才有效，你按Ctrl+F5后会看到Console的输出，  
  按F5后也能看到Console的输出，还可以看到output中Debug的输出

