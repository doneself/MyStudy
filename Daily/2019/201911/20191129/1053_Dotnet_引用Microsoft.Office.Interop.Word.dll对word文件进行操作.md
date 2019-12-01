# Dotnet 引用Microsoft.Office.Interop.Word.dll对word文件进行操作

.net 4.0以上版本添加引用，如果不是4.0以上版本可能没有这个，自己去下载一个Microsoft.Office.Interop.Word.dll应该也可以。

![](https://img-blog.csdn.net/20150421000756732?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvejU0MjYwMTM2Mg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

![](https://img-blog.csdn.net/20150421001125289?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvejU0MjYwMTM2Mg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

![](https://img-blog.csdn.net/20150421001213134?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvejU0MjYwMTM2Mg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

引用完成之后，如果直接用vs进行跑是没有问题的，但是放在iis上面会提示：

检索 COM 类工厂中 CLSID 为 {000209FF\-0000\-0000\-C000\-000000000046} 的组件时失败，原因是出现以下错误: 80070005

这里是权限问题，我们需要设置权限：

在运行栏中输入命令：dcomcnfg，打开组件服务管理窗口，但是却发现找不到Microsoft Word程序，这主要是64位系统的问题，excel是32位的组件，所以在正常的系统组件服务里是看不到的， 可以通过在运行里面输入**comexp.msc \-32** 来打开32位的组件服务，在里就能看到Microsoft Word组件了：

**下面就详细介绍 DCOM 的配置过程。**

1、运行“dcomcnfg”，打开 DCOM 配置程序。（或者 开始→设置→控制面版→管理工具→组件服务→计算机→我的电脑→DCOM配置）

对  Excel 进行编程，实际上就是通过 .Net Framework 去调用 Excel  的 COM 组件，所有要在  Web 环境下调用 COM  组件的时候，都需要对其进行相应的配置。
很多朋友都反映在  Windows 环境下调试正常的程序，一拿到 Web  环境中就出错，实际上就是因为缺少了这一步。

将 “身份标识” 选项卡中的用户设为 “交互式用户” 。

![](https://img-blog.csdn.net/20150421001128153?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvejU0MjYwMTM2Mg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

设置选中 “安全性” 选项卡中的 “使用自定义配置权限”，点击 “编辑”。

![](https://img-blog.csdn.net/20150421001147138?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvejU0MjYwMTM2Mg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

用户添加 EveryOne：

![](https://img-blog.csdn.net/20150421001159649?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvejU0MjYwMTM2Mg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

用户添加 EveryOne：

![](https://img-blog.csdn.net/20150421001212519?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvejU0MjYwMTM2Mg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

**参考：http://blog.csdn.net/lploveme/article/details/8215265**

**他的权限应该配置的是对的，但是我配置后用不了，所以权限给了 EveryOne。​**

**下面就可以使用命名空间了：**

**​using Word = Microsoft.Office.Interop.Word;**

**​1. 解决引用Microsoft.Office.Core \-\-> Interop.Microsoft.Office.Core.dll
　　 先在各个项目“引用”中，删除对Microsoft.Office.Core的引用，然后再右击引用\-\->添加引用\-\->在COM页面的下拉框中，找到Microsoft Office 11.0 Object Library ，按“确定” 就将其加入到 引用**

**后续，放在服务器上后的权限错误：**

*检索COM类工厂中CLSID为{00024500\-0000\-0000\-C000\-000000000046}的组件失败，原因是出现以下错误: 8000401a因为配置标识不正确，系统无法开始服务器进程。请检查用户名和密码。(异常来自HRESULT:0x8000401A)。*

1:必须在所在的服务器安装offce

2:点击电脑开始==>运行:输入：Dcomcnfg 会打开组件服务窗口，点击树菜单上的：组件服务节点===>计算机===>我的电脑====》Microsoft Excle Application==>

右键点击属性===》弹出属性选项卡===》选中安全==》把选项卡中的所有权限选自定义===》编辑==》添加Everyone权限

**3：再点击==》标示===》查看运行此程序的用户===》按理默认都是系统账号，但是有的电脑犯贱，安装的时候变成了启动用户，如果系统账号选择项无法选择，则点击下列用户。（我主要是修改了这里，之前选择的是交互式，现在改成系统帐号和密码就可以了。选择交互式的时候如果远程连接这服务器就可以正常运行，如果断开后就报错。）**

输入账号密码，但是如果服务器修改了密码，错误还是会回到以前一样

4:有的电脑在执行第二步的时候找不到Microsoft Excle Application，则在运行输入：mmc \-32==》点击文件=》添加删除管理单元==》点击添加主键服务==》

组件服务节点===>计算机===>我的电脑====》Microsoft Excle Application==>

右键点击属性===》弹出属性选项卡===》选中安全==》把选项卡中的所有权限选自定义===》编辑==》添加Everyone权限

另外导出错误解决了，有时候还会报无权限下载，这是因为我们导出的Excle文件在服务器的某个文件夹，我们没有权限，同理，右键点击服务器上的文件夹，添加Everyone权限

就可以下载了
