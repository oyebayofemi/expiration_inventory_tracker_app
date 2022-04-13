import 'package:expiration_inventory_tracker_app/screens/register_page.dart';
import 'package:expiration_inventory_tracker_app/shared/form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  String? email, password;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 550,
                    width: 350,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                letterSpacing: 2,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                            onChanged: (value) => this.email = value,
                            //autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => value!.isEmpty
                                ? 'Username/Email Field cant be empty'
                                : null,
                            keyboardType: TextInputType.emailAddress,
                            decoration: textFormDecoration()
                                .copyWith(hintText: 'Username/Email'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                            onChanged: (value) => this.password = value,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            validator: (value) => value!.isEmpty
                                ? 'Password Field cant be empty'
                                : null,
                            keyboardType: TextInputType.text,
                            decoration: textFormDecoration()
                                .copyWith(hintText: 'Password'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(right: 2),
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                    fontSize: 15),
                                //textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ButtonTheme(
                            buttonColor: Colors.orange,
                            minWidth: double.infinity,
                            height: 60,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: RaisedButton(
                              onPressed: () async {
                                // if (formkey.currentState!.validate()) {
                                //   setState(() {
                                //     _loading = true;
                                //   });
                                //   String? texts;
                                //   RegExp regex = RegExp(r'@');
                                //   if (regex.hasMatch(email!)) {
                                //     print(email);
                                //     texts = email;

                                //     try {
                                //       await AuthController().signin(
                                //           context: context,
                                //           email: texts!,
                                //           password: password!);

                                //       setState(() {
                                //         _loading = false;
                                //       });
                                //     } catch (e) {
                                //       print(e);
                                //       setState(() {
                                //         _loading = false;
                                //       });
                                //       // showSnackBar(
                                //       //     context, 'Enter a valid Username');
                                //       showToast(e.toString());
                                //     }
                                //   } else {
                                //     try {
                                //       QuerySnapshot snap = await FirebaseFirestore
                                //           .instance
                                //           .collection("users")
                                //           .where("username", isEqualTo: email)
                                //           .get();
                                //       texts = snap.docs[0]['email'];
                                //       await AuthController().signin(
                                //           context: context,
                                //           email: texts!,
                                //           password: password!);

                                //       setState(() {
                                //         _loading = false;
                                //       });
                                //     } catch (e) {
                                //       print(e);
                                //       setState(() {
                                //         _loading = false;
                                //       });
                                //       // showSnackBar(
                                //       //     context, 'Enter a valid Username');
                                //       showToast('Enter a valid Username');
                                //     }
                                //     print('$texts');
                                //   }
                                // }
                              },
                              child: _loading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: <Widget>[
                            Expanded(
                                child:
                                    Divider(thickness: 1, color: Colors.black)),
                            SizedBox(
                              width: 5,
                            ),
                            Text("OR"),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Divider(
                              color: Colors.black,
                              thickness: 1,
                            )),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonTheme(
                            buttonColor: Colors.white,
                            minWidth: double.infinity,
                            height: 60,
                            shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.orange, width: 2),
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
                                  color: Colors.orange,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 50,
                    ),
                    top: -50,
                  ),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 43,
                      child: Icon(
                        Icons.account_circle_rounded,
                        size: 50,
                        color: Colors.orange,
                      ),
                    ),
                    top: -46,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
