import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String? companyname;
  final String? fullname;
  final String? phoneNo;
  final String? email;

  UserDataModel({this.companyname, this.email, this.fullname, this.phoneNo});

  Map<String, dynamic> toJson() => {
        'companyname': companyname,
        'email': email,
        'fullname': fullname,
        'phoneNo': phoneNo
      };

  static UserDataModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserDataModel(
      companyname: snapshot["companyname"],
      email: snapshot["email"],
      fullname: snapshot["fullname"],
      phoneNo: snapshot["phoneNo"],
    );
  }
}
