import 'package:flutter/material.dart';

class ExpenseListTotalAmount extends StatelessWidget {
  final String totalAmount;

  const ExpenseListTotalAmount({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Total Amount: ',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontSize: 25,
          ),
        ),
        Spacer(),
        Text(
          totalAmount,
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
