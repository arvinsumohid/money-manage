import 'package:flutter/material.dart';
import 'package:money_manage/components/expense/expense_popup_form.dart';

class ExpenseListRow extends StatelessWidget {
  final String type;
  final int index;
  final String date;
  final String purpose;
  final double amount;
  final String category;
  final Function(int) onDelete;

  ExpenseListRow({
    required this.type,
    required this.index,
    required this.date,
    required this.purpose,
    required this.amount,
    required this.category,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: InkWell(
            onLongPress: () {
              _showOptionsDialog(context);
            },
            onTap: () => {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return ExpensePopupForm(
                        updateData: {
                          'date': date,
                          'purpose': purpose,
                          'category': category,
                          'amount': amount.toString(),
                          'index': index.toString()
                        },
                      );
                    },
                  )
                },
            child: Row(
              children: type == 'daily'
                  ? [
                      Text(
                        purpose,
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        amount.toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                    ]
                  : [
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        purpose,
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Spacer(),
                      Text(
                        amount.toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                    ],
            )));
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red, // Warning icon in red
              ),
              SizedBox(width: 8), // Spacing between icon and text
              Text('Delete Expense'),
            ],
          ),
          content: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Would you like to delete ',
                  style:
                      DefaultTextStyle.of(context).style, // Default text style
                ),
                TextSpan(
                  text: purpose, // Highlight the purpose
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Highlighted style
                    color: Colors.red, // Highlight color
                  ),
                ),
                TextSpan(
                  text: ' from this expenses?',
                  style:
                      DefaultTextStyle.of(context).style, // Default text style
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle the edit action
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle the delete action
                Navigator.pop(context);
                onDelete(index);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
