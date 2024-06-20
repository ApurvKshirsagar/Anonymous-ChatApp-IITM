import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';

class DisappearMessagesAlert extends StatefulWidget {
  const DisappearMessagesAlert({
    super.key,
    required this.chatUser,
    required this.disappear,
  });

  final ChatUsers chatUser;
  final void Function() disappear;

  @override
  State<DisappearMessagesAlert> createState() => _DisappearMessagesAlertState();
}

class _DisappearMessagesAlertState extends State<DisappearMessagesAlert> {
  // final controller = GroupController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Disappearing messages',
        style: GoogleFonts.amaranth(),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'For privacy and storage, new messages will disappear from this chat for everyone. Anyone in the chat can change this setting.',
              style: GoogleFonts.amaranth(),
            ),
          ),
          // const SizedBox(height: 15),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: SimpleGroupedCheckbox(
          //     controller: controller,
          //     itemsTitle: ['12 hours', '1 week', 'Always'],
          //     values: ['12 hours', '1 week', 'Always'],
          //   ),
          // ),
        ],
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
            widget.disappear();
            // if (blockAndDelete) {
            //   print('user blocked');
            //   print('chat deleted');
            // }
            Navigator.pop(context);
          },
          child: Text(
            'OK',
            style: GoogleFonts.amaranth(),
          ),
        ),
      ],
    );
  }
}
