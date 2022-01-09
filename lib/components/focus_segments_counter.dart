import 'package:flutter/cupertino.dart';
import 'package:focus_bits/constants.dart';

class FocusSegmentsCounter extends StatelessWidget {
  const FocusSegmentsCounter({
    Key? key,
    required this.currentPeriod,
  }) : super(key: key);

  final int currentPeriod;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            currentPeriod > 0
                ? CupertinoIcons.capsule_fill
                : CupertinoIcons.circle_fill,
            color: kPrimaryColor,
            size: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            currentPeriod > 2
                ? CupertinoIcons.capsule_fill
                : CupertinoIcons.circle_fill,
            color: currentPeriod > 1 ? kPrimaryColor : kPrimaryColor22,
            size: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            currentPeriod > 4
                ? CupertinoIcons.capsule_fill
                : CupertinoIcons.circle_fill,
            color: currentPeriod > 3 ? kPrimaryColor : kPrimaryColor22,
            size: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            currentPeriod > 6
                ? CupertinoIcons.capsule_fill
                : CupertinoIcons.circle_fill,
            color: currentPeriod > 5 ? kPrimaryColor : kPrimaryColor22,
            size: 10,
          ),
        ),
      ],
    );
  }
}
