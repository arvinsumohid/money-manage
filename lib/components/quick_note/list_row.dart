import 'package:flutter/material.dart';

class QuickNoteListRow extends StatelessWidget {
  final String purpose;
  final double amount;

  const QuickNoteListRow({required this.purpose, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        children: [
          Text(
            purpose,
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontSize: 25,
            ),
          ),
          Spacer(),
          Text(
            amount.toString(),
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontSize: 25,
            ),
          ),
        ],
      )
    );
  }
}