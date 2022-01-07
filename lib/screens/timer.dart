import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:focus_bits/components/focus_segments_counter.dart';
import 'package:focus_bits/constants.dart';
import 'package:focus_bits/models/category.dart';
import 'package:focus_bits/models/timer.dart';

import 'change_category.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  FocusPeriod? currentFocus;
  Duration? timeLeft;
  late Timer ticker;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FocusSegmentsCounter(),
            GestureDetector(
              onTap: () {
                if (currentFocus == null) {
                  setState(() {
                    currentFocus = FocusPeriod(
                      duration: const Duration(minutes: 25),
                      category: Category(
                        id: 1,
                        name: 'Studying',
                        color: const Color(0xFFFF7676),
                        icon: CupertinoIcons.book_solid,
                      ),
                    );
                  });
                  timeLeft = currentFocus!.duration;
                  ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
                    setState(() {
                      timeLeft = timeLeft! - const Duration(seconds: 1);
                    });
                  });
                } else {
                  print('pause');
                }
              },
              child: const Icon(
                CupertinoIcons.hourglass,
                size: 300,
              ),
            ),
            Text(
              timeLeft != null ? timeLeft!.inSeconds.toString() : '25:00',
              style: kTimerCounterStyle,
            ),
            CupertinoButton(
              child: const Text(
                'Studying',
                style: TextStyle(color: kPrimaryColor77),
              ),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return const ChangeCategoryMenu();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
