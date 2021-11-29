import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/game_model/scramble_song_title.dart';
import 'package:singing_tiger_test/screens/components/loading_screen.dart';
import 'package:singing_tiger_test/utilities/score_keeper.dart';
import 'package:singing_tiger_test/utilities/string_scrambler.dart';
import '../constants.dart';
import 'double_jeopardy_page.dart';

class SecondLoadingPage extends StatefulWidget {
  SecondLoadingPage(
      {required this.artistName1,
      required this.artistName2,
      required this.artistName3,
      required this.scoreKeeper});

  final String artistName1;
  final String artistName2;
  final String artistName3;
  final ScoreKeeper scoreKeeper;

  @override
  _SecondLoadingPageState createState() => _SecondLoadingPageState();
}

class _SecondLoadingPageState extends State<SecondLoadingPage> {
  TitleScrambler ts = TitleScrambler();

  @override
  void initState() {
    super.initState();
    String an1 = widget.artistName1;
    String an2 = widget.artistName2;
    String an3 = widget.artistName3;

    sendToGamePage(artistName1: an1, artistName2: an2, artistName3: an3);
  }

  void sendToGamePage(
      {required String artistName1,
      required String artistName2,
      required String artistName3}) async {
    try {
      ScrambledSongGame ssg1 = await getScrambledGameComponent(artistName1);
      ScrambledSongGame ssg2 = await getScrambledGameComponent(artistName2);
      ScrambledSongGame ssg3 = await getScrambledGameComponent(artistName3);
      ScrambledSongGame ssg4 = await getScrambledGameComponent(artistName1);
      ScrambledSongGame ssg5 = await getScrambledGameComponent(artistName2);
      ScrambledSongGame ssg6 = await getScrambledGameComponent(artistName3);
      ScrambledSongGame ssg7 = await getScrambledGameComponent(artistName1);
      ScrambledSongGame ssg8 = await getScrambledGameComponent(artistName2);
      ScrambledSongGame ssg9 = await getScrambledGameComponent(artistName3);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DoubleJeopardy(
                artistName1: artistName1,
                artistName2: artistName2,
                artistName3: artistName3,
                ssg1: ssg1,
                ssg2: ssg2,
                ssg3: ssg3,
                ssg4: ssg4,
                ssg5: ssg5,
                ssg6: ssg6,
                ssg7: ssg7,
                ssg8: ssg8,
                ssg9: ssg9,
                scoreKeeper: widget.scoreKeeper,
              )));
    } catch (e) {
      print(e);
      //TODO: make alert dialog that says 'we can't find one of the artists you named, please enter a new one'
    }
  }

  //gets the game components such as the title itself and its scrambled version
  Future<ScrambledSongGame> getScrambledGameComponent(String an) async {
    String correctTitle = await ts.getSongTitle(an);
    print('correctTitle = $correctTitle');
    String scrambledTitle = await ts.Scramble(correctTitle);
    print('scrambledTitle = $scrambledTitle');

    return ScrambledSongGame(
        scrambledSongTitle: scrambledTitle, songTitle: correctTitle);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}
