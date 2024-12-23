import 'package:flutter/material.dart';

import 'package:money_manage/components/expense/expansion.dart';
import 'package:money_manage/components/page_header.dart';
import 'package:money_manage/components/sticky_btn.dart';


class Expense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.teal[200],
      body: Stack(
        children: [
          // Main Content Area
          Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageHeader(text: 'Expense List'),
                Expanded(
                  child: ListView(
                    children: [
                      ExpenseExpansion(date: 'Jan 3, 2023'),
                      ExpenseExpansion(date: 'Jan 4, 2023'),
                      ExpenseExpansion(date: 'Jan 5, 2023'),
                      ExpenseExpansion(date: 'Jan 6, 2023'),
                      ExpenseExpansion(date: 'Jan 7, 2023'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Sticky Button at the bottom
          StickyBtn(),
        ],
      )
    );
  }
}