import 'package:flutter/material.dart';

class ExpenseExpansionTitle extends StatelessWidget {
  final String date;
  final double totalAmount;

  ExpenseExpansionTitle({
    required this.date,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            date,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            'PHP ${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ]));
  }
}
