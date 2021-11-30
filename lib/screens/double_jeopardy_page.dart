import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import '../constants.dart';
import '../screens/components/per_artist.dart';
import '../screens/components/score_keeper_area.dart';
import '../screens/components/custom_alert.dart';
import '../screens/third_loading_page.dart';
import '../game_model/scramble_song_game.dart';
import '../screens/scrambled_game_page.dart';
import '../utilities/score_keeper.dart';

// late String an1;
// late String an2;
// late String an3;

class DoubleJeopardy extends StatefulWidget {
  DoubleJeopardy(
      {required this.artistName1,
      required this.artistName2,
      required this.artistName3,
      required this.ssg1,
      required this.ssg2,
      required this.ssg3,
      required this.ssg4,
      required this.ssg5,
      required this.ssg6,
      required this.ssg7,
      required this.ssg8,
      required this.ssg9,
      required this.scoreKeeper});

  final String artistName1;
  final String artistName2;
  final String artistName3;
  final ScrambledSongGame ssg1;
  final ScrambledSongGame ssg2;
  final ScrambledSongGame ssg3;
  final ScrambledSongGame ssg4;
  final ScrambledSongGame ssg5;
  final ScrambledSongGame ssg6;
  final ScrambledSongGame ssg7;
  final ScrambledSongGame ssg8;
  final ScrambledSongGame ssg9;
  final ScoreKeeper scoreKeeper;

  @override
  _DoubleJeopardyState createState() => _DoubleJeopardyState();
}

class _DoubleJeopardyState extends State<DoubleJeopardy> {
  // for the lowest prize game buttons
  bool lowButton1 = false;
  bool lowButton2 = false;
  bool lowButton3 = false;
  // for the mid prize game buttons
  bool midButton1 = false;
  bool midButton2 = false;
  bool midButton3 = false;
  // for the highest prize game buttons
  bool highButton1 = false;
  bool highButton2 = false;
  bool highButton3 = false;

  int scrambleTitlePoints = 400;
  int fillInLyricsPoints = 800;
  int nameThatTunePoints = 1600;
  late ScoreKeeper sk;
  late int player1Score;
  late int player2Score;
  String msg = "";

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
      bool allPressed = lowButton1 &&
          lowButton2 &&
          lowButton3 &&
          midButton1 &&
          midButton2 &&
          midButton3 &&
          highButton1 &&
          highButton2 &&
          highButton3;
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

