import 'package:flutter/material.dart';
import 'package:vercoder_inputer/src/Options.dart';

typedef FinishInput = void Function(WGQVerCodeInputer inputer, String verCoder, BuildContext ctx);

abstract class InputerProtocol {
	void didFinishedInputer(WGQVerCodeInputer inputer, BuildContext ctx, String verCode);
}

class WGQVerCodeInputer extends StatefulWidget {
	int codeLength = 6;
	final Size size;
	double gap = 8.0;

	// final FinishInput finishInput;

	String get verCode {
		return myState.getVerCode();
	}

	InputerProtocol delegate;

	_InputerState myState;

	String getVerCode() {
		return myState.getVerCode();
	}

	void reset(){
		myState.reset();
	}

	Options options;

	WGQVerCodeInputer({
		this.codeLength,
		this.size,
		this.options,
		this.delegate,
	}) {
		if (options == null) {
			print('need init options');
			options = Options();
		}
		this.options = options;
	}

	@override
	_InputerState createState() {
		myState = _InputerState();
		return myState;
	}
}

class _InputerState extends State <WGQVerCodeInputer> {

	List <Widget> tfs;
	List <TextEditingController> tfCtrls;
	List <String> backStrs;
	List <FocusNode> fns;

	@override
	initState() {
		super.initState();
		tfCtrls = List.generate(widget.codeLength, (index) {
			TextEditingController ctrl = TextEditingController();
			ctrl.addListener(() {});
			return ctrl;
		});

		backStrs = List.generate(widget.codeLength, (index) {
			return "●";
		});

		fns = List.generate(widget.codeLength, (index) {
			FocusNode fn = FocusNode();
			return fn;
		});

		WidgetsBinding.instance.addPostFrameCallback((_) {
			setState(() {

			});
		});
	}

	String getVerCode() {
		if (tfCtrls != null) {
			List <String> codeStr = tfCtrls.map((ctrl) {
				String char = ctrl.text == "●" ? "" : ctrl.text;
				return char;
			}).toList();
			return codeStr.join();
		}
		return "";
	}

	void reset(){
		for (TextEditingController ctrl in tfCtrls) {
			ctrl.text = "●";
		}
		FocusScope.of(context).requestFocus(fns[0]);
		setState(() {});
	}


