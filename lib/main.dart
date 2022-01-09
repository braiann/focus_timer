import 'package:flutter/cupertino.dart';
import 'package:focus_bits/constants.dart';
import 'package:focus_bits/screens/home.dart';
import 'package:focus_bits/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return CupertinoApp(
      theme: CupertinoTheme.of(context).copyWith(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        barBackgroundColor: kBarBackgroundColor,
      ),
      home: currentUser == null ? const Welcome() : Home(),
    );
  }
}
