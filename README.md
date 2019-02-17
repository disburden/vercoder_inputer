# vercoder\_inputer
Enter the verification code received by the phone or other device.  
一个基于flutter的验证码输入框控件.

## Demo  
控制用户精准输入长度.  
![][image-1]

## Features
- [x] **可以自定义验证码长度**  
- [x] **当全部输入完成后,会自动调用协议方法,通过代理返回验证码及上下文context**  
- [x] **可以通过verCode属性获取输入的验证码**
- [x] **用户自定义控件的尺寸**  


## Version
name|VercodeEditText
---|---
latest|0.8.1

## Usage
1.第一步,在你的pubspec.yml声明

	   dependencies:
	     vercoder_inputer: ^0.8.0
2.添加引用

	import 'package:vercoder_inputer/vercoder_inputer.dart';
	...
 
3.在需要使用的页面创建控件,并声明遵守协议方法  
 
```dart
class _MyHomePageState extends State < MyHomePage > implements InputerProtocol{

    //实现协议方法
    void didFinishedInputer(WGQVerCodeInputer inputer,BuildContext ctx,String verCode){
        print("verCode is $verCode");
        
        //判断验证码是否正确
        bool correct = false;//(此处修改成你自己的判断逻辑)
        if (!correct) {
        	inputer.reset();
        }
    }
 
 
 
    @override
    Widget build(BuildContext context) {
        //自定义外观样式(可选)
       Options opt = Options();
       opt.fontSize = 22.0;
       opt.fontColor = Colors.indigo;
       opt.fontWeight = FontWeight.w700;
       opt.emptyUnderLineColor = Colors.green;
       opt.inputedUnderLineColor = Colors.pink;
       opt.focusedColor = Colors.orange;
        //创建控件,并指明代理对象(delegate)
        WGQVerCodeInputer verCodeInputer = WGQVerCodeInputer(codeLength: 6, size: Size(375.0, 48.0), options:opt,delegate:this, );
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

[image-1]:	https://github.com/disburden/vercoder_inputer/blob/555db02e7ebf333cf2dc5562711eec865f184943/ScreenShots/verCode.gif?raw=true