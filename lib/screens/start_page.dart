import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import '../constants.dart';
import 'guide_page.dart';
import 'input_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/zoomed.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 220.0, 10.0, 90.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GlowText(
                        "SINGING",
                        style: kWelcomeTextStyle,
                      ),
                      GlowText(
                        "TIGER",
                        style: kWelcomeTextStyle2,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 146.0, 30.0, 0),
                    child: Image.asset("images/singing_tiger_mascot.GIF"),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 500.0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 100.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GlowButton(
                          color: kPlayButtonColor,
                          width: 120.0,
                          child: Text(
                            "PLAY",
                            style: kPlayButtonTextStyle,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => InputPage()));
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        GlowButton(
                          color: kPlayButtonColor,
                          width: 180.0,
                          child: Text(
                            "HOW TO PLAY",
                            style: kPlayButtonTextStyle,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GuidePage()));
                            //builder: (context) => GamePage()));
                          },
                        ),
                      ],
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
