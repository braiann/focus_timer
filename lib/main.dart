import 'package:flutter/cupertino.dart';
import 'package:focus_bits/constants.dart';
import 'package:focus_bits/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoTheme.of(context).copyWith(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        barBackgroundColor: kBarBackgroundColor,
      ),
      home: Home(),
    );
  }
}
