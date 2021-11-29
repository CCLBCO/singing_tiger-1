import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/screens/components/final_jeopardy_screen.dart';
import 'package:singing_tiger_test/screens/p2_final_jeopardy_page.dart';
import '../constants.dart';
import '../screens/end_page.dart';
import '../screens/components/custom_alert.dart';
import '../screens/components/final_jeopardy_screen.dart';
import '../game_model/album_song_game.dart';
import '../utilities/score_keeper.dart';

class P1FinalJeopardy extends StatefulWidget {
  P1FinalJeopardy(
      {required this.asg1,
      required this.asg2,
      required this.playerOneWager,
      required this.playerTwoWager,
      required this.scoreKeeper});

  final AlbumSongGame asg1;
  final AlbumSongGame asg2;
  final int playerOneWager;
  final int playerTwoWager;
  final ScoreKeeper scoreKeeper;

  @override
  _P1FinalJeopardyState createState() => _P1FinalJeopardyState();
}

class _P1FinalJeopardyState extends State<P1FinalJeopardy> {
  late ScoreKeeper sk;
  late int player1Score;
  late int player2Score;
  String msg = '';
  String scoreMsg = '';
  String usersAnswer = '';
  String correctAnswer = '';

  @override
  void initState() {
    sk = widget.scoreKeeper;
    player1Score = sk.getPlayerOneScore();
    player2Score = sk.getPlayerTwoScore();
    super.initState();
  }

  void checkAnswer(
      {required String usersAnswer,
      required String correctAnswer,
      required int gameScore}) {
    if (usersAnswer.toUpperCase().trim() ==
        correctAnswer.toUpperCase().trim()) {
      widget.scoreKeeper.addPlayerOneScore(gameScore);
      print("P1 WINS! - player one score = " +
          widget.scoreKeeper.getPlayerOneScore().toString());
      msg = 'PLAYER ONE IS CORRECT!!';
      scoreMsg =
          'YOUR FINAL SCORE IS ${widget.scoreKeeper.getPlayerOneScore()}';
    } else {
      //when P1 is wrong
      widget.scoreKeeper.subtractPlayerOneScore(gameScore);
      msg = 'PLAYER ONE IS WRONG!';
      scoreMsg =
          'YOUR FINAL SCORE IS ${widget.scoreKeeper.getPlayerOneScore()}';
    }
    _showMyDialog();
  }

  //alert dialog layout when they submit their answers
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
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
                  //pops the alert dialog off
                  Navigator.pop(alertContext);
                  //indicates it's player two's turn now
                  widget.scoreKeeper.nowPlayerTwoTurn();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => P2FinalJeopardy(
                          asg2: widget.asg2,
                          playerOneWager: widget.playerOneWager,
                          playerTwoWager: widget.playerTwoWager,
                          scoreKeeper: widget.scoreKeeper),
                    ),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    AlbumSongGame asg1 = widget.asg1;
    int playerWager = widget.playerOneWager;
    String correctAnswer = widget.asg1.albumName.toUpperCase();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/final_jeopardy.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                    50.0, screenHeight / 3, 50.0, screenHeight * 2 / 17),
                child: FinalJeopardyScreen(
                  blankedAlbumName: asg1.blankAlbumName,
                  songTitleFromAlbum: asg1.songTitle,
                  onType: (answer1) {
                    usersAnswer = answer1.toUpperCase().trim();
                  },
                  onPress: () {
                    setState(
                      () {
                        print("user's answer is: $usersAnswer");
                        print("correct answer is: $correctAnswer");
                        print("game score is: $playerWager");

                        //Navigator.of(pageContext).pop();
                        checkAnswer(
                          usersAnswer: usersAnswer,
                          correctAnswer: correctAnswer,
                          gameScore: playerWager,
                        );
                      },
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30.0),
                  child: Container(
                    height: 40.0,
                    width: 700.0,
                    child: GlowText(
                      sk.isPlayerOneTurn()
                          ? 'PLAYER ONE\'S TURN'
                          : 'PLAYER TWO\'S TURN',
                      style: sk.isPlayerOneTurn()
                          ? kGameTurnP1TextStyle
                          : kGameTurnP2TextStyle,
                      textAlign: TextAlign.center,
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
