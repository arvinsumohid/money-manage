import 'package:flutter/material.dart';
import 'package:money_manage/components/quick_note/list_header.dart';
import 'package:money_manage/components/quick_note/list_row.dart';

class QuickNoteList extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen[50],
      child: Padding(
        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            QuickNoteListHeader(),
            QuickNoteListRow(purpose: 'Paniudto', amount: 2500.00),
            QuickNoteListRow(purpose: 'Pamahaw', amount: 2300.00)
        ])
      )
    );
  }
}