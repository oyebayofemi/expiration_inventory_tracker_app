import 'package:expiration_inventory_tracker_app/screens/login_page.dart';
import 'package:expiration_inventory_tracker_app/services/auth_controller.dart';
import 'package:expiration_inventory_tracker_app/shared/clear_form_field_decoration.dart';
import 'package:expiration_inventory_tracker_app/shared/form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  String? companyname, fullname, password, phoneNo, email;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Create Your Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50.sp,
                              color: Colors.orange,
                            ),
                          )),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        'Fullname',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                        onChanged: (value) => this.fullname = value,
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value!.isEmpty
                            ? 'Full Name Field cant be empty'
                            : null,
                        keyboardType: TextInputType.text,
                        decoration: cleartextFormDecoration()
                            .copyWith(hintText: 'Full Name'),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Company Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                        onChanged: (value) => this.companyname = value,
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value!.isEmpty
                            ? 'Company Name Field cant be empty'
                            : null,
                        keyboardType: TextInputType.text,
                        decoration: cleartextFormDecoration()
                            .copyWith(hintText: 'Company Name'),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
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
                        decoration: cleartextFormDecoration()
                            .copyWith(hintText: 'Email'),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        onChanged: (value) => this.phoneNo = value,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        validator: (value) => value!.isEmpty
                            ? 'Phone Number Field cant be empty'
                            : null,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: cleartextFormDecoration()
                            .copyWith(hintText: 'Phone Number'),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        onChanged: (value) => this.password = value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        validator: (value) => value!.isEmpty
                            ? 'Password Field cant be empty'
                            : null,
                        keyboardType: TextInputType.text,
                        decoration: cleartextFormDecoration()
                            .copyWith(hintText: 'Password'),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      ButtonTheme(
                        buttonColor: Colors.orange,
                        minWidth: double.infinity,
                        height: 100.h,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r)),
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                _loading = true;
                              });
                              try {
                                await AuthControllerService().signUp(
                                    email: email!,
                                    password: password!,
                                    companyname: companyname!,
                                    fullname: fullname!,
                                    phoneNo: phoneNo!,
                                    context: context);

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
                                  'Sign Up',
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
                            child: Divider(thickness: 1, color: Colors.black)),
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
                        height: 20.h,
                      ),
                      ButtonTheme(
                        buttonColor: Colors.white,
                        minWidth: double.infinity,
                        height: 100.h,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.orange, width: 2),
                            borderRadius: BorderRadius.circular(5.r)),
                        child: FlatButton(
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
          ),
        ),
      ),
    );
  }
}
