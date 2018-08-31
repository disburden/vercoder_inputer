# vercoder_inputer
Enter the verification code received by the phone or other device.  
一个基于flutter的验证码输入框控件.

## Demo  
控制用户精准输入长度. 
<!--![](https://github.com/disburden/vercoder_inputer/blob/master/ScreenShots/verCode.gif?raw=true) --> 

## Features
- [x] **可以自定义验证码长度**  
- [x] **当全部输入完成后,会自动调用回调,返回验证码及上下文context**  
- [x] **可以通过verCode属性获取输入的验证码**
- [x] **用户自定义控件的尺寸**  


## Version
name|VercodeEditText
---|---
latest|0.3.1

## Usage
1.第一步,在你的pubspec.yml声明

```
   dependencies:
     vercoder_inputer: ^0.3.1
```
2.添加引用

```
import 'package:vercoder_inputer/vercoder_inputer.dart';
...

```
3.在需要使用的页面创建控件   
```  
class _MyHomePageState extends State < MyHomePage > {

	WGQVerCodeInputer verCodeInputer = WGQVerCodeInputer(codeLength: 6, parnetSize: Size(375.0, 48.0), finishInput: (verCode, ctx) {
		print("veris $verCode");
	}, );
	
	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			appBar: new AppBar(
				title: new Text(widget.title),
			),
			body: Padding(
				padding: EdgeInsets.only(top: 100.0),
				child: verCodeInputer,
			)
		);
	}
} 
```
# Contact me
- Email:  disburden@gmail.com
- blog: http://blog.wgq.name