import 'package:flutter/material.dart';
import 'package:money_manage/components/expense/expansion_title.dart';
import 'package:money_manage/components/expense/list.dart';

class ExpenseExpansion extends StatefulWidget {
  final String date;
  final String type;
  final List<Map<String, dynamic>> expenseList;
  final Function(int) onDelete;

  ExpenseExpansion({
    required this.type,
    required this.date,
    required this.expenseList,
    required this.onDelete,
  });

  @override
  _ExpenseExpansionState createState() => _ExpenseExpansionState();
}

class _ExpenseExpansionState extends State<ExpenseExpansion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ExpansionTile(
          title: ExpenseExpansionTitle(date: widget.date),
          backgroundColor: Colors.teal[700],
          collapsedBackgroundColor: Colors.teal[700],
          tilePadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
          initiallyExpanded: _isExpanded,
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: [
            ExpenseList(
              type: widget.type,
              expenseList: widget.expenseList,
              onDelete: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
