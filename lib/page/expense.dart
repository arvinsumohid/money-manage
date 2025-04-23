import 'package:flutter/material.dart';
import 'package:money_manage/components/expense/tab_bar.dart';
import 'package:money_manage/components/expense/tab_bar_view.dart';
import 'package:money_manage/components/page_header.dart';
import 'package:money_manage/components/sticky_btn.dart';

class Expense extends StatefulWidget {
  @override
  ExpenseState createState() => ExpenseState();
}

class ExpenseState extends State<Expense> {
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
                    child: ExpenseTabBarView(),
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
