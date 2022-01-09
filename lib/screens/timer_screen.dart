import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:focus_bits/components/focus_segments_counter.dart';
import 'package:focus_bits/constants.dart';
import 'package:focus_bits/models/category.dart';
import 'package:focus_bits/models/timer.dart';
import 'package:focus_bits/utils/get_duration_string.dart';

import 'change_category.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  FocusPeriod? currentFocus;
  Duration? timeLeft = const Duration(seconds: 5);
  Timer? ticker;
  int currentPeriod = // 0, 2, 4, 6 are the four focus periods.
      0; //1, 3, 5 are short breaks. 7 is a long break.

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FocusSegmentsCounter(currentPeriod: currentPeriod),
            GestureDetector(
              // Short tap means play/pause current timer.
              onTap: () {
                playPauseTimer();
              },
              child: Icon(
                ticker == null
                    ? CupertinoIcons.hourglass_bottomhalf_fill
                    : ticker!.isActive
                        ? CupertinoIcons.hourglass
                        : currentPeriod == 1 ||
                                currentPeriod == 3 ||
                                currentPeriod == 5
                            ? CupertinoIcons.hourglass_tophalf_fill
                            : CupertinoIcons.hourglass_bottomhalf_fill,
                size: 300,
              ),
            ),
            Text(
              timeLeft != null ? getDurationString(timeLeft!) : '25:00',
              style: kTimerCounterStyle,
            ),
            currentPeriod == 1 ||
                    currentPeriod == 3 ||
                    currentPeriod == 5 ||
                    currentPeriod == 7
                ? CupertinoButton(
                    onPressed: () {},
                    child: const Text(
                      'Break',
                      style: TextStyle(color: kPrimaryColor77),
                    ),
                  )
                : CupertinoButton(
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

  void playPauseTimer() {
    if (currentFocus == null) {
      setState(() {
        currentFocus = FocusPeriod(
          duration: const Duration(seconds: 5),
          category: Category(
            id: 1,
            name: 'Studying',
            color: const Color(0xFFFF7676),
            icon: CupertinoIcons.book_solid,
          ),
        );
      });
      timeLeft = currentFocus!.duration;
      countDown();
    } else {
      if (ticker != null && ticker!.isActive) {
        ticker!.cancel();
      } else {
        countDown();
      }
    }
  }

  void countDown() {
    ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft!.inSeconds <= 0) {
          timer.cancel();
          currentPeriod = (currentPeriod + 1) % 7;
          timeLeft = currentPeriod == 0 ||
                  currentPeriod == 2 ||
                  currentPeriod == 4 ||
                  currentPeriod == 6
              ? const Duration(seconds: 5) // Focus
              : currentPeriod == 1 || currentPeriod == 3 || currentPeriod == 5
                  ? const Duration(seconds: 2) // Short break
                  : const Duration(seconds: 3); // Long break
        } else {
          timeLeft = timeLeft! - const Duration(seconds: 1);
        }
      });
    });
  }
}
