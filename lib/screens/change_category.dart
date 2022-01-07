import 'package:flutter/cupertino.dart';
import 'package:focus_bits/screens/new_category.dart';

class ChangeCategoryMenu extends StatelessWidget {
  const ChangeCategoryMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Change Category'),
      message: Column(
        children: [
          CupertinoButton(
              child: Row(
                children: const [
                  Icon(CupertinoIcons.add),
                  Text('New Category'),
                ],
              ),
              onPressed: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return const NewCategoryMenu();
                    });
              }),
          SizedBox(
            height: 100,
            child: CupertinoPicker(
              itemExtent: 30,
              useMagnifier: true,
              magnification: 1.2,
              onSelectedItemChanged: (value) {},
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(CupertinoIcons.book_solid),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Study'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(CupertinoIcons.briefcase_fill),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Work'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(CupertinoIcons.device_laptop),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Code'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
          isDefaultAction: true,
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
    );
  }
}
