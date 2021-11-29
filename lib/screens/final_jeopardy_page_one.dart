import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/screens/components/final_jeopardy_screen.dart';
import '../constants.dart';
import '../screens/end_page.dart';
import '../screens/components/custom_alert.dart';
import '../screens/components/final_jeopardy_screen.dart';
import '../game_model/album_song_game.dart';
import '../utilities/score_keeper.dart';

class FinalJeopardy extends StatefulWidget {
  FinalJeopardy(
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
  _FinalJeopardyState createState() => _FinalJeopardyState();
}

class _FinalJeopardyState extends State<FinalJeopardy> {
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

  //checks is all the buttons have been used
  void checkIfRoundDone() {
    print('checking if round is done...');
    setState(() {
      bool allPressed = true;
      if (allPressed == true) {
        print('ROUND TWO IS DONE');
        //shows what message to output in the dialog box
        if (sk.getPlayerOneScore() > sk.getPlayerTwoScore()) {
          msg = "PLAYER ONE WINS ROUND TWO";
          //player.play('game-over-passed.wav');
        } else if (sk.getPlayerOneScore() < sk.getPlayerTwoScore()) {
          msg = "PLAYER TWO WINS ROUND TWO";
          //player.play('game-over-passed.wav');
        } else {
          msg = "IT'S A TIE";
          //player.play('game-over-failed.wav');
        }
        _showMyDialog();
      }
    });
  }

  Widget playerOneGame() {
    AlbumSongGame asg1 = widget.asg1;
    int playerWager = widget.playerOneWager;
    String correctAnswer = widget.asg1.albumName.toUpperCase();

    return FinalJeopardyScreen(
      blankedAlbumName: asg1.blankAlbumName,
      songTitleFromAlbum: asg1.songTitle,
      onType: (answer) {
        usersAnswer = answer.toUpperCase().trim();
      },
      onPress: () {
        setState(
          () {
            print("user's answer is: $usersAnswer");
            print("correct answer is: $correctAnswer");
            print("game score is: $playerWager");
            print("player one's turn?");
            print(widget.scoreKeeper.isPlayerOneTurn());
            print("player two's turn?");
            print(widget.scoreKeeper.isPlayerTwoTurn());

            //Navigator.of(pageContext).pop();
            checkAnswer(
                usersAnswer: usersAnswer,
                correctAnswer: correctAnswer,
                gameScore: playerWager);
          },
        );
      },
    );
  }

  Widget playerTwoGame() {
    AlbumSongGame asg2 = widget.asg2;
    int playerWager = widget.playerTwoWager;
    String correctAnswer = widget.asg2.albumName.toUpperCase();
    String usersAnswer = '';

    return FinalJeopardyScreen(
      blankedAlbumName: asg2.blankAlbumName,
      songTitleFromAlbum: asg2.songTitle,
      onType: (answer) {
        usersAnswer = answer.toUpperCase().trim();
      },
      onPress: () {
        setState(
          () {
            print("user's answer is: $usersAnswer");
            print("correct answer is: $correctAnswer");
            print("game score is: $playerWager");
            print("player one's turn?");
            print(widget.scoreKeeper.isPlayerOneTurn());
            print("player two's turn?");
            print(widget.scoreKeeper.isPlayerTwoTurn());

            //Navigator.of(pageContext).pop();
            checkAnswer(
                usersAnswer: usersAnswer,
                correctAnswer: correctAnswer,
                gameScore: playerWager);
          },
        );
      },
    );
  }

  void checkAnswer(
      {required String usersAnswer,
      required String correctAnswer,
      required int gameScore}) {
    if (widget.scoreKeeper.isPlayerOneTurn()) {
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
    } else {
      if (usersAnswer.toUpperCase().trim() ==
          correctAnswer.toUpperCase().trim()) {
        widget.scoreKeeper.addPlayerTwoScore(gameScore);
        print("P2 WINS! - player two score = " +
            widget.scoreKeeper.getPlayerTwoScore().toString());
        msg = 'PLAYER TWO IS CORRECT!';
        scoreMsg =
            'YOUR FINAL SCORE IS ${widget.scoreKeeper.getPlayerTwoScore()}';
      } else {
        //when P2 is wrong
        widget.scoreKeeper.subtractPlayerTwoScore(gameScore);
        msg = 'PLAYER TWO IS WRONG!';
        scoreMsg =
            'YOUR FINAL SCORE IS ${widget.scoreKeeper.getPlayerTwoScore()}';
      }
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
                  if (widget.scoreKeeper.isPlayerOneTurn()) {
                    //indicates it's player two's turn now
                    widget.scoreKeeper.nowPlayerTwoTurn();
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EndPage(
                              scoreKeeper: widget.scoreKeeper,
                            )));
                  }
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

    //runs whenever the scrambled title game page is popped off
    FutureOr onGoBack(dynamic value) async {
      setState(() {
        player1Score = sk.getPlayerOneScore();
        print("player one score = " + player1Score.toString());
        player2Score = sk.getPlayerTwoScore();
        print("player two score = " + player2Score.toString());

        //checks if all the buttons have been pressed
        checkIfRoundDone();
      });
    }

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
              Padding(
                padding: EdgeInsets.fromLTRB(
                    50.0, screenHeight * 3 / 10, 50.0, screenHeight * 2 / 9),
                child: sk.isPlayerOneTurn()
                    ? playerOneGame()
                    : playerTwoGame(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, screenHeight * 3 / 5, 0, screenHeight * 2 / 17),
                  child: Container(
                    height: 50.0,
                    width: screenWidth / 2,
                    child: GlowText(
                      sk.isPlayerOneTurn()
                          ? 'PLAYER ONE\'S TURN'
                          : 'PLAYER TWO\'S TURN',
                      style: kGameTurnTextStyle,
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
