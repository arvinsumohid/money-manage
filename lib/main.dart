import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:money_manage/components/page_header.dart';
import 'package:money_manage/components/sticky_btn.dart';
import 'package:provider/provider.dart';

import 'components/quick_note/expansion.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Money Widget',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.teal[200],
      body: Stack(
        children: [
          // Main Content Area
          Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageHeader(text: 'Quick Note'),
                Expanded(
                  child: ListView(
                    children: [
                      QuickNoteExpansion(date: 'Jan 3, 2023'),
                      QuickNoteExpansion(date: 'Jan 4, 2023'),
                      QuickNoteExpansion(date: 'Jan 5, 2023'),
                      QuickNoteExpansion(date: 'Jan 6, 2023'),
                      QuickNoteExpansion(date: 'Jan 7, 2023'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Sticky Button at the bottom
          StickyBtn(),
        ],
      )
    );
  }
}