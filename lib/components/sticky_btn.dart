import 'package:flutter/material.dart';
import 'package:money_manage/components/expense/expense_popup_form.dart';

class StickyBtn extends StatelessWidget {

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
              return ExpensePopupForm();
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
