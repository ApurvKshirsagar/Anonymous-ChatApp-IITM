import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttachmentButton extends StatelessWidget {
  const AttachmentButton({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(
        icon,
        size: 25,
        color: const Color.fromRGBO(152, 103, 197, 1),
      ),
      label: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Text(
            text,
            style: GoogleFonts.amaranth(
              fontSize: 20,
              color: const Color.fromRGBO(70, 27, 106, 1),
            ),
          ),
        ),
      ),
    );
  }
}
