import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:focus_bits/components/focus_segments_counter.dart';
import 'package:focus_bits/components/hourglass.dart';
import 'package:focus_bits/constants.dart';
import 'package:focus_bits/models/category.dart';
import 'package:focus_bits/models/timer.dart';
import 'package:focus_bits/models/user.dart';
import 'package:focus_bits/utils/get_duration_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_bits/utils/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change_category.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  FocusPeriod? currentFocus;
  Duration? timeLeft = kFocusDuration;
  Timer? ticker;
  int currentPeriod = // 0, 2, 4, 6 are the four focus periods.
      0; //1, 3, 5 are short breaks. 7 is a long break.
  List<Category> categories = [];
  Category? currentCategory;
  CurrentUser? currentUser;
  late SharedPreferences prefs;

  void getCategories() async {
    await getCurrentUser();
    var cats = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.id)
        .collection('categories')
        .get()
        .then((value) => value.docs);

    for (var cat in cats) {
      categories.add(Category(
        id: cat.id,
        name: cat['name'],
        color: cat['color'],
        goal: Duration(seconds: cat['goalSeconds']),
      ));
    }
    setState(() {
      currentCategory = categories.first;
    });
  }

  Future<CurrentUser> getCurrentUser() async {
    var collectionReference = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    return currentUser = CurrentUser(
      id: collectionReference.docs.first.id,
      email: collectionReference.docs.first['email'],
    );
  }

  @override
  void initState() {
    getCategories();
    getLatestTimer();
    super.initState();
  }

  void getLatestTimer() async {
    prefs = await SharedPreferences.getInstance();
    int? secondsLeft = prefs.getInt('secondsLeft');
    if (secondsLeft != null) {
      timeLeft = Duration(seconds: secondsLeft);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FocusSegmentsCounter(currentPeriod: currentPeriod),
            GestureDetector(
              // Short tap means play a new timer.
              onTap: () {
                HapticFeedback.selectionClick();
                startTimer();
              },
              // Long press means stop/cancel timer
              onLongPress: () {
                HapticFeedback.heavyImpact();
                cancelTimer();
              },
              child: Container(
                color: kBackgroundColor,
                height: 300,
                child: currentFocus != null && timeLeft != null
                    ? Hourglass(
                        progress: timeLeft!.inSeconds /
                            currentFocus!.duration.inSeconds)
                    : const Hourglass(progress: 1),
              ),
              // child: Icon(
              //   ticker == null
              //       ? CupertinoIcons.hourglass_bottomhalf_fill
              //       : ticker!.isActive
              //           ? CupertinoIcons.hourglass
              //           : isShortBreak()
              //               ? CupertinoIcons.hourglass_tophalf_fill
              //               : CupertinoIcons.hourglass_bottomhalf_fill,
              //   size: 300,
              // ),
            ),
            Text(
              timeLeft != null
                  ? getDurationString(timeLeft!)
                  : getDurationString(kFocusDuration),
              style: kTimerCounterStyle,
            ),
            isShortBreak() || isLongBreak()
                ? CupertinoButton(
                    onPressed: () {},
                    child: const Text(
                      'Break',
                      style: TextStyle(color: kPrimaryColor77),
                    ),
                  )
                : CupertinoButton(
                    child: Text(
                      currentCategory != null ? currentCategory!.name : '',
                      style: TextStyle(
                          color: currentCategory != null
                              ? currentCategory!.color
                              : kPrimaryColor77),
                    ),
                    onPressed: () async {
                      Category? result = await showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return ChangeCategoryMenu(
                            categories: categories,
                          );
                        },
                      );
                      if (result != null) {
                        setState(() {
                          currentCategory = result;
                        });
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    if (currentCategory != null) {
      if (currentFocus == null) {
        setState(() {
          currentFocus = isFocus()
              ? FocusPeriod(
                  duration: kFocusDuration, category: currentCategory!)
              : isShortBreak()
                  ? FocusPeriod(
                      duration: kShortBreakDuration, category: currentCategory!)
                  : FocusPeriod(
                      duration: kLongBreakDuration, category: currentCategory!);
        });
        timeLeft = currentFocus!.duration;
        countDown();
      }
    }
  }

  void countDown() {
    ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Stop when timer reaches 0.
        if (timeLeft!.inSeconds <= 0) {
          timer.cancel();
          if (isFocus()) {
            saveTimer();
            Notifications.showNotification(
                title: 'Focus finished', body: 'Take a break!');
          } else {
            Notifications.showNotification(
                title: 'Break finished', body: 'Back to work!');
          }
          currentFocus = null;
          currentPeriod = (currentPeriod + 1) % 8;
          timeLeft = isFocus()
              ? kFocusDuration
              : isShortBreak()
                  ? kShortBreakDuration
                  : kLongBreakDuration;
        } else {
          timeLeft = currentFocus!.createdAt
              .add(currentFocus!.duration)
              .difference(DateTime.now());
        }
      });
    });
  }

  void saveTimer() {
    FirebaseFirestore.instance.collection('timers').add({
      'category': '/users/${currentUser!.id}/categories/${currentCategory!.id}',
      'createdAt': DateTime.now(),
      'durationSeconds': currentFocus!.duration.inSeconds,
      'user': '/users/${currentUser!.id}'
    });
  }

  void cancelTimer() {
    setState(() {
      currentFocus == null;
      if (ticker != null) {
        if (ticker!.isActive) {
          ticker!.cancel();
        }
      }
      currentFocus = null;
      currentPeriod = (currentPeriod + 1) % 8;
      timeLeft = isFocus()
          ? kFocusDuration // Focus
          : isShortBreak()
              ? kShortBreakDuration // Short break
              : kLongBreakDuration; // Long break
    });
  }

  bool isFocus() {
    return currentPeriod == 0 ||
        currentPeriod == 2 ||
        currentPeriod == 4 ||
        currentPeriod == 6;
  }

  bool isShortBreak() {
    return currentPeriod == 1 || currentPeriod == 3 || currentPeriod == 5;
  }

  bool isLongBreak() {
    return currentPeriod == 7;
  }
}
