import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_bits/constants.dart';
import 'package:focus_bits/models/category.dart';
import 'package:focus_bits/models/timer.dart';
import 'package:focus_bits/models/user.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  CurrentUser? currentUser;
  List<FocusPeriod> todayTimers = [];
  Stream<QuerySnapshot>? timersStream;
  Stream<QuerySnapshot>? categoriesStream;
  Set<String> userCategoryPaths = {};
  @override
  void initState() {
    super.initState();
    getStats();
  }

  void getStats() async {
    currentUser = await getCurrentUser();
    getTodayTimers();
  }

  void getTodayTimers() {
    setState(() {
      timersStream = FirebaseFirestore.instance
          .collection('timers')
          .where('user', isEqualTo: '/users/${currentUser!.id}')
          .where('createdAt',
              isGreaterThanOrEqualTo: DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day))
          .snapshots();
    });
  }

  void getUserCategories(AsyncSnapshot<QuerySnapshot> snapshot) {
    var userFocusPeriods = snapshot.data!.docs;
    for (var doc in userFocusPeriods) {
      setState(() {
        userCategoryPaths.add(doc.get('category'));
      });
    }
  }

  Future<CurrentUser> getCurrentUser() async {
    var collectionReference = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    currentUser = CurrentUser(
      id: collectionReference.docs.first.id,
      email: collectionReference.docs.first['email'],
    );
    return currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return timersStream == null
        ? Container()
        : StreamBuilder<QuerySnapshot>(
            stream: timersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              getUserCategories(snapshot);
              return CupertinoPageScaffold(
                child: CustomScrollView(
                  slivers: [
                    const CupertinoSliverNavigationBar(
                      largeTitle: Text('Today'),
                      trailing: Icon(CupertinoIcons.calendar),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Center(
                          child: Column(children: [
                            const SizedBox(height: 20),
                            Text(
                              snapshot.data!.docs.fold(0, (previous, document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return data['durationSeconds'] + previous!;
                              }).toString(),
                              style: kTimerCounterStyle,
                            ),
                            const Text(
                              'focus seconds',
                              style: kSmallLabel,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                          ]),
                        ),
                        // Column(
                        //   children: todayTimers.map((timer) {
                        //     return CategoryBar(
                        //         category: timer.category,
                        //         focusSeconds: timer.duration.inSeconds);
                        //   }).toList(),
                        // ),
                      ]),
                    ),
                  ],
                ),
              );
              // return Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
              //     Map<String, dynamic> data =
              //         document.data()! as Map<String, dynamic>;
              //     return Center(
              //         child: Text(data['durationSeconds'].toString()));
              //   }).toList(),
              // );
            });
    // return CupertinoPageScaffold(
    //   child: CustomScrollView(
    //     slivers: [
    //       const CupertinoSliverNavigationBar(
    //         largeTitle: Text('Today'),
    //         trailing: Icon(CupertinoIcons.calendar),
    //       ),
    //       SliverList(
    //         delegate: SliverChildListDelegate([
    //           const SizedBox(height: 20),
    //           const Text(
    //             '125',
    //             style: kTimerCounterStyle,
    //             textAlign: TextAlign.center,
    //           ),
    //           const Text(
    //             'focus minutes',
    //             style: kSmallLabel,
    //             textAlign: TextAlign.center,
    //           ),
    //           const SizedBox(height: 20),
    //           const CategoryBar(),
    //         ]),
    //       ),
    //     ],
    //   ),
    // );
  }

  // void initChildren(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
  //   List<FocusPeriod> timersToReturn = [];
  //   for (var document in snapshot.data!.docChanges) {
  //     Map<String, dynamic> data = document.doc.data()! as Map<String, dynamic>;
  //     Category? category;
  //     getTodayCategories(data['category']).then((value) {
  //       category = value;
  //       FocusPeriod timer = FocusPeriod(
  //         duration: Duration(seconds: data['durationSeconds']),
  //         category: category!,
  //         //   Category(
  //         // id: 'a',
  //         // name: 'a',
  //         // color: 'red',
  //         // goal: const Duration(seconds: 50),
  //       );
  //       print(timer.duration);
  //       timersToReturn.add(timer);
  //       setState(() {
  //         print(todayTimers.length);
  //         todayTimers = timersToReturn;
  //         print(todayTimers.length);
  //       });
  //     });
  //   }
  // }

  Future<Category> getCategoryByPath(String path) async {
    var data = await FirebaseFirestore.instance.doc(path).get();
    return Category(
      id: data.id,
      name: data['name'],
      color: data['color'],
      goal: Duration(seconds: data['goalSeconds']),
    );
  }
}

class CategoryBar extends StatelessWidget {
  const CategoryBar(
      {Key? key, required this.category, required this.focusSeconds})
      : super(key: key);
  final Category category;
  final int focusSeconds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name,
                style: kSmallLabel.copyWith(color: kPrimaryColor),
              ),
              Text(
                '$focusSeconds/${category.goal.inSeconds}',
                style: kSmallLabel.copyWith(color: kPrimaryColor),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: LinearProgressIndicator(
              value: focusSeconds / category.goal.inSeconds,
              color: kCategoryColors['red'],
              backgroundColor: kBarBackgroundColor,
              minHeight: 5,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
