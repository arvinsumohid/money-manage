import 'package:flutter/material.dart';
import 'package:money_manage/components/expense/list_header.dart';
import 'package:money_manage/components/expense/list_row.dart';

class ExpenseList extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen[50],
      child: Padding(
        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ExpenseListHeader(),
            ExpenseListRow(purpose: 'Paniudto', amount: 2500.00),
            ExpenseListRow(purpose: 'Pamahaw', amount: 2300.00)
        ])
      )
    );
  }
}