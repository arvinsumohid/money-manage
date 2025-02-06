import 'package:flutter/material.dart';
import 'package:money_manage/components/expense/list_header.dart';
import 'package:money_manage/components/expense/list_row.dart';

class ExpenseList extends StatefulWidget {
  final String type;
  final List<Map<String, dynamic>> expenseList;
  final Function(int) onDelete;

<<<<<<< Updated upstream
  ExpenseList({required this.expenseList, required this.onDelete});
=======
  ExpenseList({
    required this.type,
    required this.expenseList,
    required this.onDelete,
  });
>>>>>>> Stashed changes

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  double calculateTotalAmount() {
    return widget.expenseList.fold(
        0.0,
        (sum, expense) =>
            sum + (double.tryParse(expense['amount'].toString()) ?? 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreen[50],
        child: Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              ExpenseListHeader(type: widget.type),
              ...widget.expenseList.map((expense) => ExpenseListRow(
                    type: widget.type,
                    index: expense['index'],
                    date: expense['date'],
                    purpose: expense['purpose'],
                    amount: expense['amount'],
                    onDelete: (index) {
                      widget.onDelete(index);
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  color: Colors.black,
                  thickness: 1.0,
                  height: 1.0,
                ),
              ),
              ExpenseListTotalAmount(
                  totalAmount: calculateTotalAmount().toString())
            ])));
  }
}
