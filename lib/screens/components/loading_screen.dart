import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:singing_tiger_test/constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kLoadingBackgroundColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/singing_tiger_mascot.GIF',
                width: 120.0,
                height: 120.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              GlowText(
                'LOADING GAME...',
                style: kLoadingGameTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
