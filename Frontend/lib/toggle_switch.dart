import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch({
    super.key,
    required this.toggle,
    required this.switchValue,
    required this.label,
    required this.icon,
  });

  final void Function(bool) toggle;
  final bool switchValue;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 12),
          child: Icon(
            icon,
            // size: 29,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.amaranth(
            fontSize: 18,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Switch(
            value: switchValue,
            onChanged: toggle,
          ),
        )
      ],
    );
  }
}
