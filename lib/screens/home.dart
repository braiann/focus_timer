import 'package:flutter/cupertino.dart';
import 'package:focus_bits/constants.dart';
import 'package:focus_bits/screens/account.dart';
import 'package:focus_bits/screens/stats.dart';
import 'package:focus_bits/screens/timer_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final List<Widget> tabViews = [
    const TimerScreen(),
    StatsScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          inactiveColor: kInactiveBottomBarItemColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.hourglass),
              label: 'Timer',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chart_pie),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Account',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return tabViews[index];
        },
      ),
    );
  }
}
