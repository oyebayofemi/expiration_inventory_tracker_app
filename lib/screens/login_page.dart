import 'package:expiration_inventory_tracker_app/screens/register_page.dart';
import 'package:expiration_inventory_tracker_app/services/auth_controller.dart';
import 'package:expiration_inventory_tracker_app/shared/form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        body: Form(
          key: formkey,
          child: Center(
            child: SingleChildScrollView(
              child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 1300.h,
                      width: double.maxFinite,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70.h,
                            ),
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 2,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 45.sp),
                            ),
                            SizedBox(
                              height: 60.h,
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
                              height: 20.h,
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
                              height: 5.h,
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
                                      fontSize: 35.sp),
                                  //textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            ButtonTheme(
                              buttonColor: Colors.orange,
                              minWidth: double.infinity,
                              height: 100.h,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: RaisedButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    setState(() {
                                      _loading = true;
                                    });
                                    try {
                                      await AuthControllerService().signin(
                                          context: context,
                                          email: email!,
                                          password: password!);
                                      setState(() {
                                        _loading = false;
                                      });
                                    } catch (e) {
                                      setState(() {
                                        _loading = false;
                                      });
                                      print(e.toString());
                                    }
                                  }
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
                                          fontSize: 35.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                  child: Divider(
                                      thickness: 1, color: Colors.black)),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text("OR"),
                              SizedBox(
                                width: 5.w,
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.black,
                                thickness: 1,
                              )),
                            ]),
                            SizedBox(
                              height: 10.h,
                            ),
                            ButtonTheme(
                              buttonColor: Colors.white,
                              minWidth: double.infinity,
                              height: 100.h,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.orange, width: 2.w),
                                  borderRadius: BorderRadius.circular(15.r)),
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
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 100.r,
                    ),
                    top: -40.h,
                  ),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70.r,
                      child: Icon(
                        Icons.account_circle_rounded,
                        size: 50.sp,
                        color: Colors.orange,
                      ),
                    ),
                    top: -16.h,
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
