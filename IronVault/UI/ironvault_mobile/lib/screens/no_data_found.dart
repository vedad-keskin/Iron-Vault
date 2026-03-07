import 'package:flutter/material.dart';

Widget noDataFound(String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.search_off,
          size: 120,
          color: Colors.grey,
        ),
        SizedBox(height: 20),
        Text(
          message,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
