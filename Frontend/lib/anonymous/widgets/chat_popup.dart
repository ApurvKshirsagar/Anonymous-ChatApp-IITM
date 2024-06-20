import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/widgets/block_alert.dart';
import 'package:flinnit/anonymous/widgets/clear_chat_alert.dart';
import 'package:flinnit/anonymous/widgets/report_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPopup extends StatelessWidget {
  const ChatPopup({
    super.key,
    required this.clearChat,
    required this.chatUser,
  });

  final void Function() clearChat;
  final ChatUsers chatUser;

  final checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(-30, AppBar().preferredSize.height),
      itemBuilder: (ctx) => [
        PopupMenuItem(
          child: Text(
            'Search',
            style: GoogleFonts.amaranth(
              fontSize: 18,
            ),
          ),
        ),
        PopupMenuItem(
          child: Text(
            'Block',
            style: GoogleFonts.amaranth(
              fontSize: 18,
            ),
          ),
          onTap: () {
            showDialog(
              context: ctx,
              builder: (ctx) => BlockAlert(
                chatUser: chatUser,
              ),
            );
          },
        ),
        PopupMenuItem(
          child: Text(
            'Report',
            style: GoogleFonts.amaranth(
              fontSize: 18,
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => ReportAlert(chatUser: chatUser),
            );
          },
        ),
        PopupMenuItem(
          child: Text(
            'Leave chat',
            style: GoogleFonts.amaranth(
              fontSize: 18,
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => ClearChatAlert(
                clearChat: clearChat,
              ),
            );
          },
          child: Text(
            'Clear chat',
            style: GoogleFonts.amaranth(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
