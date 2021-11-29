import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/constants.dart';
import 'game_buttons.dart';

class ScoreKeeperArea extends StatelessWidget {
  ScoreKeeperArea({required this.player, required this.playerScore});

  final String player;
  final int playerScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GlowText(
          player,
          style: kScoreKeeperHeaderTextStyle,
          textAlign: TextAlign.center,
        ),
        Container(
          width: 120,
          decoration: BoxDecoration(
            color: kScoreBoxColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF000000).withAlpha(60),
                blurRadius: 20.0,
                spreadRadius: 0.0,
                offset: Offset(
                  0.0,
                  3.0,
                ),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
            child: Text(
              playerScore.toString(),
              style: kScoreKeeperTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
