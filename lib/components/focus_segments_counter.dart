import 'package:flutter/cupertino.dart';
import 'package:focus_bits/constants.dart';

class FocusSegmentsCounter extends StatelessWidget {
  const FocusSegmentsCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(
            CupertinoIcons.capsule_fill,
            color: kPrimaryColor,
            size: 10,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(
            CupertinoIcons.circle_fill,
            color: kPrimaryColor22,
            size: 10,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(
            CupertinoIcons.circle_fill,
            color: kPrimaryColor22,
            size: 10,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(
            CupertinoIcons.circle_fill,
            color: kPrimaryColor22,
            size: 10,
          ),
        ),
      ],
    );
  }
}
