import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';

class MuteNotificationAlert extends StatefulWidget {
  const MuteNotificationAlert({
    super.key,
    required this.chatUser,
    required this.mute,
  });

  final ChatUsers chatUser;
  final void Function() mute;

  @override
  State<MuteNotificationAlert> createState() => _MuteNotificationAlertState();
}

class _MuteNotificationAlertState extends State<MuteNotificationAlert> {
  // final controller = GroupController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Mute Notifications',
        style: GoogleFonts.amaranth(),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Other user will not see that you muted this chat. You will still be notified if you are mentioned.',
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
            widget.mute();
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
