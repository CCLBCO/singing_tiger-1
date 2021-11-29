import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/constants.dart';

class WagerSlider extends StatelessWidget {
  WagerSlider(
      {required this.player,
      required this.playerWager,
      required this.maxForPlayer,
      required this.onChanged});

  final String player;
  final int playerWager;
  final int maxForPlayer;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GlowText(
              player, //'PLAYER ONE'
              style: kWagerPlayerTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            GlowText(
              'WAGER',
              style: kWagerTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                GlowText(
                  playerWager.toString(),
                  style: kWagerTextStyle,
                ),
                GlowText(
                  'pts',
                  style: kWagerTextStyle,
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2.0,
                inactiveTrackColor: Color(0xFFD26201),
                activeTrackColor: Color(0xFFF2AE00),
                thumbColor: kWagerTextColor,
                overlayColor: Color(0x50F2AE00),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
              ),
              child: Slider(
                  value: playerWager.toDouble(),
                  min: 0,
                  max: maxForPlayer.toDouble(),
                  divisions: 200,
                  onChanged: onChanged),
            ),
          ],
        ),
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: kWagerCardColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
