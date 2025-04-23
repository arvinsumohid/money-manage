import 'package:flutter/material.dart';
import 'package:money_manage/components/expense/expansion_title.dart';
import 'package:money_manage/components/expense/list.dart';
import 'package:money_manage/expenseList/expense.list.service.dart';

class ExpenseExpansion extends StatefulWidget {
  final String date;
  final String type;
  final List<Map<String, dynamic>> expenseList;
  final double totalAmount;
  final Map<String, dynamic> categoryExpenses;

  ExpenseExpansion({
    required this.type,
    required this.date,
    required this.expenseList,
    required this.totalAmount,
    required this.categoryExpenses,
  });

  @override
  ExpenseExpansionState createState() => ExpenseExpansionState();
}

class ExpenseExpansionState extends State<ExpenseExpansion> {
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
            if (widget.type == 'monthly')
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[50],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category Expenses',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    // loop the categoryExpenses map and build each category item
                    ...widget.categoryExpenses.entries.map((entry) {
                      String category = entry.key;
                      double amount = entry.value;
                      return _buildCategoryItem(category, amount);
                    }),
                  ],
                ),
              ),
            ExpenseList(
              type: widget.type,
              expenseList: widget.expenseList,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String category, double amount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // 👈 Ensures spacing between text
        children: [
          Text(
            category, // Category Name
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            '${amount.toStringAsFixed(0)} PHP', // Amount
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
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

                ExpenseListService.deleteExpenses(expenseListIndex);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
