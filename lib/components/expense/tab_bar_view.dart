import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manage/components/expense/expansion.dart';

class ExpenseTabBarView extends StatefulWidget {
  final Box _expenseList;
  final Function(int) onDelete;
  final Function(List<int>) onDeleteList;

  ExpenseTabBarView(this._expenseList, this.onDelete, this.onDeleteList);

  @override
  _ExpenseTabBarViewState createState() => _ExpenseTabBarViewState();
}

class _ExpenseTabBarViewState extends State<ExpenseTabBarView> {
  late List<dynamic> expenseList;
  late Map<String, List<Map<String, dynamic>>> expenseMap;
  late Map<String, List<Map<String, dynamic>>> expenseMapMonthly;
  late Map<String, double> totalAmountPerDate;
  late Map<String, double> totalAmountPerMonth;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Initialize the expense data
  void _initializeData() {
    expenseList = widget._expenseList.values.toList();
    expenseMap = {};
    expenseMapMonthly = {};
    totalAmountPerDate = {};
    totalAmountPerMonth = {};

    _processExpenseData();
  }

  // Function to process daily expenses
  void dailyExpenseList(int index, List expense, String date) {
    if (expenseMap[date] == null) {
      expenseMap[date] = [];
      totalAmountPerDate[date] = 0.0;
    }

    totalAmountPerDate[date] = totalAmountPerDate[date]! + expense[2];

    expenseMap[date]!.add({
      'index': index,
      'date': expense[0],
      'purpose': expense[1],
      'amount': expense[2],
    });
  }

  // Function to process monthly expenses
  void monthlyExpenseList(int index, List expense, String date) {
    final month = expense[0].split(' ')[0]; // Get only the month (e.g., 'Feb')
    if (expenseMapMonthly[month] == null) {
      expenseMapMonthly[month] = [];
      totalAmountPerMonth[month] = 0.0;
    }

    totalAmountPerMonth[month] = totalAmountPerMonth[month]! + expense[2];

    expenseMapMonthly[month]!.add({
      'index': index,
      'month': DateFormat('MMMM')
          .format(DateFormat("MMM d, yyyy").parse(expense[0])),
      'date': expense[0],
      'purpose': expense[1],
      'amount': expense[2],
    });
  }

  // Function to process the expense data
  void _processExpenseData() {
    expenseList.asMap().forEach((index, expense) {
      final date = DateFormat("MMM d, yyyy")
          .parse(expense[0].toString())
          .millisecondsSinceEpoch
          .toString();

      // Add expense to daily map
      dailyExpenseList(index, expense, date);

      // Add expense to monthly map
      monthlyExpenseList(index, expense, date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget._expenseList.listenable(),
      builder: (context, Box expenseBox, _) {
        // Update expenseList whenever Hive data changes
        expenseList = expenseBox.values.toList();
        _initializeData(); // Reprocess the data whenever it changes

        // Sort the daily expense map by date
        var sortedKeys = expenseMap.keys.toList()
          ..sort((a, b) => a.compareTo(b));
        Map<String, List<Map<String, dynamic>>> sortedExpenseMap = {
          for (var key in sortedKeys) key: expenseMap[key]!
        };

        // Sort the monthly expense map by month
        var sortedMonthKeys = expenseMapMonthly.keys.toList()
          ..sort((a, b) => a.compareTo(b));
        Map<String, List<Map<String, dynamic>>> sortedExpenseMapMonthly = {
          for (var key in sortedMonthKeys) key: expenseMapMonthly[key]!
        };

        return TabBarView(
          children: [
            _buildDailyExpenseList(sortedExpenseMap, totalAmountPerDate),
            _buildMonthlyExpenseList(
                sortedExpenseMapMonthly, totalAmountPerMonth),
          ],
        );
      },
    );
  }

  /// Daily Expense List View
  Widget _buildDailyExpenseList(
      Map<String, List<Map<String, dynamic>>> sortedExpenseMap,
      Map<String, double> totalAmountPerDate) {
    return sortedExpenseMap.isEmpty
        ? Center(
            child: Text(
              'No Data Found',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]),
            ),
          )
        : ListView(
            children: sortedExpenseMap.entries.map((entry) {
              return ExpenseExpansion(
                type: 'daily',
                date: entry.value[0]['date'],
                expenseList: entry.value,
                totalAmount: totalAmountPerDate[entry.key]!,
                onDelete: widget.onDelete,
                onDeleteList: ([list]) {
                  widget.onDeleteList(list);
                },
              );
            }).toList(),
          );
  }

  /// Monthly Expense List View
  Widget _buildMonthlyExpenseList(
      Map<String, List<Map<String, dynamic>>> sortedExpenseMapMonthly,
      Map<String, double> totalAmountPerMonth) {
    return sortedExpenseMapMonthly.isEmpty
        ? Center(
            child: Text(
              'No Monthly Data Found',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]),
            ),
          )
        : ListView(
            children: sortedExpenseMapMonthly.entries.map((entry) {
              return ExpenseExpansion(
                type: 'monthly',
                date: entry.value[0]['month'],
                expenseList: entry.value,
                totalAmount: totalAmountPerMonth[entry.key]!,
                onDelete: widget.onDelete,
                onDeleteList: ([list]) {
                  widget.onDeleteList(list);
                },
              );
            }).toList(),
          );
  }
}
