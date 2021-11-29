import 'package:flutter/material.dart';
import 'package:singing_tiger_test/constants.dart';

class InputBoxes extends StatelessWidget {
  InputBoxes({required this.hintText, required this.function});


  final String hintText;
  final Function(String) function;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      shadowColor: Color(0xFFFFE600),
      borderRadius: BorderRadius.circular(15),
      borderOnForeground: true,
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFFFFE600)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFFFFE600)),
          ),
          hintText: hintText, //'ARTIST 1'
          hintStyle: kHintTextStyle,
          //fillColor: Colors.white,
          filled: false,
        ),
        onChanged: function, /*(inputtedArtist1) {
                                artistName1 = inputtedArtist1;
                                },*/
      ),
    );
  }
}
