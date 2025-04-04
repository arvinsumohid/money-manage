import 'package:flutter/material.dart';
import 'package:money_manage/components/expense/expense_popup_form.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StickyBtn extends StatelessWidget {
  final _expenseList = Hive.box('expenseList');

  void writeData(String date, String purpose, double amount, String category,
      [int? index]) {
    _expenseList.add([date, purpose, amount, category]);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20, // Distance from the bottom
      left: MediaQuery.of(context).size.width / 2 - 50, // Center horizontally
      child: ElevatedButton(
        // onLongPress: () => {
        //   _expenseList.clear(),
        // },
        onPressed: () => {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return ExpensePopupForm(submitFunc: writeData);
            },
          )
        },
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.teal[700]),
        child: Icon(
          Icons.add,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
