import 'package:flutter/material.dart';
import 'package:money_manage/components/expense/expansion_title.dart';
import 'package:money_manage/components/expense/list.dart';

class ExpenseExpansion extends StatefulWidget {
  final String date;
  final List<Map<String, dynamic>> expenseList;
  final Function(int) onDelete;
  final double totalAmount;
  final Function onDeleteList;

  ExpenseExpansion({
    required this.date,
    required this.expenseList,
    required this.onDelete,
    required this.totalAmount,
    required this.onDeleteList,
  });

  @override
  _ExpenseExpansionState createState() => _ExpenseExpansionState();
}

class _ExpenseExpansionState extends State<ExpenseExpansion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ExpansionTile(
          title: GestureDetector(
            onLongPress: () {
              _showDeleteOptionsDialog(context);
            },
            behavior: HitTestBehavior.translucent,
            child: ExpenseExpansionTitle(
              date: widget.date,
              totalAmount: widget.totalAmount,
            ),
          ),
          backgroundColor: Colors.teal[700],
          collapsedBackgroundColor: Colors.teal[900],
          tilePadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
          initiallyExpanded: _isExpanded,
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: [
            ExpenseList(
              expenseList: widget.expenseList,
              onDelete: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteOptionsDialog(BuildContext context) {
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
              Text('Delete Expenses'),
            ],
          ),
          content: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Would you like to delete all expenses for ',
                  style:
                      DefaultTextStyle.of(context).style, // Default text style
                ),
                TextSpan(
                  text: widget.date, // Highlight the purpose
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Highlighted style
                    color: Colors.red, // Highlight color
                  ),
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
                List<int> expenseListIndex = [];
                // Handle the delete action
                Navigator.pop(context);
                for (int i = 0; i < widget.expenseList.length; i++) {
                  expenseListIndex.add(widget.expenseList[i]['index']);
                }

                widget.onDeleteList(expenseListIndex);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
