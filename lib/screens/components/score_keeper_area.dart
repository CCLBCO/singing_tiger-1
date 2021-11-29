import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/constants.dart';

class ScoreKeeperArea extends StatelessWidget {
  ScoreKeeperArea(
      {required this.imagePath,
      required this.whichPlayer, //true for P1, false for P2
      required this.player,
      required this.playerScore});

  final bool whichPlayer;
  final String imagePath;
  final String player;
  final int playerScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GlowText(
          player,
          style: whichPlayer? kScoreKeeperHeaderP1TextStyle : kScoreKeeperHeaderP2TextStyle,
          textAlign: TextAlign.center,
        ),
        Container(
          width: 120,
          child: Stack(
            children: <Widget>[
              Image(
                image: AssetImage(imagePath),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 15.0, 0, 10.0),
                  child: GlowText(
                    playerScore.toString(),
                    style: kScoreKeeperTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
