import 'dart:convert';
import 'package:http/http.dart' as http;
import 'artist_id.dart';
import '../constants.dart';
import 'song_id.dart';

class Album {

  Future<String> getAlbum(int sD) async {
    int songID = sD;
    Uri albumPath = Uri.parse('https://genius.p.rapidapi.com/songs/'
        '$songID/'
        '?rapidapi-key=$kApi_key');
    http.Response soundURLResponse = await http.get(albumPath);
    var albumData = json.decode(soundURLResponse.body);

    if (soundURLResponse.statusCode == 200) {
      String albumName = albumData['response']['song']['album']['name'];
      print("Album is: $albumName");
      return albumName;
    } else {
      return 'Tite';
    }
  }

  Future<String> songAlbum(int sD) async {
    int songID = sD;
    Uri albumPath = Uri.parse('https://genius.p.rapidapi.com/songs/'
        '$songID?&rapidapi-key=$kApi_key');

    http.Response soundURLResponse = await http.get(albumPath);
    var albumData = json.decode(soundURLResponse.body);

    if (soundURLResponse.statusCode == 200) {
      String songAlbum = albumData['response']['song']['title'];
      print("Song in Album is: $songAlbum");
      return songAlbum;
    } else {
      return 'Tite';
    }
  }
}