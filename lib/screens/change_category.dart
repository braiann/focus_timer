import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:focus_bits/models/category.dart';
import 'package:focus_bits/screens/new_category.dart';

class ChangeCategoryMenu extends StatefulWidget {
  ChangeCategoryMenu({
    Key? key,
    required this.categories,
  }) : super(key: key);

  List<Category> categories;

  @override
  State<ChangeCategoryMenu> createState() => _ChangeCategoryMenuState();
}

class _ChangeCategoryMenuState extends State<ChangeCategoryMenu> {
  @override
  Widget build(BuildContext context) {
    Category selectedCategory = widget.categories.first;
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
              onPressed: () async {
                Category? result = await showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return const NewCategoryMenu();
                  },
                );
                if (result != null) {
                  setState(() {
                    widget.categories.add(result);
                  });
                }
              }),
          SizedBox(
            height: 100,
            child: CupertinoPicker(
              itemExtent: 30,
              useMagnifier: true,
              magnification: 1.2,
              onSelectedItemChanged: (value) {
                SystemSound.play(SystemSoundType.click);
                HapticFeedback.lightImpact();
                selectedCategory = widget.categories[value];
              },
              children: List.generate(
                widget.categories.length,
                (index) => Text(
                  widget.categories[index].name,
                  style: TextStyle(color: widget.categories[index].color),
                ),
              ),
            ),
          )
        ],
      ),
      actions: [
        CupertinoActionSheetAction(
          child: const Text('OK'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(
              context,
              selectedCategory,
            );
          },
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
