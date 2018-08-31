import 'package:flutter/material.dart';
import 'package:vercoder_inputer/vercoder_inputer.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return new MaterialApp(
			title: 'Flutter Demo',
			theme: new ThemeData(
				// This is the theme of your application.
				//
				// Try running your application with "flutter run". You'll see the
				// application has a blue toolbar. Then, without quitting the app, try
				// changing the primarySwatch below to Colors.green and then invoke
				// "hot reload" (press "r" in the console where you ran "flutter run",
				// or press Run > Flutter Hot Reload in IntelliJ). Notice that the
				// counter didn't reset back to zero; the application is not restarted.
				primarySwatch: Colors.blue,
			),
			home: new MyHomePage(title: 'vercode inputer'),
		);
	}
}

class MyHomePage extends StatefulWidget {
	MyHomePage({
		Key key,
		this.title
	}): super(key: key);

	// This widget is the home page of your application. It is stateful, meaning
	// that it has a State object (defined below) that contains fields that affect
	// how it looks.

	// This class is the configuration for the state. It holds the values (in this
	// case the title) provided by the parent (in this case the App widget) and
	// used by the build method of the State. Fields in a Widget subclass are
	// always marked "final".

	final String title;

	@override
	_MyHomePageState createState() => new _MyHomePageState();
}

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