# cmd命令行的FTP使用

## 进入ftp：
ftp

## 打开连接:
open 192.168.1.106 2121

## 用户名空：
none

## 密码空：
不用输入，直接回车

## 查询远程服务器当前路径：
pwd

## 显示远程服务器当前路径下的文件：
dir

## 远程服务器切换目录：
cd

## 二进制传输:
bin

## 上传文件：
put (可以直接把文件拖进命令框中，使用文件的绝对路径也可以上传)

## 下载文件：
get

## 打开/关闭交互模式：
prompt

## 批量上传：
mput \*.txt

## 批量下载：
mget \* (所有文件)  
mget \*.txt (所有.txt结尾的文件)

## 创建目录：
mkdir

## 删除目录：
rmdir

## 删除文件：
delete

## 批量删除：
mdelete \*.txt  
mdelete \*

## 查看本地当前所在路径，查看路径下的文件：
!dir

## 切换本地路径：
lcd d:/

## 退出：
bye
