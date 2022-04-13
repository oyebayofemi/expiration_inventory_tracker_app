import 'package:expiration_inventory_tracker_app/screens/login_page.dart';
import 'package:expiration_inventory_tracker_app/screens/register_page.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage("assets/Studio_Project.png"),
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiration',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'Inventory',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'Tracker',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'This application helps you manage your inventory and the expiring date of each items, by tracking the expirng date and send the notification when its about to expire',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonTheme(
                      buttonColor: Colors.white,
                      minWidth: double.infinity,
                      height: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: FlatButton(
                        color: Colors.white,
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.orange,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ButtonTheme(
                      buttonColor: Colors.orange,
                      minWidth: double.infinity,
                      height: 60,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: FlatButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
