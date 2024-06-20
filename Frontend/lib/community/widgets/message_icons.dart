import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessaageIcons extends StatelessWidget {
  const MessaageIcons({
    super.key,
    required this.content,
    required this.icon,
  });

  final IconData icon;
  final int content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      child: Row(
        children: [
          Icon(
            icon,
            color: Color.fromRGBO(97, 37, 112, 1),
            size: 15,
          ),
          SizedBox(width: 4),
          Text(
            '${content}',
            style: GoogleFonts.amaranth(
              color: Color.fromRGBO(97, 37, 112, 1),
            ),
          ),
        ],
      ),
    );
  }
}
