import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensePopupForm extends StatefulWidget {
  final void Function(String, String, double, [int?]) submitFunc;
  final Map<String, dynamic> updateData;

  ExpensePopupForm({required this.submitFunc, this.updateData = const {}});

  @override
  ExpensePopupFormState createState() => ExpensePopupFormState();
}

class ExpensePopupFormState extends State<ExpensePopupForm> {
  final purposeController = TextEditingController();
  final amountController = TextEditingController();
  int hiveIndex = 0;
  bool isUpdate = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.updateData.isNotEmpty) {
      selectedDate =
          DateFormat('MMM d, yyyy').parse(widget.updateData['date'] ?? '');
      purposeController.text = widget.updateData['purpose'] ?? '';
      amountController.text = widget.updateData['amount'] ?? '';
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
          onPressed: () {
            final String purpose = purposeController.text;
            final String amountText = amountController.text;

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
            widget.submitFunc(DateFormat('MMM d, yyyy').format(selectedDate),
                purpose, amount, hiveIndex);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
