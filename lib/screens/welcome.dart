import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_bits/screens/login.dart';
import 'package:focus_bits/screens/signup.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoPageScaffold(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.hourglass,
                        size: 35,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Focus Bits',
                        style: const CupertinoTextThemeData()
                            .navLargeTitleTextStyle
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CupertinoColors.black,
                        ),
                        width: double.infinity,
                        height: 50,
                        child: const Center(
                          child: Text('Create an account'),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => Signup(),
                          ),
                        );
                      },
                    ),
                    CupertinoButton(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0x10FFFFFF),
                        ),
                        width: double.infinity,
                        height: 50,
                        child: const Center(
                          child: Text('Login'),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
