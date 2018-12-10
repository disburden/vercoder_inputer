import 'package:flutter/material.dart';

class Options {
	double fontSize;
	FontWeight fontWeight;
	Color fontColor;
	Color emptyUnderLineColor;
	Color inputedUnderLineColor;
	Color focusedColor;

	Options({
		this.fontSize = 18.0,
		this.fontColor = Colors.black,
		this.emptyUnderLineColor = Colors.grey,
		this.inputedUnderLineColor = Colors.orange,
		this.fontWeight = FontWeight.normal,
		this.focusedColor = Colors.red,
	});

	Options merge({
		double fontSize,
		Color fontColor,
		Color emptyUnderLineColor,
		Color inputedUnderLineColor,
		FontWeight fontWeight,
		Color focusedColor,
	}) {
		return Options(
			fontSize: fontSize??this.fontSize,
			fontColor: fontColor??this.fontColor,
			emptyUnderLineColor: emptyUnderLineColor??this.emptyUnderLineColor,
			inputedUnderLineColor: inputedUnderLineColor??this.inputedUnderLineColor,
			fontWeight: fontWeight??this.fontWeight,
			focusedColor: focusedColor??this.focusedColor,
		);
	}


}