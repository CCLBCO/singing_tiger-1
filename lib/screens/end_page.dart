import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/screens/jeopardy_page.dart';
import '../constants.dart';
import '../screens/start_page.dart';
import '../utilities/score_keeper.dart';

class EndPage extends StatefulWidget {
  EndPage({required this.scoreKeeper});

  final ScoreKeeper scoreKeeper;

  @override
  _EndPageState createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {

  String checkWhoWon() {
    ScoreKeeper sk = widget.scoreKeeper;

    if (sk.getPlayerOneScore() > sk.getPlayerTwoScore()) {
      return "PLAYER ONE WINS!";
    } else if (sk.getPlayerOneScore() < sk.getPlayerTwoScore()) {
      return "PLAYER TWO WINS!";
    } else {
      return "IT\'S A TIE!";
    }
  }

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
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 220.0, 10.0, 90.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GlowText(
                        checkWhoWon(),
                        style: kWinnerTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 115.0, 15.0, 0),
                    child: Image.asset("images/singing_tiger_mascot.GIF"),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 120,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 120.0),
                    child: GlowButton(
                        color: kPlayButtonColor,
                        child: Text(
                          "RESTART",
                          style: kRestartButtonTextStyle,
                        ),
                        onPressed: () {
                          sk.restart();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StartPage()));
                          //builder: (context) => GamePage()));
                        }),
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
