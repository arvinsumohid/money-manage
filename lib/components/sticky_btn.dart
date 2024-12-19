import 'package:flutter/material.dart';
import '../helpers/quick_note_popup_form.dart';

class StickyBtn extends StatelessWidget {
  const StickyBtn();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,  // Distance from the bottom
      left: MediaQuery.of(context).size.width / 2 - 50,  // Center horizontally
      child: ElevatedButton(
        onPressed: () => quickNotePopupForm(context),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          backgroundColor: Colors.teal[700]
        ),
        child: Icon(
          Icons.add,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}