import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import '../constants.dart';
import '../screens/components/input_boxes.dart';
import '../screens/first_loading_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  //late: since it'll be initialized at run-time
  late String artistName1 = '';
  late String artistName2 = '';
  late String artistName3 = '';

  // Initially null since the input boxes are blank at first
  VoidCallback? button = null;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    //send the the artist names to the loading page where
    // they will be processed into game components
    void sendToLoadingPage() async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FirstLoadingPage(
              artistName1: artistName1,
              artistName2: artistName2,
              artistName3: artistName3),
        ),
      );
    }

    if (artistName1.isNotEmpty &&
        artistName2.isNotEmpty &&
        artistName3.isNotEmpty) {
      button = () {
        sendToLoadingPage();
      };
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/arcade.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  //for media query responsiveness
                  padding: EdgeInsets.fromLTRB(
                    screenWidth / 5,
                    screenHeight * 3 / 11,
                    screenWidth / 5,
                    screenHeight * 2 / 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GlowText(
                        "ENTER YOUR ARTISTS",
                        style: kEnterArtistsTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      // Input Boxes is a custom-designed widget for the project
                      // which copies the format from input_boxes.dart
                      InputBoxes(
                        hintText: 'ARTIST 1',
                        function: (inputtedArtist1) {
                          artistName1 = inputtedArtist1;
                        },
                      ),
                      InputBoxes(
                        hintText: 'ARTIST 2',
                        function: (inputtedArtist2) {
                          artistName2 = inputtedArtist2;
                        },
                      ),
                      InputBoxes(
                        hintText: 'ARTIST 3',
                        function: (inputtedArtist3) {
                          artistName3 = inputtedArtist3;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: button == null ? 0 : 120,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF000000).withAlpha(60),
                        blurRadius: 20.0,
                        spreadRadius: 0.0,
                        offset: Offset(
                          0.0,
                          3.0,
                        ),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30.0),
                    child: ElevatedButton(
                        style: kEnabledNextButtonStyle,
                        child: Text(
                          "NEXT",
                          style: kNextButtonTextStyle,
                        ),
                        onPressed: button
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
