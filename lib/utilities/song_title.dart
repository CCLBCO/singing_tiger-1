import 'dart:convert';
import 'package:http/http.dart' as http;
import 'artist_id.dart';
import '../constants.dart';
import 'dart:math';
class Song{
  int randomSongNumber = Random().nextInt(49);
  late int songID;
  late String songTitle;
  int? nextPage;
  late bool hasNextPage;

  Future<String> getSongTitle(String artistName) async {
    int artistID = await getArtistID(artistName: artistName);

    Uri songPath = Uri.parse('https://genius.p.rapidapi.com/artists/'
        '$artistID/songs'
        '?per_page=50'
        '&page=1'
        '&sort=popularity' //to result prioritizing popular songs
        '&rapidapi-key=$kApi_key');

    http.Response songResponse = await http.get(songPath);
    var songData = json.decode(songResponse.body);

    if (songResponse.statusCode == 200) {

      songTitle = songData['response']['songs'][randomSongNumber]['title'];

      return songTitle;
    } else {
      return 'No song found';
    }
  }

}

