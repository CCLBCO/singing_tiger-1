import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import '../constants.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/zoomed.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, //kHowToPlayBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Color(0xFFFFE600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 140.0, 50.0, 110.0),
          child: Scrollbar(
            showTrackOnHover: true,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    GlowText(
                      'BASIC RULES:',
                      style: kHowToPlayHeader2TextStyle,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GlowText(
                      '1. The artists you enter will be the categories for the jeopardy game.',
                      style: kHowToPlayTextStyle,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GlowText(
                      '2. If there is an alert that we cannot find an artist, it may be '
                      'that you inputted the wrong spelling or we that we cannot find '
                      'that certain artist within our data set.',
                      style: kHowToPlayTextStyle,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GlowText(
                      '3. In the first two levels, players are asked to unscramble song titles '
                      'from three different artists.',
                      style: kHowToPlayTextStyle,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GlowText(
                      '4. A player\'s score will be added or deducted given the amount of points'
                      ' of the button they have pressed.',
                      style: kHowToPlayTextStyle,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GlowText(
                      '5. If the player successfully unscrambled the song title, they will gain points '
                      'depending on the amount they clicked. If a player has a negative score, it may '
                      'help then get out of that zone',
                      style: kHowToPlayTextStyle,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GlowText(
                      '6. If the player failed to unscramble, regardless if the player has zero or negative'
                      ' score, points will still be deducted.',
                      style: kHowToPlayTextStyle,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GlowText(
                      '7. At the last level of jeopardy, both players are given the'
                      ' to bet from zero to double their current score.',
                      style: kHowToPlayTextStyle,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GlowText(
                      '8. The game for Final jeopardy will be guessing what album a certain song title came from.',
                      style: kHowToPlayTextStyle,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GlowText(
                      '9. If the player is sure that a certain song title is a single, they may type the word \'singles\'.',
                      style: kHowToPlayTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
