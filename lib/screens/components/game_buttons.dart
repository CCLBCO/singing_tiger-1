import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/constants.dart';

class GameButtons extends StatelessWidget {
  GameButtons(
      {required this.onPress,
      required this.buttonPressed,
      required this.gameScore});

  final Function()? onPress;
  final bool buttonPressed;
  final int gameScore;
  @override
  Widget build(BuildContext context) {
    return GlowButton(
      onPressed: onPress,
      width: buttonPressed ? 0.0 : 70.0,
      color: kGameButtonColor,
      child: Text(
        gameScore.toString(),
        style: kGameButtonTextStyle,
      ),
    );
  }
}
