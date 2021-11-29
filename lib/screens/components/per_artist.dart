import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/constants.dart';
import 'game_buttons.dart';

class PerArtist extends StatelessWidget {
  PerArtist(
      {required this.sw,
      required this.an,
      required this.onPress1,
      required this.buttonPressed1,
      required this.gameScore1,
      required this.onPress2,
      required this.buttonPressed2,
      required this.gameScore2,
      required this.onPress3,
      required this.buttonPressed3,
      required this.gameScore3});

  final double sw; //screen width
  final String an; //artist name
  final Function()? onPress1;
  final bool buttonPressed1;
  final int gameScore1;
  final Function()? onPress2;
  final bool buttonPressed2;
  final int gameScore2;
  final Function()? onPress3;
  final bool buttonPressed3;
  final int gameScore3;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 40.0,
          width: sw / 5,
          child: GlowText(
            an.toUpperCase(), //an
            style: kGameArtistsNameHeaderTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        GameButtons(
            onPress: onPress1,
            buttonPressed: buttonPressed1,
            gameScore: gameScore1),
        GameButtons(
            onPress: onPress2,
            buttonPressed: buttonPressed2,
            gameScore: gameScore2),
        GameButtons(
          onPress: onPress3,
          buttonPressed: buttonPressed3,
          gameScore: gameScore3,
        ),
      ],
    );
  }
}
