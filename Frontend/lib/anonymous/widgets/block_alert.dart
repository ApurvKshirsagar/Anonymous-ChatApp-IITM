import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlockAlert extends StatelessWidget {
  const BlockAlert({
    super.key,
    // required this.blockUser,
    required this.chatUser,
  });

  // final void Function() blockUser;
  final ChatUsers chatUser;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Block ${chatUser.name}?',
        style: GoogleFonts.amaranth(
          fontSize: (chatUser.name.length < 13) ? 23 : 20,
        ),
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
            // blockUser();
            print('user blocked');
            Navigator.pop(context);
          },
          child: Text(
            'Block',
            style: GoogleFonts.amaranth(),
          ),
        ),
      ],
    );
  }
}
