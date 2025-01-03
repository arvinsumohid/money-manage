import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String text;
  const PageHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    );
  }
}
