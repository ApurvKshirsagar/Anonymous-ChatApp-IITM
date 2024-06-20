import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideDrawerButton extends StatelessWidget {
  const SideDrawerButton(
      {required this.buttonText, required this.buttonIcon, super.key});

  final String buttonText;
  final IconData buttonIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 15),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: const Size(260, 40),
        ),
        onPressed: () {},
        label: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              buttonText,
              style: GoogleFonts.amaranth(
                fontSize: 20,
                color: const Color.fromRGBO(97, 37, 112, 1),
              ),
            ),
          ),
        ),
        icon: Icon(
          buttonIcon,
          color: const Color.fromRGBO(97, 37, 112, 1),
        ),
      ),
    );
  }
}
