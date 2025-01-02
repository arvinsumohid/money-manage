import 'package:flutter/material.dart';

class ExpenseListHeader extends StatelessWidget {
  const ExpenseListHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Text(
              'Purpose',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Text(
              'Amount',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.right,
            ),
          ),
        ]));
  }
}
