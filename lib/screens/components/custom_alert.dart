import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/constants.dart';

class CustomAlert extends StatelessWidget {
  CustomAlert({required this.message, required this.subMessage, this.actions});

  final String message;
  final String subMessage;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kAlertBackgroundColor,
      title: GlowText(message, style: kAlertMessageTextStyle),
      content: SingleChildScrollView(
        child: GlowText(
          subMessage,
          style: kAlertSubMessageTextStyle,
        ),
      ),
      actions: actions,
    );
  }
}
