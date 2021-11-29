import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

class Album {

  Future<String> getAlbum(int sD) async {
    int songID = sD;
    Uri albumPath = Uri.parse('https://genius.p.rapidapi.com/songs/'
        '$songID/'
        '?rapidapi-key=$kApi_key');
    http.Response soundURLResponse = await http.get(albumPath);
    var albumData = json.decode(soundURLResponse.body);

    if (soundURLResponse.statusCode == 200) {
      String albumName;
      try {
        albumName = albumData['response']['song']['album']['name'];
      } catch (e) {
        albumName = 'singles';
      }
      print("Album is: $albumName");
      return albumName;
    } else {
      return ': D';
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