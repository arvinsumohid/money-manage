import 'package:flutter/material.dart';
import 'package:money_manage/components/expense/expansion_title.dart';
import 'package:money_manage/components/expense/list.dart';


class ExpenseExpansion extends StatelessWidget {
  final String date;

  ExpenseExpansion({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),  // Margin on all sides
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          title: ExpenseExpansionTitle(date: date),
          backgroundColor: Colors.teal[700],
          collapsedBackgroundColor: Colors.teal[700],
          tilePadding: EdgeInsets.all(10),
          initiallyExpanded: false,
          onExpansionChanged: (bool expanded) {
            print(expanded ? 'Expanded' : 'Collapsed');
          },
          children: [
            ExpenseList(),
          ],
        ), 
      )
    );
  }
}