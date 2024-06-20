import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/widgets/block_alert.dart';
import 'package:flinnit/anonymous/widgets/clear_chat_alert.dart';
import 'package:flinnit/anonymous/widgets/report_alert.dart';
import 'package:flinnit/community/models/community.dart';
import 'package:flinnit/community/widgets/report_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityChatPopup extends StatelessWidget {
  const CommunityChatPopup({
    super.key,
    required this.clearChat,
    required this.community,
  });

  final void Function() clearChat;
  final Community community;

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
            'Report',
            style: GoogleFonts.amaranth(
              fontSize: 18,
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => CommunityReportAlert(community: community),
            );
          },
        ),
        PopupMenuItem(
          child: Text(
            'Exit Community',
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
        PopupMenuItem(
          onTap: () {},
          child: Text(
            'Community info',
            style: GoogleFonts.amaranth(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
