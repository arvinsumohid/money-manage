import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String text;
  const PageHeader({ required this.text });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),  // Padding to move text down
      child: Text(
        'Quick Note',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 45,
        ),
      ),
    );
  }
}