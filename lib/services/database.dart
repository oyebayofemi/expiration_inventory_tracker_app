import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiration_inventory_tracker_app/shared/toast.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  String userID;
  DatabaseService({required this.userID});
  var itemcollections = FirebaseFirestore.instance.collection('items');

  addItems(String dateValue, String name, String selectedQuantityType,
      String selectedCategory, int quantity, DateTime date) async {
    try {
      await itemcollections.doc(userID).collection('items').add({
        'userID': userID,
        'name': name,
        'quantityType': selectedQuantityType,
        'quantity': quantity,
        'category': selectedCategory,
        'expiryDate': dateValue,
        'date': date,
      });
      showToast('Item added Successful');
    } catch (e) {
      showToast('Failed to add item');
    }
  }
}
