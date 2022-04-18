import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiration_inventory_tracker_app/screens/add_page.dart';
import 'package:expiration_inventory_tracker_app/screens/inventory_list.dart';
import 'package:expiration_inventory_tracker_app/services/auth_controller.dart';
import 'package:expiration_inventory_tracker_app/shared/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userID = FirebaseAuth.instance.currentUser!.uid;
  var itemcollections = FirebaseFirestore.instance.collection('items');
  DateTime? lastDay, firstDay;

  List<Color> colors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.pink.shade100,
    Colors.red.shade100
  ];
  Color kd = Colors.red;

  getDate() {
    DateTime now = new DateTime.now();
    DateTime lastDayOfMonth = new DateTime(now.year, now.month + 1, 0);
    DateTime firstDayOfMonth = new DateTime(now.year, now.month, 1);
    setState(() {
      lastDay = lastDayOfMonth;
      firstDay = firstDayOfMonth;
    });
  }

  Stream<int> getMonthItemCount() {
    return FirebaseFirestore.instance
        .collection('items')
        .doc(userID)
        .collection('items')
        .where('date', isGreaterThan: firstDay)
        .where('date', isLessThan: lastDay)
        .snapshots()
        .map((documentSnapshot) => documentSnapshot.docs.length);
  }

  Stream<int> getItemCount() {
    return FirebaseFirestore.instance
        .collection('items')
        .doc(userID)
        .collection('items')
        .snapshots()
        .map((documentSnapshot) => documentSnapshot.docs.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
    getMonthItemCount();
    getItemCount();
  }

  int? monthItem;
  int? itemCount;

  @override
  Widget build(BuildContext context) {
    getMonthItemCount().listen((activityCount) {
      if (mounted) {
        setState(() {
          monthItem = activityCount;
        });
      }
    });
    getItemCount().listen((activityCount) {
      if (mounted) {
        setState(() {
          itemCount = activityCount;
        });
      }
    });
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white, size: 90),
          actions: [
            PopupMenuButton(
              color: Colors.white,
              onSelected: (value) {
                if (value == 0) {
                  AuthControllerService().signout();
                }
              },
              icon: Icon(Icons.more_vert_rounded),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text('Sign Out'),
                ),
              ],
            ),
          ],
          // centerTitle: true,
          elevation: 0,
          title: Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 60.sp,
              letterSpacing: 1,
            ),
          )),
      body: itemCount == null
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                '$itemCount',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50.sp,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'Total Items',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                '$monthItem',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50.sp,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'Due This Month',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Due this Month',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          child: StreamBuilder<QuerySnapshot?>(
                              stream: itemcollections
                                  .doc(userID)
                                  .collection('items')
                                  .where('date', isGreaterThan: firstDay)
                                  .where('date', isLessThan: lastDay)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot?> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.docs.length == 0 ||
                                      snapshot.data!.docs.length == null) {
                                    showToast('No items due this month');
                                    return Container(
                                      height: 1500.h,
                                      width: double.maxFinite,
                                      child: Center(
                                        child: Text('No items due this month'),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height: 1500.h,
                                      width: double.maxFinite,
                                      child: ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          DocumentSnapshot dsnapshot =
                                              snapshot.data!.docs[index];

                                          if (dsnapshot['category'] ==
                                              'Finished Goods') {
                                            kd = colors[0];
                                          }
                                          if (dsnapshot['category'] ==
                                              'Raw Materials') {
                                            kd = colors[1];
                                          }
                                          if (dsnapshot['category'] ==
                                              'Maintenance, Repair, and Operating (MRO)') {
                                            kd = colors[2];
                                          }
                                          if (dsnapshot['category'] ==
                                              'Work In Progress (WIP)') {
                                            kd = colors[3];
                                          }

                                          final now = DateTime.now();
                                          final expirationDate =
                                              (dsnapshot['date']).toDate();
                                          final bool isExpired =
                                              expirationDate.isBefore(now);

                                          return Card(
                                            elevation: 0,
                                            color: kd,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        dsnapshot['category'],
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )),
                                                      isExpired
                                                          ? Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 15.r,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Text(
                                                                  'Expired',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            )
                                                          : Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 15.r,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Text(
                                                                  'Not Expired',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Text(
                                                    dsnapshot['name'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Expiring Date: ',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Expanded(
                                                        child: Text(dsnapshot[
                                                            'expiryDate']),
                                                      ),
                                                      Text(
                                                        'Quantity: ',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                          '${dsnapshot['quantity']}'),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(dsnapshot[
                                                          'quantityType']),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ));
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
