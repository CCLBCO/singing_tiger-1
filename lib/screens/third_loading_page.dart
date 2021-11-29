import 'package:flutter/material.dart';
import 'package:singing_tiger_test/game_model/scramble_song_title.dart';
import 'package:singing_tiger_test/game_model/album_song_game.dart';
import 'package:singing_tiger_test/utilities/album_song.dart';
import 'package:singing_tiger_test/utilities/blank_album.dart';
import 'package:singing_tiger_test/utilities/get_album.dart';
import 'package:singing_tiger_test/utilities/score_keeper.dart';
import 'package:singing_tiger_test/utilities/song_id.dart';
import 'package:singing_tiger_test/utilities/string_scrambler.dart';
import 'components/loading_screen.dart';
import 'wager_page.dart';

class ThirdLoadingPage extends StatefulWidget {
  ThirdLoadingPage(
      {required this.artistName1,
      required this.artistName2,
      required this.artistName3,
      required this.scoreKeeper});

  final String artistName1;
  final String artistName2;
  final String artistName3;
  final ScoreKeeper scoreKeeper;

  @override
  _ThirdLoadingPageState createState() => _ThirdLoadingPageState();
}

class _ThirdLoadingPageState extends State<ThirdLoadingPage> {
  TitleScrambler ts = TitleScrambler();

  @override
  void initState() {
    super.initState();
    String an1 = widget.artistName1;
    String an2 = widget.artistName2;
    String an3 = widget.artistName3;

    sendToWagerPage(artistName1: an1, artistName2: an2, artistName3: an3);
  }

  void sendToWagerPage(
      {required String artistName1,
      required String artistName2,
      required String artistName3}) async {
    try {
      AlbumSongGame asg1 = await getAlbumSongGameComponent(artistName1);
      AlbumSongGame asg2 = await getAlbumSongGameComponent(artistName2);
      AlbumSongGame asg3 = await getAlbumSongGameComponent(artistName3);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WagerPage(
                scoreKeeper: widget.scoreKeeper,
                asg1: asg1,
                asg2: asg2,
                asg3: asg3,
              )));
    } catch (e) {
      print(e);
      //TODO: make alert dialog that says 'we can't find one of the artists you named, please enter a new one'
    }
  }

  Future<AlbumSongGame> getAlbumSongGameComponent(String aN) async {
    //getting random song ID from a certain artist
    int songID = await SongID().getSongID(aN);
    print(songID);

    //getting the song title of that songID
    String songTitle = await Album().songAlbum(songID);
    print('songTitle = $songTitle');

    //getting the album of the song extracted
    String albumName = await AlbumSongGetter().albumName(songID);
    print('albumName = $albumName');

    //getting the cleaned album name (removed of parenthesis and/or square brackets and/or dashes)
    String correctAlbumName = await BlankAlbum().getAlbumTitle(albumName);
    print('correctAlbumName = $correctAlbumName');

    //getting the blanked version of the correctAlbumName
    String blankedAlbum = BlankAlbum().getBlankAlbum(correctAlbumName);
    print('Blanked Album = $blankedAlbum');

    return AlbumSongGame(
        albumName: correctAlbumName,
        blankAlbumName: blankedAlbum,
        songTitle: songTitle);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}
