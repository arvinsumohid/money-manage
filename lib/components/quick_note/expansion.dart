import 'package:flutter/material.dart';
import 'expansion_title.dart';
import 'list.dart';


class QuickNoteExpansion extends StatelessWidget {
  final String date;

  QuickNoteExpansion({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),  // Margin on all sides
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          title: QuickNoteExpansionTitle(date: date),
          backgroundColor: Colors.teal[700],
          collapsedBackgroundColor: Colors.teal[700],
          tilePadding: EdgeInsets.all(10),
          initiallyExpanded: false,
          onExpansionChanged: (bool expanded) {
            print(expanded ? 'Expanded' : 'Collapsed');
          },
          children: [
            QuickNoteList(),
          ],
        ), 
      )
    );
  }
}