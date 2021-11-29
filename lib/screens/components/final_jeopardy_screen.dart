import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/constants.dart';
import 'package:singing_tiger_test/screens/components/input_boxes.dart';

class FinalJeopardyScreen extends StatelessWidget {
  FinalJeopardyScreen(
      {required this.blankedAlbumName,
      required this.songTitleFromAlbum,
      required this.onType,
      this.onPress});

  final String blankedAlbumName;
  final String songTitleFromAlbum;
  final Function(String) onType;
  final Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GlowText(
          'FINAL JEOPARDY',
          style: kFinalJeopardyHeader1TextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10.0,
        ),
        GlowText(
          'FILL IN THE SONG\'S ALBUM NAME',
          style: kFinalJeopardyHeader2TextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10.0,
        ),
        GlowText(
          blankedAlbumName,
          style: kGameTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10.0,
        ),
        GlowText(
          'SONG: ${songTitleFromAlbum.toUpperCase()}',
          style: kFinalHeader2TextStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        InputBoxes(
          hintText: 'ANSWER',
          function: onType,
        ),
        SizedBox(
          height: 20.0,
        ),
        GlowButton(
          color: kGameButtonColor,
          child: Text(
            "GO!",
            style: kNextButtonTextStyle,
          ),
          onPressed: onPress,
        ),
      ],
    );
  }
}
