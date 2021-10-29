# Crashsymbol
iOS crash文件解析 项目符号不显示解决方案


###背景
线上app崩溃后，拿到的crash文件只有地址和偏移地址，需要将crash文件或者ips文件符号化，才能定位出具体crash的位置。

####一、清单1【由测试组提供】
1、`.crash`或者`.ips文件`【必须】
2、`*.app.dSYM文件`【必须】
3、`ipa`【可选】
4、`dSYMs文件夹`，具体符号在这个文件夹里【必须】
`/dSYMs/Contents/Resources/DWARF/文件，此文件大小大概为50多M`
例如：`/dSYMs/Contents/Resources/DWARF/5.0【文件名为5.0】`



####二、清单2【开发】
1、`crash_address.sh脚本`【单个地址脚本】【必须】
2、`crash_symbol.sh脚本`【整个crash解析脚本】【必须】

####三、步骤
#####1、新建文件夹crash
#####2、将清单1和清单2 拷贝到crash文件夹
#####3、确认清单
#####4、打开终端cd到crash文件夹

#####5、校验三个文件【.app(ipa解压)、.crash、.dSYM】的uuid，确保三个uuid一致。
  (1)校验.app：  
```
dwarfdump --uuid xx.app/xx (xx代表你的项目名)
```
  (2)校验.dSYM： 
```
dwarfdump --uuid xx.app.dSYM
```
  (3)校验.crash：
```
crash文件内 Binary Images: 下面一行中 <> 内的地址就是该.crash文件的uuid(已去掉了分隔符“-”)
```
#####6、将`原始.crash文件`符号化：
   (1) 获取`symbolicatecrash工具`
   - 打开终端输入以下命令：
```
find /Applications/Xcode.app -name symbolicatecrash -type f
```
 - 我找到的路径是：

```
/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash
```
- 根据路径前往文件夹找到`symbolicatecrash` ，将其拷贝到`crash文件夹`。

   
   (2) 终端输入：
```
sh crash_symbol.sh crash文件 dSYM文件
```
   (3) 若出现`"No symbolic information found"`，检查一下三个文件的uuid是否一样
#####7、将项目崩溃地址符号化：
   经过`第6步`得到的结果，`crashlog.crash`文件，打开后如果发现系统库已经显示具体代码符号，而我们的代码仍然是地址。
   则需要将具体地址符号化：
![](https://upload-images.jianshu.io/upload_images/4096235-11f9fbc5a277b8ae.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

   (1) 终端输入：
```
sh crash_address.sh dSYMs内文件夹DWARF下的app 地址1 地址2
```
   例如：
```
sh crash_address.sh 5.0 0x102e58000 0x00000001036113dc 
```
说明：5.0是`dSYMs内文件夹DWARF下的app`
   得到结果：
```
-[QLWebViewController webView:shouldStartLoadWithRequest:navigationType:] (in 5.0) (QLWebViewController.m:0)
```

####8、定位结束
参考链接：
[1、对Crash文件,dSYM文件进行符号化](https://www.jianshu.com/p/272d9dd1f8ca)
[2、iOS中符号的那些事儿](http://www.zyiz.net/tech/detail-136520.html)
