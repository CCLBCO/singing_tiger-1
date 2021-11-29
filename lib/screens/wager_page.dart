import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'dart:math';
import '../game_model/album_song_game.dart';
import '../utilities/score_keeper.dart';
import 'components/wager_slider.dart';
import '../constants.dart';
import 'p1_final_jeopardy_page.dart';

class WagerPage extends StatefulWidget {
  WagerPage(
      {required this.scoreKeeper,
      required this.asg1,
      required this.asg2,
      required this.asg3});

  final ScoreKeeper scoreKeeper;
  final AlbumSongGame asg1;
  final AlbumSongGame asg2;
  final AlbumSongGame asg3;
  @override
  _WagerPageState createState() => _WagerPageState();
}

class _WagerPageState extends State<WagerPage> {
  late int playerOneScore;
  late int playerTwoScore;
  late int min;
  late int maxForPlayer1;
  late int maxForPlayer2;
  int player1Wager = 0;
  int player2Wager = 0;

  @override
  Widget build(BuildContext context) {
    playerOneScore = widget.scoreKeeper.getPlayerOneScore();
    playerTwoScore = widget.scoreKeeper.getPlayerTwoScore();
    min = 0;
    maxForPlayer1 = ((playerOneScore.abs() + 100) * 1.5).toInt() + 150;
    maxForPlayer2 = ((playerTwoScore.abs() + 100) * 1.5).toInt() + 150;

    void sendToFinalJeopardy(
        {required int playerOneWager,
        required int playerTwoWager,
        required AlbumSongGame asg1,
        required AlbumSongGame asg2,
        required AlbumSongGame asg3}) {
      List<AlbumSongGame> listOfAlbumGames = [asg1, asg2, asg3];
      /*//picks a random album song game object that player one will play
      int rnd1 = Random().nextInt(listOfAlbumGames.length);
      AlbumSongGame asgForPlayerOne = listOfAlbumGames[rnd1];
      //removes it so that it will not be taken by player two
      listOfAlbumGames.removeAt(rnd1);
      print('the album name for player one is: ${asgForPlayerOne.albumName}');

      //picks a random album song game object that player two will play
      int rnd2 = Random().nextInt(listOfAlbumGames.length);
      AlbumSongGame asgForPlayerTwo = listOfAlbumGames[rnd2];
      print('the album name for player two is: ${asgForPlayerTwo.albumName}');*/
      AlbumSongGame asgForPlayerOne = listOfAlbumGames[0];
      AlbumSongGame asgForPlayerTwo = listOfAlbumGames[2];
      print('the album name for player one is: ${asgForPlayerOne.albumName}');
      print('the album name for player two is: ${asgForPlayerTwo.albumName}');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => P1FinalJeopardy(
              playerOneWager: playerOneWager,
              playerTwoWager: playerTwoWager,
              asg1: asgForPlayerOne,
              asg2: asgForPlayerTwo,
              scoreKeeper: widget.scoreKeeper),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/zoomed.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: kWagerPageColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlowText(
                'FINAL JEOPARDY',
                style: kWagerHeader1TextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              GlowText(
                'WAGER YOUR POINTS',
                style: kWagerHeader2TextStyle,
              ),
              WagerSlider(
                player: 'PLAYER ONE',
                playerWager: player1Wager,
                maxForPlayer: maxForPlayer1,
                onChanged: (double value1) {
                  setState(() {
                    player1Wager = value1.round();
                  });
                },
              ),
              WagerSlider(
                player: 'PLAYER TWO',
                playerWager: player2Wager,
                maxForPlayer: maxForPlayer2,
                onChanged: (double value2) {
                  setState(() {
                    player2Wager = value2.round();
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              GlowButton(
                color: kWagerButtonColor,
                width: 150.0,
                child: Text(
                  'PLAY',
                  style: kWagerButtonTextStyle,
                ),
                onPressed: () {
                  setState(() {
                    sendToFinalJeopardy(
                        playerOneWager: player1Wager,
                        playerTwoWager: player2Wager,
                        asg1: widget.asg1,
                        asg2: widget.asg2,
                        asg3: widget.asg3);
                  });
                },
              ),
              /*GestureDetector(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GlowText(
                        'PLAYER TWO',
                        style: kWagerPlayerTextStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GlowText(
                        'WAGER',
                        style: kWagerTextStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          GlowText(
                            player2Wager.toString(),
                            style: kWagerTextStyle,
                          ),
                          GlowText(
                            'pts',
                            style: kWagerTextStyle,
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 2.0,
                          inactiveTrackColor: Color(0xFFD26201),
                          activeTrackColor: Color(0xFFF2AE00),
                          thumbColor: kWagerTextColor,
                          overlayColor: Color(0x50C73003),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: Slider(
                          value: player1Wager.toDouble(),
                          min: min.toDouble(),
                          max: maxForPlayer2.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              player2Wager = newValue.round();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    color: kWagerCardColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
