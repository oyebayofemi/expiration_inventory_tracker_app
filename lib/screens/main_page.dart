import 'package:expiration_inventory_tracker_app/screens/add_page.dart';
import 'package:expiration_inventory_tracker_app/screens/home_page.dart';
import 'package:expiration_inventory_tracker_app/screens/inventory_list.dart';
import 'package:expiration_inventory_tracker_app/screens/search_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage(),
    AddPage(),
    InventoryList(),
    SearchPage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.orange,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.withOpacity(0.8),
          selectedFontSize: 0,
          unselectedFontSize: 0,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(
                label: 'Items', icon: Icon(Icons.shopping_cart)),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ]),
    );
  }
}
