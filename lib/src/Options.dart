import 'package:flutter/material.dart';

class Options {
	double fontSize;
	FontWeight fontWeight;
	Color fontColor;
	Color emptyUnderLineColor;
	Color inputedUnderLineColor;

	Options({
		this.fontSize = 18.0,
		this.fontColor = Colors.black,
		this.emptyUnderLineColor = Colors.grey,
		this.inputedUnderLineColor = Colors.orange,
		this.fontWeight = FontWeight.normal,
	});

	Options merge({
		double fontSize,
		Color fontColor,
		Color emptyUnderLineColor,
		Color inputedUnderLineColor,
	}) {
		return Options(
			fontSize: fontSize??this.fontSize,
			fontColor: fontColor??this.fontColor,
			emptyUnderLineColor: emptyUnderLineColor??this.emptyUnderLineColor,
			inputedUnderLineColor: inputedUnderLineColor??this.inputedUnderLineColor,
		);
	}


}