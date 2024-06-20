import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.search,
    required this.onBack,
  });

  final void Function(String) search;
  final void Function() onBack;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          autofocus: true,
          style: GoogleFonts.amaranth(),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: widget.onBack,
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Color.fromRGBO(68, 81, 86, 0.6),
              ),
            ),
            hintText: 'Search...',
            hintStyle: GoogleFonts.amaranth(
              color: Color.fromRGBO(68, 81, 86, 0.6),
            ),
            border: InputBorder.none,
          ),
          onChanged: widget.search,
        ),
      ),
    );
  }
}
