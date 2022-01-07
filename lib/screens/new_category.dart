import 'package:flutter/cupertino.dart';

class NewCategoryMenu extends StatelessWidget {
  const NewCategoryMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('New Category'),
      message: Column(
        children: [
          CupertinoPopupSurface(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const CupertinoTextField.borderless(
                    prefix: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Name',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Goal',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        CupertinoButton(
                          child: const Icon(CupertinoIcons.minus_circle_fill),
                          onPressed: () {},
                        ),
                        const Text(
                          '25 m',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        CupertinoButton(
                          child: const Icon(CupertinoIcons.add_circled_solid),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Color'),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                Icon(
                  CupertinoIcons.circle_fill,
                  color: Color(0xFFFF7676),
                  size: 40,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Icon'),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                Icon(
                  CupertinoIcons.airplane,
                  size: 40,
                ),
              ],
            ),
          ),
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
