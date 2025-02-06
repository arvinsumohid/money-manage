import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manage/components/expense/tab_bar.dart';
import 'package:money_manage/components/expense/tab_bar_view.dart';
import 'package:money_manage/components/page_header.dart';
import 'package:money_manage/components/sticky_btn.dart';

class Expense extends StatefulWidget {
  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final _expenseList = Hive.box('expenseList');

  void _handleDelete(int index) {
    _expenseList
        .deleteAt(index); // No need for setState(), Hive updates automatically
  }

  void _handleDeleteList(List<int> list) {
    for (var v in list.reversed.toList()) {
      _handleDelete(v);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PageHeader(text: 'EXPENSE LIST'),
                  ExpenseTabBar(),
                  Expanded(
                    child: ExpenseTabBarView(
                        _expenseList, _handleDelete, _handleDeleteList),
                  ),
                ],
              ),
            ),
            StickyBtn(),
          ],
        ),
      ),
    );
  }
}
