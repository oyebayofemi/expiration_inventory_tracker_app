import 'package:flutter/material.dart';

InputDecoration textFormDecoration() {
  return InputDecoration(
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red)),
      filled: true,
      fillColor: Colors.orange[100],
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.transparent)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.transparent)),
      focusColor: Colors.green[100]);
}
