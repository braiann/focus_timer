import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:focus_bits/constants.dart';
import 'package:focus_bits/screens/welcome.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            automaticallyImplyLeading: false,
            largeTitle: Text('Account'),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SettingsCard(
              children: [
                SettingsCardItem(
                  leading: Text(
                    'Email',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  trailing: Text(
                    'test@test.com',
                    style: TextStyle(color: kPrimaryColor77),
                  ),
                ),
                SettingsCardItem(
                  leading: Text(
                    'Password',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  trailing: Text(
                    '•••••••••••',
                    style: TextStyle(color: kPrimaryColor77),
                  ),
                ),
              ],
            ),
            SettingsCard(children: [
              SettingsCardItem(
                leading: CupertinoButton(
                  child: const Text('Sign out'),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const Welcome(),
                      ),
                    );
                  },
                ),
              )
            ])
          ]))
        ],
      ),
      //   navigationBar: const CupertinoNavigationBar(
      //     middle: Text('Account'),
      //   ),
      //   child: SafeArea(
      //     child: CupertinoButton(
      //       child: const Text('Sign out'),
      //       onPressed: () async {
      //         await FirebaseAuth.instance.signOut();
      //         Navigator.pushReplacement(
      //           context,
      //           CupertinoPageRoute(
      //             builder: (context) => const Welcome(),
      //           ),
      //         );
      //       },
      //     ),
      //   ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({Key? key, required this.children}) : super(key: key);
  final List<SettingsCardItem> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: Column(
          children: children,
        ),
        decoration: BoxDecoration(
            color: kBarBackgroundColor,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class SettingsCardItem extends StatelessWidget {
  const SettingsCardItem({
    Key? key,
    this.leading,
    this.trailing,
  }) : super(key: key);
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];
    if (leading != null) {
      rowChildren.add(leading!);
    }
    if (trailing != null) {
      rowChildren.add(trailing!);
    }
    return Padding(
      padding: trailing == null
          ? const EdgeInsets.all(0)
          : const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: trailing != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: rowChildren,
      ),
    );
  }
}
