import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:focus_bits/constants.dart';
import 'package:focus_bits/models/category.dart';
import 'package:focus_bits/models/user.dart';

class NewCategoryMenu extends StatefulWidget {
  const NewCategoryMenu({Key? key}) : super(key: key);

  @override
  State<NewCategoryMenu> createState() => _NewCategoryMenuState();
}

class _NewCategoryMenuState extends State<NewCategoryMenu> {
  String _name = '';
  Duration _goal = const Duration(seconds: 1500);
  int _selectedColorIndex = 0;
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
                  CupertinoTextField.borderless(
                    onChanged: (value) => _name = value,
                    prefix: const Padding(
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
                          onPressed: () {
                            setState(() {
                              _goal = _goal.inSeconds >= 3000
                                  ? _goal - const Duration(seconds: 1500)
                                  : const Duration(seconds: 1500);
                            });
                          },
                        ),
                        Text(
                          '${_goal.inMinutes} min',
                          style: const TextStyle(fontSize: 15.0),
                        ),
                        CupertinoButton(
                          child: const Icon(CupertinoIcons.add_circled_solid),
                          onPressed: () {
                            setState(() {
                              _goal = _goal + const Duration(seconds: 1500);
                            });
                          },
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: kCategoryColors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kCategoryColors.values.elementAt(index),
                        border: _selectedColorIndex == index
                            ? Border.all(
                                color: kBackgroundColor,
                                width: 3,
                              )
                            : null,
                      ),
                      height: 40,
                      width: 40,
                      child: _selectedColorIndex == index
                          ? const Center(
                              child: Icon(
                                CupertinoIcons.checkmark_alt,
                                color: kBackgroundColor,
                              ),
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            CurrentUser currentUser = await FirebaseFirestore.instance
                .collection('users')
                .where('email',
                    isEqualTo: FirebaseAuth.instance.currentUser!.email)
                .get()
                .then((value) {
              return CurrentUser(
                id: value.docs.first.id,
                email: value.docs.first['email'],
              );
            });
            FirebaseFirestore.instance
                .collection('users/${currentUser.id}/categories')
                .add({
              'color': kCategoryColors.keys.elementAt(_selectedColorIndex),
              'goalSeconds': _goal.inSeconds,
              'name': _name,
            });
            Navigator.pop(
              context,
              Category(
                id: '',
                name: _name,
                color: kCategoryColors.keys.elementAt(_selectedColorIndex),
                goal: _goal,
              ),
            );
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
