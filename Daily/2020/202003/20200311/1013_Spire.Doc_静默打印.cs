//Spire.Doc 静默打印
//使用Spire.Doc，程序员可以通过调用打印对话框（PrintDialog）来进行打印设置，或者通过静默打印方式直接打印Word文档。

/// <summary>
///   静默打印
/// </summary>
//初始化Document实例
Document doc = new Document();

//加载一个Word文档
doc.LoadFromFile("sample.docx");

//获取PrintDocument对象
PrintDocument printDoc = doc.PrintDocument;

//设置PrintController属性为StandardPrintController，用于隐藏打印进程
printDoc.PrintController = new StandardPrintController();

//打印文档
printDoc.Print();


/// <summary>
///   弹框打印
/// </summary>
//初始化Document实例
Document doc = new Document();

//加载一个Word文档
doc.LoadFromFile("sample.docx");

//初始化PrintDialog实例
PrintDialog dialog = new PrintDialog();

//设置打印对话框属性
dialog.AllowPrintToFile = true;
dialog.AllowCurrentPage = true;
dialog.AllowSomePages = true;

//设置文档打印对话框
doc.PrintDialog = dialog;

//显示打印对话框并点击确定执行打印
PrintDocument printDoc = doc.PrintDocument;
if (dialog.ShowDialog() == DialogResult.OK)
{
    printDoc.Print();
}
