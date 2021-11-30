import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/game_model/scramble_song_title.dart';
import 'package:singing_tiger_test/utilities/string_scrambler.dart';
import 'components/custom_alert.dart';
import 'components/loading_screen.dart';
import 'jeopardy_page.dart';

class FirstLoadingPage extends StatefulWidget {
  FirstLoadingPage(
      {required this.artistName1,
      required this.artistName2,
      required this.artistName3});

  final String artistName1;
  final String artistName2;
  final String artistName3;

  @override
  _FirstLoadingPageState createState() => _FirstLoadingPageState();
}

class _FirstLoadingPageState extends State<FirstLoadingPage> {
  TitleScrambler ts = TitleScrambler();

  //automatically initializes the state and runs the sendToGamePage method
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
          builder: (context) => Jeopardy(
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
              )));
    } catch (e) {
      print(e);

      _showMyDialog();
    }
  }

  //alert dialog layout when they submit their answers
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext alertContext) {
        return CustomAlert(
          message: 'OOPS!',
          subMessage:
              'looks like we can\'t find one of the artists you named, try again!',
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
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  //gets the game components such as the title itself and its scrambled version
  Future<ScrambledSongGame> getScrambledGameComponent(String an) async {

    //will get a random song title of specified artist
    String correctTitle = await ts.getSongTitle(an);
    print('correctTitle = $correctTitle');

    //will then scramble that song title
    String scrambledTitle = await ts.scramble(correctTitle);
    print('scrambledTitle = $scrambledTitle');

    return ScrambledSongGame(
        scrambledSongTitle: scrambledTitle, songTitle: correctTitle);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}
