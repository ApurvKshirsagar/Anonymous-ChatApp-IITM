import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClearChatAlert extends StatelessWidget {
  const ClearChatAlert({super.key, required this.clearChat});

  final void Function() clearChat;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Clear this chat?',
        style: GoogleFonts.amaranth(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.amaranth(),
          ),
        ),
        TextButton(
          onPressed: () {
            clearChat();
            Navigator.pop(context);
          },
          child: Text(
            'Clear chat',
            style: GoogleFonts.amaranth(),
          ),
        ),
      ],
    );
  }
}
