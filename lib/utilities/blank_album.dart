import 'dart:math';

class BlankAlbum {
  late String sB;
  late List<String> temp;

  Future<String> getAlbumTitle(String album) async {
    temp = toArray(album);
    sB = albumString(temp);
    return sB;
  }

  String getBlankAlbum(String album) {
    temp = toArray(album);

    if (temp.length < 2) {
      temp = removeRandomLetters(temp);
    } else if (temp.length <= 4) {
      temp = removeRandomLetters(temp);
      temp = removeRandomLetters(temp);
    } else if (temp.length > 4 && temp.length <= 6) {
      temp = removeRandomLetters(temp);
      temp = removeRandomLetters(temp);
      temp = removeRandomLetters(temp);
    } else if (temp.length > 6) {
      temp = removeRandomLetters(temp);
      temp = removeRandomLetters(temp);
      temp = removeRandomLetters(temp);
      temp = removeRandomLetters(temp);
    } else if (temp.length > 10) {
      temp = removeRandomLetters(temp);
      temp = removeRandomLetters(temp);
      temp = removeRandomLetters(temp);
      temp = removeRandomLetters(temp);
      temp = removeRandomLetters(temp);
    }

    sB = albumString(temp);
    return sB;
  }

  List<String> removeRandomLetters(List<String> album) {
    int rnd = Random().nextInt(album.length);

    if (album[rnd] != "" && album[rnd] != " ") {
      album.replaceRange(rnd, rnd + 1, ["_"]);

      return album;
    } else {
      return album;
    }
  }

  List<String> toArray(String album) {
    int temp;
    List<String> newArray = [];
    for (int i = 0; i < album.length; i++) {
      newArray = newArray + album[i].split("");
    }

    // Removes anything after a certain index (- 2 para mawala space)
    for (int i = 0; i < newArray.length; i++) {
      if (newArray[i] == "(") {
        temp = newArray.indexOf("(");
        newArray = newArray.sublist(0, temp - 1);
        return newArray;
      }
      if (newArray[i] == "-") {
        temp = newArray.indexOf("-");
        newArray = newArray.sublist(0, temp - 1);
        return newArray;
      }
      if (newArray[i] == "[") {
        temp = newArray.indexOf("[");
        newArray = newArray.sublist(0, temp - 1);
        return newArray;
      }
    }

    return newArray;
  }

  String albumString(List<String> album) {
    StringBuffer sb = new StringBuffer();

    for (String ch in album) {
      sb.write(ch);
    }

    String finalBlankedAlbum = sb.toString();
    return finalBlankedAlbum;
  }
}
