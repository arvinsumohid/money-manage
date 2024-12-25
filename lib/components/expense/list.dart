import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manage/components/expense/list_header.dart';
import 'package:money_manage/components/expense/list_row.dart';

class ExpenseList extends StatelessWidget {
  final List<Map<String, dynamic>> expenseList;
  final Function(int) onDelete;

  ExpenseList({required this.expenseList, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreen[50],
        child: Padding(
            padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              ExpenseListHeader(),
              ...expenseList.map((expense) => ExpenseListRow(
                    index: expense['index'],
                    date: expense['date'],
                    purpose: expense['purpose'],
                    amount: expense['amount'],
                    onDelete: (index) {
                      onDelete(index);
                    },
                  )),
            ])));
  }
}
