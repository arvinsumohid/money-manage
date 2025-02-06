import 'package:flutter/material.dart';

/// ✅ Separated `TabBar` into its own widget
class ExpenseTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.teal[900],
      labelColor: Colors.teal[900],
      unselectedLabelColor: Colors.grey,
      tabs: [
        Tab(icon: Icon(Icons.calendar_today), text: "Daily"),
        Tab(icon: Icon(Icons.calendar_month), text: "Monthly"),
      ],
    );
  }
}
