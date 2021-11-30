import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'artist_id.dart';
import '../constants.dart';

class SongID {
  int randomSongNumber = Random().nextInt(49);
  late int songID;
  late String songTitle;

  Future<int> getSongID(String aName) async {
    int artistID = await getArtistID(artistName: aName);
    // https://genius.p.rapidapi.com/search?q=Taylor%20Swift&rapidapi-key=3adb15db4cmsh86fc7b52f545f07p162563jsn44fafc528771
    Uri songPath = Uri.parse('https://genius.p.rapidapi.com/artists/'
        '$artistID/songs'
        '?per_page=50'
        '&page=1'
        '&sort=popularity' //to result prioritizing popular songs
        '&rapidapi-key=$kApi_key');

    http.Response songResponse = await http.get(songPath);
    var songData = json.decode(songResponse.body);

    if (songResponse.statusCode == 200) {
      songID = songData['response']['songs'][randomSongNumber]['id'];

      return songID;
    } else {
      return 0;
    }
  }
}
