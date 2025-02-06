import 'package:flutter/material.dart';

class ExpenseListHeader extends StatelessWidget {
  final String type;

  ExpenseListHeader({
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
<<<<<<< Updated upstream
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
=======
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: type == 'daily'
                ? [
                    Expanded(
                      child: Text(
                        'Purpose',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Amount (PHP)',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ]
                : [
                    Expanded(
                      child: Text(
                        'Date',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Purpose',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Amount (PHP)',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ]));
>>>>>>> Stashed changes
  }
}
