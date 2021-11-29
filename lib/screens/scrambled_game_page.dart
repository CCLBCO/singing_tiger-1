import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import '../constants.dart';
import '../game_model/scramble_song_title.dart';
import '../utilities/score_keeper.dart';
import 'components/custom_alert.dart';
import 'components/input_boxes.dart';

class ScrambledGamePage extends StatefulWidget {
  ScrambledGamePage({required this.ssg, required this.sk, required this.score});

  final ScrambledSongGame ssg;
  final ScoreKeeper sk;
  final int score;

  @override
  _ScrambledGamePageState createState() => _ScrambledGamePageState();
}

class _ScrambledGamePageState extends State<ScrambledGamePage> {
  String scrambledTitleAnswer = '';
  String msg = '';
  String scoreMsg = '';

  void checkAnswer(
      {required String usersAnswer,
      required String correctAnswer,
      required int gameScore,
      required BuildContext con}) {
    if (widget.sk.isPlayerOneTurn()) {
      if (usersAnswer.toUpperCase().trim() ==
          correctAnswer.toUpperCase().trim()) {
        widget.sk.addPlayerOneScore(gameScore);
        print("P1 WINS! - player one score = " +
            widget.sk.getPlayerOneScore().toString());
        msg = 'PLAYER ONE IS CORRECT!';
        scoreMsg = 'YOU GET $gameScore';
      } else {
        //when P1 is wrong
        widget.sk.subtractPlayerOneScore(gameScore);
        msg = 'PLAYER ONE IS WRONG!';
        scoreMsg = 'YOU LOSE $gameScore';
      }
      widget.sk.nowPlayerTwoTurn();
    } else {
      if (usersAnswer.toUpperCase().trim() ==
          correctAnswer.toUpperCase().trim()) {
        widget.sk.addPlayerTwoScore(gameScore);
        print("P2 WINS! - player two score = " +
            widget.sk.getPlayerTwoScore().toString());
        msg = 'PLAYER TWO IS CORRECT!';
        scoreMsg = 'YOU GET $gameScore';
      } else {
        //when P2 is wrong
        widget.sk.subtractPlayerTwoScore(gameScore);
        msg = 'PLAYER TWO IS WRONG!';
        scoreMsg = 'YOU LOSE $gameScore';
      }
      widget.sk.nowPlayerOneTurn();
    }
    _showMyDialog(con);
  }

  //alert dialog layout when they submit their answers
  Future<void> _showMyDialog(BuildContext cont) async {
    return showDialog<void>(
      context: cont,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext alertContext) {
        return CustomAlert(
          message: msg,
          subMessage: scoreMsg,
          actions: <Widget>[
            TextButton(
              child: GlowText(
                'CONTINUE',
                style: TextStyle(
                  color: Color(0xFFFFE600),
                  fontFamily: 'Press Start 2P',
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                setState(() {
                  //pops the screen off
                  Navigator.of(cont).pop();
                  //pops the alert dialog off
                  Navigator.pop(alertContext);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext pageContext) {
    double screenHeight = MediaQuery.of(pageContext).size.height;
    String correctAnswer = widget.ssg.songTitle;
    int gameScore = widget.score;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/zoomed.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      70.0, screenHeight * 3 / 9, 70.0, screenHeight * 2 / 6),
                  //padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GlowText(
                        "SCRAMBLED",
                        style: kEnterArtistsTextStyle,
                      ),
                      GlowText(
                        widget.ssg.scrambledSongTitle,
                        style: kGameTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      InputBoxes(
                        hintText: 'ANSWER',
                        function: (answer) {
                          scrambledTitleAnswer = answer.toUpperCase().trim();
                        },
                      ),
                      /*Material(
                        elevation: 5.0,
                        shadowColor: Color(0xFFFFE600),
                        borderRadius: BorderRadius.circular(15),
                        borderOnForeground: true,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0xFFFFE600)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0xFFFFE600)),
                            ),
                            hintText: 'ANSWER',
                            hintStyle: kHintTextStyle,
                            //fillColor: Colors.white,
                            filled: false,
                          ),
                          onChanged: (answer) {
                            scrambledTitleAnswer = answer.toUpperCase().trim();
                          },
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
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
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 120.0),
                    child: GlowButton(
                      color: kGameButtonColor,
                      child: Text(
                        "GO!",
                        style: kNextButtonTextStyle,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            print("user's answer is: $scrambledTitleAnswer");
                            print("correct answer is: $correctAnswer");
                            print("game score is: $gameScore");
                            print("player one's turn?");
                            print(widget.sk.isPlayerOneTurn());
                            print("player two's turn?");
                            print(widget.sk.isPlayerTwoTurn());

                            //Navigator.of(pageContext).pop();
                            checkAnswer(
                                usersAnswer: scrambledTitleAnswer,
                                correctAnswer: correctAnswer,
                                gameScore: gameScore,
                                con: pageContext);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
