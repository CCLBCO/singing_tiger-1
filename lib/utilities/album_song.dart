import 'get_album.dart';

class AlbumSongGetter {

  Future<String> albumName(int sD) async {
    String albumName = await Album().getAlbum(sD);
    return albumName;
  }

}