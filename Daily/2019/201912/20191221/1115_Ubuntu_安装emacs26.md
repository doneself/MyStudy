# Ubuntu 安装emacs26

什么是Emacs编辑器？

Emacs文本编辑器另外称为GNU Emacs是一个自由文本编辑器，它可用于不同的平台，如Windows，Linux和MacOS。Emacs的标语就是“可扩展、可定制、自文档化的实时显示编辑器。 它还可以用作许多编程语言（如Python，Java等）的集成开发环境（IDE）。要注意的是，在它的口号中，并没有提到“易用”或者是“直观”。这并不是为那些需要“所见即所得”软件的用户而设的，如果你需要一些像拼写检查这样的写作工具，它也不适合你。

1.通过Ctrl + Alt + T键盘快捷键或从开始菜单中搜索“终端”来打开终端。 打开时，运行命令添加PPA：

sudo add-apt-repository ppa:kelleyk/emacs

输入并按Enter键输入用户密码（由于安全原因没有星号反馈）。

2.然后通过Synaptic软件包管理器安装Emacs26，或者在终端中逐个运行以下命令：

sudo apt update

sudo apt install emacs26

对于纯文本界面，请在最后一个命令中将emacs26替换为emacs26-nox。 而Ubuntu 18.04及更高版本可以跳过apt update命令。

安装完成后，从系统应用程序启动器中打开emacs即可享受！

如何删除：

要删除Emacs26，请打开终端并运行命令：

sudo apt remove --autoremove emacs26 emacs26-nox

可以通过软件和更新 - >其他软件选项卡删除PPA。
