import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manage/components/expense/expansion.dart';
import 'package:money_manage/components/page_header.dart';
import 'package:money_manage/components/sticky_btn.dart';

class Expense extends StatefulWidget {
  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final _expenseList = Hive.box('expenseList');

  void _handleDelete(int index) {
    setState(() {
      _expenseList.deleteAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = screenWidth * 0.05;
    List<dynamic> expenseList = _expenseList.values.toList();
    Map<String, List<Map<String, dynamic>>> expenseMap = {};

    expenseList.asMap().forEach((index, expense) {
      final date = expense[0].toString();
      if (expenseMap[date] == null) {
        expenseMap[date] = [];
      }
      expenseMap[date]!.add({
        'index': index,
        'date': expense[0],
        'purpose': expense[1],
        'amount': expense[2],
      });
    });

    var sortedKeys = expenseMap.keys.toList()..sort((a, b) => a.compareTo(b));

    Map<String, List<Map<String, dynamic>>> sortedExpenseMap = {};
    for (var key in sortedKeys) {
      sortedExpenseMap[key] = expenseMap[key]!;
    }

    return Scaffold(
      backgroundColor: Colors.teal[200],
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageHeader(text: 'Expense List'),
                Expanded(
                  child: expenseMap.isEmpty
                      ? Center(
                          child: Text(
                            'No Data Found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        )
                      : ListView(
                          children: sortedExpenseMap.entries.map((entry) {
                            return ExpenseExpansion(
                              date: entry.key,
                              expenseList: entry.value,
                              onDelete: _handleDelete,
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
          ),
          StickyBtn(),
        ],
      ),
    );
  }
}