	@override
	Widget build(BuildContext context) {
		Options opt = widget.options;
		TextField findTextFieldByIndex(int index) {
			Container tfContainer = tfs[index];
			Padding padding = tfContainer.child;
			Theme theme = padding.child;
			GestureDetector gesture = theme.child;
			Container container = gesture.child;
			TextField tf = container.child;
			return tf;
		}

		void setTextFieldSelectAll(int tfIndex) {
			TextEditingController ctrl = tfCtrls[tfIndex];
			ctrl.selection = TextSelection(baseOffset: 0, extentOffset: ctrl.text.length);
		}

		void setFocusedTextFiled(int tfIndex) {
			if (tfIndex > widget.codeLength - 1 || tfIndex < 0) {
				return;
			}
			TextField tf = findTextFieldByIndex(tfIndex);
			FocusScope.of(context).requestFocus(tf.focusNode);
			setTextFieldSelectAll(tfIndex);
		}

		void setTextFieldValue(String text, int tfIndex) {
			TextEditingController ctrl = tfCtrls[tfIndex];
			ctrl.text = text;
			setTextFieldSelectAll(tfIndex);
			setState(() {});
		}

		bool checkCode() {
			bool flag = true;
			for (TextEditingController tf in tfCtrls) {
				if (tf.text.isEmpty || tf.text == "●") {
					flag = false;
					break;
				}
			}
			return flag;
		}

		void _handleChange(String text, int index) {
			String oldtxt = backStrs[index];
			print("str:$text ${text.length} old:$oldtxt");
			if (text.length == 0) {

				if (index > 0 && oldtxt == "●") {
					setFocusedTextFiled(index - 1);
					setTextFieldValue('●', index-1);
					backStrs[index-1] = '●';
					setState(() {});
				} else {
					setTextFieldValue('●', index);
					backStrs[index] = '●';
				}
			} else {
				setTextFieldValue(text, index);
				setFocusedTextFiled(index + 1);
				backStrs[index] = "";
			}


//			String oldtxt = backStrs[index];
//			if (text.length == 0) {
//				// print('$index 文本框值发生改变,变为空');
//				setTextFieldValue('●', index);
//				// print('$index 文本框设置为默认值●');
//
//				if (index > 0 && index<widget.codeLength-1 && oldtxt == "●") {
//					// print('${index-1} 设置焦点');
//					setTextFieldValue('●', index-1);
//					setFocusedTextFiled(index - 1);
//				}
//				return;
//			} else {
//				// print('$index 文本框值发送改变,变为$text');
//				setTextFieldValue(text, index);
//				// print('${index+1} 设置焦点');
//				backStrs[index] = text;
//				setFocusedTextFiled(index + 1);
//			}


			///如果验证码全部输入完,调用回调
			if (checkCode()) {
				if (widget.delegate != null) {
					widget.delegate.didFinishedInputer(widget, context, getVerCode());
				}
			}
		}

		void focused(int index) {
			TextField tf = findTextFieldByIndex(index);
			TextEditingController ctrl = tfCtrls[index];

			if (tf.focusNode.hasFocus) {
				// print('$index 获得焦点');
				if (ctrl.text.isEmpty || ctrl.text == '●') {
					// print('$index 内容为空,设置为默认值');
					ctrl.text = '●';
				}
			}
			// print('$index 设置内容全选');
			setTextFieldSelectAll(index);
		}

		tfs = List.generate(widget.codeLength, (index) {
			FocusNode fc = fns[index];
			fc.addListener(() {
				focused(index);
			});

			///获取当前皮肤
			final ThemeData base = Theme.of(context);


			TextEditingController ctrl = tfCtrls[index];
			Color borderColor = (ctrl.text.isEmpty || ctrl.text == '●') ? opt.emptyUnderLineColor : opt.inputedUnderLineColor;
			Color textColor = (ctrl.text.isEmpty || ctrl.text == '●') ? Colors.transparent : opt.fontColor;


			if (fc.hasFocus) {
				borderColor = opt.focusedColor;
			}

			ThemeData buildDarkTheme() {
				return base.copyWith(
					textSelectionColor: Colors.transparent,
					secondaryHeaderColor: Colors.transparent,
					accentColor: Colors.white,
					inputDecorationTheme: InputDecorationTheme(
						disabledBorder: new UnderlineInputBorder(
							borderSide: new BorderSide(color: borderColor)),
					),
				);
			}

			return Container(
				width: (widget.size.width / widget.codeLength),

				child: Padding(
					padding: EdgeInsets.all(widget.gap),

					child: Theme(
						data: buildDarkTheme(),
						child: GestureDetector(
							onTap: () {
//								setFocusedTextFiled(index);
							},
							behavior: HitTestBehavior.opaque,
							child: Container(
								child: TextField(
									controller: ctrl,
									key: Key(index.toString()),
									textAlign: TextAlign.center,
									keyboardType: TextInputType.number,
									maxLength: 1,
									cursorColor: Colors.transparent,
									cursorWidth: 1,
									enabled: false,
									style: TextStyle(
										fontSize: opt.fontSize,
										color: textColor,
										fontWeight: opt.fontWeight,
									),
									decoration: InputDecoration(
										counterText: "",

									),
									onChanged: (String text) {
										_handleChange(text, index);
									},
									autofocus: index == 0,
									focusNode: fns[index],

								),
							),
						),
					),
				),
			);
		});

		return SizedBox(
			height: widget.size.height,
			width: widget.size.width,
			child: ListView(
				padding: EdgeInsets.zero,
				children: tfs,
				scrollDirection: Axis.horizontal,
			),
		);
	}
}