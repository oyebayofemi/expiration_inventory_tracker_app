import 'package:expiration_inventory_tracker_app/screens/add_page.dart';
import 'package:expiration_inventory_tracker_app/screens/inventory_list.dart';
import 'package:expiration_inventory_tracker_app/services/auth_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
          toolbarHeight: 100,
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
              fontSize: 30,
              letterSpacing: 1,
            ),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '2,424',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Total Items',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '3,454',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Due This Month',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Due this Month'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
