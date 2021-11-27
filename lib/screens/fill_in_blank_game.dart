import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/utilities/blank_lyrics.dart';
import '../constants.dart';
import '../utilities/score_keeper.dart';

class FillInBlankGamePage extends StatefulWidget {
  FillInBlankGamePage(this.aN);
  final String aN;
  late ScoreKeeper sk;

  @override
  _FillInBlankGamePageState createState() => _FillInBlankGamePageState();
}

class _FillInBlankGamePageState extends State<FillInBlankGamePage> {

  late Future<List<String>> toBlank;
  String? fillInBlankAnswer;

  // String artistName = aN;
  int fibScore = 100;
  late List<String> lyrics;
  late String correctAnswer;

  Future<String> getStringOfBlankedLyricsList(List<String> lyrics) async {
    List<String> blankedLyricsList = await lyrics;

    late String blankedLyrics;
    for (int i = 0; i < blankedLyricsList.length; i++) {
      blankedLyrics = blankedLyrics + ' ' + blankedLyricsList[i];
    }
    return blankedLyrics;
  }

  void initState(){
    super.initState();
    toBlank = BlankLyrics().getChorus(widget.aN);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
          child: FutureBuilder(
            future: toBlank,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {

                List<String> lyrics = snapshot.data;

                int rnd = Random().nextInt(lyrics.length);
                String blanked = BlankLyrics().getRemoved(lyrics, rnd);
                List<String> blankedLyrics = BlankLyrics().getBlankChorus(lyrics, rnd);

                print('Lyrics that has a blank = $blankedLyrics');
                print('blanked lyric part = $blankedLyrics');

                return Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            70.0, screenHeight * 3 / 9, 70.0, screenHeight * 2 /
                            6),
                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GlowText(
                              "SCRAMBLED",
                              style: kEnterArtistsTextStyle,
                            ),
                            GlowText(
                              getStringOfBlankedLyricsList(lyrics) as String,
                              style: kGameTextStyle,
                              textAlign: TextAlign.center,
                            ),
                            Material(
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
                                    borderSide: BorderSide(
                                        color: Color(0xFFFFE600)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Color(0xFFFFE600)),
                                  ),
                                  hintText: 'ANSWER',
                                  hintStyle: kHintTextStyle,
                                  //fillColor: Colors.white,
                                  filled: false,
                                ),
                                onChanged: (answer) {
                                  fillInBlankAnswer = answer.toUpperCase();
                                },
                              ),
                            ),
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
                                  if (fillInBlankAnswer!.toUpperCase() ==
                                      correctAnswer) {
                                    print("scrambledTitleAnswer = " +
                                        fillInBlankAnswer!);

                                    if (widget.sk.isPlayerOneTurn()) {
                                      widget.sk.addPlayerOneScore(fibScore);
                                      widget.sk.nowPlayerTwoTurn();
                                      print("player one score = " +
                                          widget.sk.getPlayerOneScore()
                                              .toString());
                                    } else {
                                      widget.sk.addPlayerTwoScore(fibScore);
                                      widget.sk.nowPlayerOneTurn();
                                      print("player two score = " +
                                          widget.sk.getPlayerTwoScore()
                                              .toString());
                                    }
                                  }
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else
                return CircularProgressIndicator();
            }),
        ),
      ),
    );
  }
}
