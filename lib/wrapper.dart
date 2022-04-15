import 'package:expiration_inventory_tracker_app/screens/home_page.dart';
import 'package:expiration_inventory_tracker_app/screens/login_page.dart';
import 'package:expiration_inventory_tracker_app/screens/main_page.dart';
import 'package:expiration_inventory_tracker_app/screens/welcome.dart';
import 'package:expiration_inventory_tracker_app/services/auth_controller.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthControllerService().authChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainPage();
        } else {
          return Welcome();
        }
      },
    );
  }
}
