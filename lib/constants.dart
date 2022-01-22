import 'package:flutter/cupertino.dart';

const Duration kFocusDuration = Duration(seconds: 25);
const Duration kShortBreakDuration = Duration(seconds: 5);
const Duration kLongBreakDuration = Duration(seconds: 15);

const Color kBackgroundColor = Color(0xFFB8336A);
const Color kPrimaryColor = Color(0xFFE5FCFF);
const Color kBarBackgroundColor = Color(0x22161616);
const Color kInactiveBottomBarItemColor = Color(0x55E5FCFF);
const Color kPrimaryColor22 = Color(0x22E5FCFF);
const Color kPrimaryColor55 = Color(0x55E5FCFF);
const Color kPrimaryColor77 = Color(0x77E5FCFF);

const TextStyle kTimerCounterStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.w600,
  fontSize: 50.0,
);

const kTextFieldDecoration = BoxDecoration(
  color: Color(0x22000000),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

final kLargeTitleStyle = const CupertinoTextThemeData()
    .navLargeTitleTextStyle
    .copyWith(color: const Color(0xFFFFFFFF));

const kSmallLabel = TextStyle(color: kPrimaryColor77);

const Map<String, Color> kCategoryColors = {
  'red': Color(0xFFFF7676),
  'orange': Color(0xFFFFB576),
  'yellow': Color(0xFFFFFF76),
  'green': Color(0xFF96FF76),
  'cyan': Color(0xFF76FFE5),
  'blue': Color(0xFF76A0FF),
  'purple': Color(0xFFE576FF),
  'pink': Color(0xFFFF93D1),
  'gray': Color(0xFFbfbfbf),
  'grey': Color(0xFFbfbfbf),
};
