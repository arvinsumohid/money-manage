import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manage/components/expense/expansion.dart';
import 'package:money_manage/expenseList/expense.list.service.dart';

class ExpenseTabBarView extends StatefulWidget {

  ExpenseTabBarView();

  @override
  ExpenseTabBarViewState createState() => ExpenseTabBarViewState();
}

class ExpenseTabBarViewState extends State<ExpenseTabBarView> {
  static List<String> defaultCategory = [
    'Uncategorized',
    'Bills',
    'Wants',
    'Investments',
    'Tithe'
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ExpenseListService.listenable(),
      builder: (context, Box expenseBox, _) {
        final expenseList = expenseBox.values.toList();
        // Process all maps locally
        final Map<String, List<Map<String, dynamic>>> expenseMap = {};
        final Map<String, List<Map<String, dynamic>>> expenseMapMonthly = {};
        final Map<String, double> totalAmountPerDate = {};
        final Map<String, double> totalAmountPerMonth = {};
        final Map<String, Map<String, double>> categoryExpenses = {};

        for (var i = 0; i < expenseList.length; i++) {
          final expense = expenseList[i];
          if (expense == null || expense is! Map || expense['date'] == null || expense['date'].toString().trim().isEmpty) {
            continue;
          }
          final dateStr = expense['date'].toString();
          DateTime? parsedDate;
          try {
            parsedDate = DateFormat("MMM d, yyyy").parse(dateStr);
          } catch (e) {
            continue;
          }
          final dateKey = parsedDate.millisecondsSinceEpoch.toString();
          // Daily
          if (expenseMap[dateKey] == null) {
            expenseMap[dateKey] = [];
            totalAmountPerDate[dateKey] = 0.0;
          }
          totalAmountPerDate[dateKey] = totalAmountPerDate[dateKey]! + (expense['amount'] ?? 0.0);
          expenseMap[dateKey]!.add({
            'index': i,
            'date': expense['date'],
            'purpose': expense['purpose'],
            'amount': expense['amount'],
            'category': expense['category'] ?? 'Uncategorized',
          });
          // Monthly
          String monthKey = 'Unknown';
          String monthFull = 'Unknown';
          try {
            monthKey = DateFormat('MMM d, yyyy').parse(dateStr).month.toString();
            monthKey = dateStr.split(' ')[0];
            monthFull = DateFormat('MMMM').format(DateFormat("MMM d, yyyy").parse(dateStr));
          } catch (e) {
            // fallback
          }
          if (expenseMapMonthly[monthKey] == null) {
            expenseMapMonthly[monthKey] = [];
            totalAmountPerMonth[monthKey] = 0.0;
          }
          totalAmountPerMonth[monthKey] = totalAmountPerMonth[monthKey]! + (expense['amount'] ?? 0.0);
          expenseMapMonthly[monthKey]!.add({
            'index': i,
            'month': monthFull,
            'date': expense['date'],
            'purpose': expense['purpose'],
            'amount': expense['amount'],
            'category': expense['category'] ?? 'Uncategorized',
          });
          // Category
          final category = expense['category'] ?? 'Uncategorized';
          if (categoryExpenses[monthKey] == null) {
            categoryExpenses[monthKey] = {
              'Uncategorized': 0.0,
              'Bills': 0.0,
              'Wants': 0.0,
              'Investments': 0.0,
              'Tithe': 0.0,
              'Allowance': 0.0,
            };
          }
          categoryExpenses[monthKey]![category] =
              (categoryExpenses[monthKey]![category] ?? 0.0) + (expense['amount'] ?? 0.0);
        }

        // Sort the daily expense map by date
        var sortedKeys = expenseMap.keys.toList()..sort((a, b) => a.compareTo(b));
        Map<String, List<Map<String, dynamic>>> sortedExpenseMap = {
          for (var key in sortedKeys) key: expenseMap[key]!
        };
        // Sort the monthly expense map by month
        var sortedMonthKeys = expenseMapMonthly.keys.toList()..sort((a, b) => a.compareTo(b));
        Map<String, List<Map<String, dynamic>>> sortedExpenseMapMonthly = {
          for (var key in sortedMonthKeys) key: expenseMapMonthly[key]!
        };

        return TabBarView(
          children: [
            _buildDailyExpenseList(sortedExpenseMap, totalAmountPerDate, categoryExpenses),
            _buildMonthlyExpenseList(sortedExpenseMapMonthly, totalAmountPerMonth, categoryExpenses),
          ],
        );
      },
    );
  }

  Widget _buildDailyExpenseList(
    Map<String, List<Map<String, dynamic>>> sortedExpenseMap,
    Map<String, double> totalAmountPerDate,
    Map<String, Map<String, double>> categoryExpenses,
  ) {
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
                categoryExpenses: categoryExpenses[entry.key] ?? {},
              );
            }).toList(),
          );
  }

  Widget _buildMonthlyExpenseList(
    Map<String, List<Map<String, dynamic>>> sortedExpenseMapMonthly,
    Map<String, double> totalAmountPerMonth,
    Map<String, Map<String, double>> categoryExpenses,
  ) {
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
            children: sortedExpenseMapMonthly.entries.toList().map((entry) {
              return ExpenseExpansion(
                type: 'monthly',
                date: entry.value[0]['month'],
                expenseList: entry.value,
                totalAmount: totalAmountPerMonth[entry.key]!,
                categoryExpenses: categoryExpenses[entry.key] ?? {},
              );
            }).toList(),
          );
  }
}