  //alert dialog layout when the round is done
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext alertContext) {
        return CustomAlert(
          message: msg,
          subMessage: 'ONTO FINAL JEOPARDY WE GO',
          actions: <Widget>[
            TextButton(
              child: GlowText(
                'LET\'S GO!',
                style: TextStyle(
                  color: Color(0xFFFFE600),
                  fontFamily: 'Press Start 2P',
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                setState(() {
                  //pops the screen off
                  Navigator.of(context).pop();
                  //pops the alert dialog off
                  Navigator.pop(alertContext);
                  sendToLoadingPage(); //Navigator.of(context).push(route); is in this method
                });
              },
            ),
          ],
        );
        /*AlertDialog(
          backgroundColor: Color(0xFF961E05),
          title: GlowText(
            msg,
            style: TextStyle(
              color: Color(0xFFFFE600),
              fontFamily: 'Press Start 2P',
              fontSize: 18,
            ),
          ),
          content: SingleChildScrollView(
            child: GlowText(
              'ONTO FINAL JEOPARDY WE GO',
              style: TextStyle(
                color: Color(0xFFFFE600),
                fontFamily: 'Press Start 2P',
                fontSize: 8,
                letterSpacing: 5.0,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: GlowText(
                'LET\'S GO!',
                style: TextStyle(
                  color: Color(0xFFFFE600),
                  fontFamily: 'Press Start 2P',
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                setState(() {
                  //pops the screen off
                  Navigator.of(context).pop();
                  //pops the alert dialog off
                  Navigator.pop(alertContext);
                  sendToLoadingPage(); //Navigator.of(context).push(route); is in this method
                });
              },
            ),
          ],
        );*/
      },
    );
  }

  //loading page before the final jeopardy
  void sendToLoadingPage() async {
    try {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ThirdLoadingPage(
              artistName1: widget.artistName1,
              artistName2: widget.artistName2,
              artistName3: widget.artistName3,
              scoreKeeper: sk)));
    } catch (e) {
      print(e);
      //TODO: make alert dialog that says 'we can't find one of the artists you named, please enter a new one'
    }
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
          image: AssetImage("images/arcade.png"),
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
                    70.0, screenHeight * 3 / 14, 70.0, screenHeight * 2 / 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    PerArtist(
                      sw: screenWidth,
                      an: widget.artistName1,
                      onPress1: () {
                        setState(() {
                          lowButton1 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg1,
                              sk: sk,
                              score: scrambleTitlePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed1: lowButton1,
                      gameScore1: scrambleTitlePoints,
                      onPress2: () {
                        setState(() {
                          midButton1 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg4,
                              sk: sk,
                              score: fillInLyricsPoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed2: midButton1,
                      gameScore2: fillInLyricsPoints,
                      onPress3: () {
                        setState(() {
                          highButton1 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg7,
                              sk: sk,
                              score: nameThatTunePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed3: highButton1,
                      gameScore3: nameThatTunePoints,
                    ),
                    PerArtist(
                      sw: screenWidth,
                      an: widget.artistName2,
                      onPress1: () {
                        setState(() {
                          lowButton2 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg2,
                              sk: sk,
                              score: scrambleTitlePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed1: lowButton2,
                      gameScore1: scrambleTitlePoints,
                      onPress2: () {
                        setState(() {
                          midButton2 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg5,
                              sk: sk,
                              score: fillInLyricsPoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed2: midButton2,
                      gameScore2: fillInLyricsPoints,
                      onPress3: () {
                        setState(() {
                          highButton2 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg8,
                              sk: sk,
                              score: nameThatTunePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed3: highButton2,
                      gameScore3: nameThatTunePoints,
                    ),
                    PerArtist(
                      sw: screenWidth,
                      an: widget.artistName3,
                      onPress1: () {
                        setState(() {
                          lowButton3 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg3,
                              sk: sk,
                              score: scrambleTitlePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed1: lowButton3,
                      gameScore1: scrambleTitlePoints,
                      onPress2: () {
                        setState(() {
                          midButton3 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg6,
                              sk: sk,
                              score: fillInLyricsPoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed2: midButton3,
                      gameScore2: fillInLyricsPoints,
                      onPress3: () {
                        setState(() {
                          highButton3 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg9,
                              sk: sk,
                              score: nameThatTunePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed3: highButton3,
                      gameScore3: nameThatTunePoints,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, screenHeight * 3 / 5, 0, screenHeight * 2 / 10),
                  child: Container(
                    height: 50.0,
                    width: screenWidth * 3 / 2,
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
              Padding(
                padding: EdgeInsets.fromLTRB(
                    70.0, screenHeight / 6, 70.0, screenHeight / 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ScoreKeeperArea(
                      whichPlayer: true,
                      player: 'PLAYER ONE',
                      playerScore: player1Score,
                      imagePath: 'images/left_score_keeper.png',
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    ScoreKeeperArea(
                      whichPlayer: false,
                      player: 'PLAYER TWO',
                      playerScore: player2Score,
                      imagePath: 'images/right_score_keeper.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import '../constants.dart';
import '../game_model/scramble_song_game.dart';
import '../screens/scrambled_game_page.dart';
import '../screens/components/per_artist.dart';
import '../screens/components/score_keeper_area.dart';
import '../utilities/score_keeper.dart';

late String an1;
late String an2;
late String an3;

class DoubleJeopardy extends StatefulWidget {
  DoubleJeopardy(
      {required this.artistName1,
      required this.artistName2,
      required this.artistName3,
      required this.ssg1,
      required this.ssg2,
      required this.ssg3,
      required this.ssg4,
      required this.ssg5,
      required this.ssg6,
      required this.ssg7,
      required this.ssg8,
      required this.ssg9,
      required this.sk});

  final String artistName1;
  final String artistName2;
  final String artistName3;
  final ScrambledSongGame ssg1;
  final ScrambledSongGame ssg2;
  final ScrambledSongGame ssg3;
  final ScrambledSongGame ssg4;
  final ScrambledSongGame ssg5;
  final ScrambledSongGame ssg6;
  final ScrambledSongGame ssg7;
  final ScrambledSongGame ssg8;
  final ScrambledSongGame ssg9;
  final ScoreKeeper sk;

  @override
  _DoubleJeopardyState createState() => _DoubleJeopardyState();
}

class _DoubleJeopardyState extends State<DoubleJeopardy> {
  // for the lowest prize game buttons
  bool lowButton1 = false;
  bool lowButton2 = false;
  bool lowButton3 = false;
  // for the mid prize game buttons
  bool midButton1 = false;
  bool midButton2 = false;
  bool midButton3 = false;
  // for the highest prize game buttons
  bool highButton1 = false;
  bool highButton2 = false;
  bool highButton3 = false;

  int scrambleTitlePoints = 400;
  int fillInLyricsPoints = 800;
  int nameThatTunePoints = 1200;

  late ScoreKeeper sk;
  late int player1Score;
  late int player2Score;
  String msg = "";

//checks is all the buttons have been used
  void checkIfRoundDone() {
    setState(() {
      print('checking if this round is done...');
      bool allPressed = lowButton1 &&
          lowButton2 &&
          lowButton3 &&
          midButton1 &&
          midButton2 &&
          midButton3 &&
          highButton1 &&
          highButton2 &&
          highButton3;
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

  //alert dialog layout when the round is done
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext alertContext) {
        return AlertDialog(
          backgroundColor: Color(0xFF961E05),
          title: GlowText(
            msg,
            style: TextStyle(
              color: Color(0xFFFFE600),
              fontFamily: 'Press Start 2P',
              fontSize: 18,
            ),
          ),
          content: SingleChildScrollView(
            child: GlowText(
              'ONTO FINAL JEOPARDY WE GO',
              style: TextStyle(
                color: Color(0xFFFFE600),
                fontFamily: 'Press Start 2P',
                fontSize: 8,
                letterSpacing: 5.0,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: GlowText(
                'LET\'S GO!',
                style: TextStyle(
                  color: Color(0xFFFFE600),
                  fontFamily: 'Press Start 2P',
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                setState(() {
                  //pops the screen off
                  Navigator.of(context).pop();
                  //pops the alert dialog off
                  Navigator.pop(alertContext);
                  //sendToLoadingPage(); //Navigator.of(context).push(route); is in this method
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
    ScoreKeeper sk = widget.sk;
    player1Score = sk.getPlayerOneScore();
    player2Score = sk.getPlayerTwoScore();

    FutureOr onGoBack(dynamic value) async {
      setState(() {
        player1Score = sk.getPlayerOneScore();
        print("player one score = " + player1Score.toString());
        player2Score = sk.getPlayerTwoScore();
        print("player two score = " + player2Score.toString());
        checkIfRoundDone();
      });
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/arcade.png"),
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
                    70.0, screenHeight * 3 / 14, 70.0, screenHeight * 2 / 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    PerArtist(
                      sw: screenWidth,
                      an: widget.artistName1,
                      onPress1: () {
                        setState(() {
                          lowButton1 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg1,
                              sk: sk,
                              score: scrambleTitlePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed1: lowButton1,
                      gameScore1: scrambleTitlePoints,
                      onPress2: () {
                        setState(() {
                          midButton1 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg4,
                              sk: sk,
                              score: fillInLyricsPoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed2: midButton1,
                      gameScore2: fillInLyricsPoints,
                      onPress3: () {
                        setState(() {
                          highButton1 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg7,
                              sk: sk,
                              score: nameThatTunePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed3: highButton1,
                      gameScore3: nameThatTunePoints,
                    ),
                    PerArtist(
                      sw: screenWidth,
                      an: widget.artistName2,
                      onPress1: () {
                        setState(() {
                          lowButton2 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg2,
                              sk: sk,
                              score: scrambleTitlePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed1: lowButton2,
                      gameScore1: scrambleTitlePoints,
                      onPress2: () {
                        setState(() {
                          midButton2 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg5,
                              sk: sk,
                              score: fillInLyricsPoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed2: midButton2,
                      gameScore2: fillInLyricsPoints,
                      onPress3: () {
                        setState(() {
                          highButton2 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg8,
                              sk: sk,
                              score: nameThatTunePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed3: highButton2,
                      gameScore3: nameThatTunePoints,
                    ),
                    PerArtist(
                      sw: screenWidth,
                      an: widget.artistName3,
                      onPress1: () {
                        setState(() {
                          lowButton3 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg3,
                              sk: sk,
                              score: scrambleTitlePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed1: lowButton3,
                      gameScore1: scrambleTitlePoints,
                      onPress2: () {
                        setState(() {
                          midButton3 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg6,
                              sk: sk,
                              score: fillInLyricsPoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed2: midButton3,
                      gameScore2: fillInLyricsPoints,
                      onPress3: () {
                        setState(() {
                          highButton3 = true;
                          Route route = MaterialPageRoute(
                            builder: (context) => ScrambledGamePage(
                              ssg: widget.ssg9,
                              sk: sk,
                              score: nameThatTunePoints,
                            ),
                          );
                          Navigator.push(context, route).then(onGoBack);
                        });
                      },
                      buttonPressed3: highButton3,
                      gameScore3: nameThatTunePoints,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, screenHeight * 3 / 5, 0, screenHeight * 2 / 10),
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
              Padding(
                padding: EdgeInsets.fromLTRB(
                    70.0, screenHeight / 6, 70.0, screenHeight / 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ScoreKeeperArea(
                        player: 'PLAYER ONE', playerScore: player1Score),
                    SizedBox(
                      width: 30.0,
                    ),
                    ScoreKeeperArea(
                        player: 'PLAYER TWO', playerScore: player2Score),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
