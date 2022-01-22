import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:focus_bits/components/text_field.dart';
import 'package:focus_bits/constants.dart';
import 'package:focus_bits/screens/home.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  late String? email;
  late String? password;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color(0x00000000),
        border: null,
        previousPageTitle: 'Back',
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Log In',
                style: kLargeTitleStyle,
              ),
            ),
            TextField(
              placeholder: 'Email',
              icon: CupertinoIcons.envelope,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              placeholder: 'Password',
              icon: CupertinoIcons.lock,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton.filled(
              child: const Text('Continue'),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email!, password: password!);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                } catch (e) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
