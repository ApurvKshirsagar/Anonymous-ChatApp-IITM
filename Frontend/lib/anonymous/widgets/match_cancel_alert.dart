import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchCancelAlert extends StatelessWidget {
  const MatchCancelAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Hey wait...',
        style: GoogleFonts.amaranth(),
      ),
      content: Text(
        'We almost found just the perfect match for you.',
        style: GoogleFonts.amaranth(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            'Stop',
            style: GoogleFonts.amaranth(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(152, 103, 197, 1),
            foregroundColor: Colors.white,
          ),
          child: Text(
            'Continue finding',
            style: GoogleFonts.amaranth(),
          ),
        ),
      ],
    );
  }
}
