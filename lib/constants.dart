import 'package:flutter/material.dart';

// API key
const kApi_key = '3adb15db4cmsh86fc7b52f545f07p162563jsn44fafc528771';

const kSingingTigerHeaderColor = Color(0xFFF7C86B);
const kGameHeadersColor = Color(0xFFFFE600);
const kPlayButtonColor = Color(0xFFFFC672);
const kShadowColor = Color(0xFFFFE600);
const kHintTextColor = Color(0xFFBBBBBB);
const kDisabledColor = Color(0xFFC4A466);
const kEnabledColor = Color(0xFFFFE600);
const kLoadingBackgroundColor = Color(0xFF1A0000);
const kLoadingGameTextColor = Color(0xFFD15B03); //Color(0xFF961E05)
const kGameButtonColor = Color(0xFFFFE600);
const kGameTurnTextColor = Color(0xFF961E05);
const kScoreHeaderColor = Color(0xFFFFE600);
const kScoreBoxColor = Colors.black;
const kGameTextColor = Colors.white;
const kAlertBackgroundColor = Color(0xFF961E05);
const kAlertTextColor = Color(0xFFFFE600);
const kWagerPageColor = Color(0xFF1A0000);
const kWagerHeaderColor = Color(0xFF961E05);
const kWagerCardColor = Color(0xFF961E05);
const kWagerPlayerTextColor = Color(0xFFFFE600);
const kWagerTextColor = Color(0xFFFFE600);
const kWagerButtonTextColor = Color(0xFF961E05);
const kWagerButtonColor = Color(0xFFFFE600);
const kFinalJeopardyHeaderColor = Color(0xFF961E05);

const kWelcomeTextStyle = TextStyle(
    fontFamily: 'Press Start 2P',
    fontSize: 35.0,
    color: kSingingTigerHeaderColor);

const kWelcomeTextStyle2 = TextStyle(
    fontFamily: 'Press Start 2P',
    fontSize: 35.0,
    color: kSingingTigerHeaderColor);

const buttonTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 18.0,
  color: kGameTextColor,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.6,
);

final ButtonStyle kPlayButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Color(0xffF7C86B),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

const kPlayButtonTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 18.0,
  color: Color(0xFF1A0000),
  fontWeight: FontWeight.bold,
  letterSpacing: 1.6,
);

const kEnterArtistsTextStyle = TextStyle(
    fontFamily: 'Press Start 2P', fontSize: 15.0, color: kGameHeadersColor);

const kHintTextStyle = TextStyle(
    fontFamily: 'Press Start 2P', fontSize: 10.0, color: kHintTextColor);

final ButtonStyle kDisabledNextButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: kDisabledColor,
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle kEnabledNextButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: kEnabledColor,
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

const kNextButtonTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 18.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.6,
);

const kLoadingGameTextStyle = TextStyle(
  fontFamily: 'Press Start 2P',
  fontSize: 18.0,
  color: kLoadingGameTextColor,
  letterSpacing: 1.6,
);

const kGameArtistsNameHeaderTextStyle =
    TextStyle(fontFamily: 'Roboto', fontSize: 15.0, color: kGameHeadersColor);

const kGameButtonTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 13.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.6,
);

const kGameTurnTextStyle = TextStyle(
    fontFamily: 'Press Start 2P', fontSize: 12.0, color: kGameTurnTextColor);

const kScoreKeeperHeaderTextStyle =
    TextStyle(fontFamily: 'Roboto', fontSize: 15.0, color: kScoreHeaderColor);

const kScoreKeeperTextStyle = TextStyle(
  fontFamily: 'Press Start 2P',
  fontSize: 15.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.6,
);

const kGameTextStyle =
    TextStyle(fontFamily: 'Roboto', fontSize: 23.0, color: kGameTextColor);

const kAlertMessageTextStyle = TextStyle(
  color: kAlertTextColor,
  fontFamily: 'Press Start 2P',
  fontSize: 18,
  letterSpacing: 2.0,
);
const kAlertSubMessageTextStyle = TextStyle(
  color: Color(0xFFFFE600),
  fontFamily: 'Press Start 2P',
  fontSize: 10,
  letterSpacing: 2.0,
  height: 2.0,
);

const kWagerHeader1TextStyle = TextStyle(
    fontFamily: 'Press Start 2P', fontSize: 20.0, color: kWagerHeaderColor);

const kWagerHeader2TextStyle = TextStyle(
    fontFamily: 'Press Start 2P', fontSize: 10.0, color: kWagerHeaderColor);

const kWagerPlayerTextStyle = TextStyle(
    fontFamily: 'Press Start 2P', fontSize: 20.0, color: kWagerPlayerTextColor);

const kWagerTextStyle = TextStyle(
    fontFamily: 'Press Start 2P', fontSize: 10.0, color: kWagerTextColor);

const kWagerButtonTextStyle = TextStyle(
    fontFamily: 'Press Start 2P', fontSize: 20.0, color: kWagerButtonTextColor);

const kFinalJeopardyHeader1TextStyle = TextStyle(
    fontFamily: 'Press Start 2P',
    fontSize: 20.0,
    color: kFinalJeopardyHeaderColor);

const kFinalHeader2TextStyle = TextStyle(
    fontFamily: 'Press Start 2P',
    fontSize: 10.0,
    color: kFinalJeopardyHeaderColor);

const kWinnerTextStyle = TextStyle(
    fontFamily: 'Press Start 2P',
    fontSize: 25.0,
    color: kFinalJeopardyHeaderColor);

const kRestartButtonTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 17.0,
  color: Color(0xFF1A0000),
  fontWeight: FontWeight.bold,
  letterSpacing: 1.6,
);
