import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiration_inventory_tracker_app/model/user_model.dart';
import 'package:expiration_inventory_tracker_app/shared/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthControllerService extends ChangeNotifier {
  UserDataModel? user;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> authChanges() => _auth.authStateChanges();

  Future signUp(
      {required String email,
      required String password,
      required String companyname,
      required String fullname,
      required String phoneNo,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      user = UserDataModel(
          companyname: companyname,
          email: email,
          fullname: fullname,
          phoneNo: phoneNo);

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set(user!.toJson());

      if (userCredential.user != null) {
        return userCredential.user!;
      }
      showToast('Registration Successful');
      notifyListeners();
      Navigator.popUntil(context, (route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        //showSnackBar(context, "The password provided is too weak.");
        showToast("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        // showSnackBar(context, "An account already exists for that email.");
        showToast("An account already exists for that email.");
      } else if (e.code == 'invalid-email') {
        print('Invalid email.');
        //showSnackBar(context, "Invalid email.");
        showToast("Invalid email.");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      showToast('Login Successful');

      notifyListeners();
      Navigator.popUntil(context, (route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        // showSnackBar(context, "No user found for that email.");
        showToast("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        // showSnackBar(context, "Wrong password provided for that user.");
        showToast("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        print('Invalid email.');
        // showSnackBar(context, "Invalid email.");
        showToast("Invalid email.");
      } else if (e.code == 'user-disabled') {
        print('This user has been disabled.');
        // showSnackBar(context, "This user has been disabled");
        showToast("This user has been disabled");
      } else if (e.code == 'too-many-requests') {
        print('Too Many requests.');
        // showSnackBar(context, "Too Many requests");
        showToast("Too Many requests");
      } else if (e.code == 'operation-not-allowed') {
        print('This operation isnt allowed.');
        //showSnackBar(context, "This operation isnt allowed");
        showToast("This operation isnt allowed");
      }
      notifyListeners();
    }
  }

  Future signout() async {
    await FirebaseAuth.instance.signOut();
    // nbvawait GoogleSignIn.signOut();
    user = null;
    notifyListeners();
  }
}
