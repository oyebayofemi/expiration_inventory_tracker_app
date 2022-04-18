import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiration_inventory_tracker_app/shared/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowAllItems extends StatefulWidget {
  ShowAllItems({Key? key}) : super(key: key);

  @override
  State<ShowAllItems> createState() => _ShowAllItemsState();
}

class _ShowAllItemsState extends State<ShowAllItems> {
  String userID = FirebaseAuth.instance.currentUser!.uid;
  var itemcollections = FirebaseFirestore.instance.collection('items');
  List<Color> colors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.pink.shade100,
    Colors.red.shade100
  ];
  Color kd = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('All Items'),
      ),
      body: StreamBuilder<QuerySnapshot?>(
        stream: itemcollections.doc(userID).collection('items').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.length == 0 ||
                  snapshot.data!.docs.length == null) {
                showToast('No items in the inventory');
                return Container(
                  child: Center(
                    child: Text('No items '),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot dsnapshot = snapshot.data!.docs[index];

                      if (dsnapshot['category'] == 'Finished Goods') {
                        kd = colors[0];
                      }
                      if (dsnapshot['category'] == 'Raw Materials') {
                        kd = colors[1];
                      }
                      if (dsnapshot['category'] ==
                          'Maintenance, Repair, and Operating (MRO)') {
                        kd = colors[2];
                      }
                      if (dsnapshot['category'] == 'Work In Progress (WIP)') {
                        kd = colors[3];
                      }

                      final now = DateTime.now();
                      final expirationDate = (dsnapshot['date']).toDate();
                      final bool isExpired = expirationDate.isBefore(now);

                      return Card(
                        elevation: 0,
                        color: kd,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    dsnapshot['category'],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  )),
                                  isExpired
                                      ? Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 10.r,
                                              backgroundColor: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text('Expired'),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 10.r,
                                              backgroundColor: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text('Not Expired'),
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
                                    fontWeight: FontWeight.bold),
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
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: Text(dsnapshot['expiryDate']),
                                  ),
                                  Text(
                                    'Quantity: ',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text('${dsnapshot['quantity']}'),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(dsnapshot['quantityType']),
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
            }
            if (!snapshot.hasData) {
              return showToast('No items in the inventory');
            } else {
              return showToast('No items in the inventory');
            }
          }
        },
      ),
    );
  }
}