import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseListService {
  static const String boxName = 'expenseList';

  static Box _getBox() => Hive.box(boxName);

  static Future<void> addExpense(Map<String, dynamic> expense) async {
    await _getBox().add(expense);
  }

  static Future<List<Map<String, dynamic>>> getExpenses() async {
    final List<dynamic> expenses = await _getBox().values.toList();
    return expenses.map((expense) => Map<String, dynamic>.from(expense)).toList();
  }
  static Future<void> updateExpense(int index, Map<String, dynamic> expense) async {
    await _getBox().putAt(index, expense);
  }

  static Future<void> deleteExpense(int index) async {
    await _getBox().deleteAt(index);
  }

  static Future<void> deleteExpenses(List<int> list) async {
    for (var index in list.reversed.toList()) {
      await _getBox().deleteAt(index);
    }
  }

  static ValueListenable<Box> listenable() => _getBox().listenable();
}