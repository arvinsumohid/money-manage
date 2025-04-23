import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../expenseList/expense.list.service.dart';

class ExpensePopupForm extends StatefulWidget {
  final Map<String, dynamic> updateData;

  ExpensePopupForm({this.updateData = const {}});

  @override
  ExpensePopupFormState createState() => ExpensePopupFormState();
}

class ExpensePopupFormState extends State<ExpensePopupForm> {
  final purposeController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  int hiveIndex = 0;
  bool isUpdate = false;
  DateTime selectedDate = DateTime.now();
  static List<String> category = [
    'Uncategorized',
    'Bills',
    'Wants',
    'Investments',
    'Tithe',
    'Allowance',
  ];
  String dropdownValue = category.first;

  final List<DropdownMenuEntry<String>> dropdownMenuEntries;

  ExpensePopupFormState()
      : dropdownMenuEntries = category
            .map<DropdownMenuEntry<String>>(
                (String name) => DropdownMenuEntry(value: name, label: name))
            .toList();

  @override
  void initState() {
    super.initState();

    if (widget.updateData.isNotEmpty) {
      selectedDate =
          DateFormat('MMM d, yyyy').parse(widget.updateData['date'] ?? '');
      purposeController.text = widget.updateData['purpose'] ?? '';
      amountController.text = widget.updateData['amount'] ?? '';
      categoryController.text = widget.updateData['category'] ?? '';
      isUpdate = true;
      hiveIndex = int.parse(widget.updateData['index']) ?? 0;
    }
  }

  // Function to display the date picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(selectedDate.year - 100),
          lastDate: DateTime(selectedDate.year + 100),
        ) ??
        selectedDate;

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Update the selected date and rebuild UI
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightGreen[50],
      title: Text('Add Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            constraints:
                BoxConstraints(minWidth: double.infinity), // Force full width
            child: DropdownMenu<String>(
              controller: categoryController,
              initialSelection: categoryController.text != ''
                  ? categoryController.text
                  : category.first,
              onSelected: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              dropdownMenuEntries: dropdownMenuEntries,
            ),
          ),
          SizedBox(height: 16),
          TextField(
            readOnly: true,
            controller: TextEditingController(
              text: DateFormat('MMM d, yyyy').format(selectedDate),
            ),
            decoration: InputDecoration(
              labelText: 'Select Date',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => selectDate(context), // Show the date picker
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: purposeController,
            maxLength: 20,
            decoration: InputDecoration(
              labelText: 'Enter Purpose',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: amountController,
            maxLength: 20,
            decoration: InputDecoration(
              labelText: 'Enter Amount',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.red[400]),
          ),
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          child: Text('Save'),
          onPressed: () async {
            final String purpose = purposeController.text;
            final String amountText = amountController.text;
            final String selectedCategory = categoryController.text;

            if (purpose.isEmpty || amountText.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill in both fields')),
              );
              return;
            }

            final double amount = double.tryParse(amountText) ?? 0.0;

            if (amount <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a valid amount')),
              );
              return;
            }

            await ExpenseListService.addExpense({
              'date': DateFormat('MMM d, yyyy').format(selectedDate),
              'purpose': purpose,
              'amount': amount,
              'category': selectedCategory,
              'index': hiveIndex
            });

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
