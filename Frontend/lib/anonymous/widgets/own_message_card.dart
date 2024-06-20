import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({
    super.key,
    required this.message,
    required this.time,
    required this.source,
    required this.activeMode,
  });

  final String message;
  final DateTime time;
  final ChatUsers source;
  final Mode activeMode;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 100,
          minWidth: 80,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 5,
          ),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: (source.gender == Gender.female)
                ? const Color.fromRGBO(255, 141, 199, 1)
                : const Color.fromRGBO(69, 109, 209, 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.5),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                    left: 10,
                    right: 35,
                    top: 5,
                  ),
                  child: Text(
                    message,
                    style: GoogleFonts.amaranth(
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 7,
                  child: Text(
                    formatterNew.format(time),
                    style: GoogleFonts.amaranth(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: const Color.fromARGB(161, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
