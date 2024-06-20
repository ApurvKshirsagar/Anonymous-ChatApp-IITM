import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/community/models/community.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityReportAlert extends StatefulWidget {
  const CommunityReportAlert({
    super.key,
    // required this.reportUser,
    // required this.blockUser,
    required this.community,
  });

  // final void Function() reportUser;
  // final void Function() blockUser;
  final Community community;

  @override
  State<CommunityReportAlert> createState() => _CommunityReportAlertState();
}

class _CommunityReportAlertState extends State<CommunityReportAlert> {
  var blockAndDelete = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Report ${widget.community.name}?',
        style: GoogleFonts.amaranth(
          fontSize: (widget.community.name.length < 13) ? 23 : 20,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Last 10 messages from this chat will be forwarded to Flinnit.',
              style: GoogleFonts.amaranth(),
            ),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'This user will not be notified.',
              style: GoogleFonts.amaranth(),
            ),
          ),
          const SizedBox(height: 20),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Checkbox(
          //         value: blockAndDelete,
          //         onChanged: (value) {
          //           setState(() {
          //             blockAndDelete = value!;
          //           });
          //         },
          //       ),
          //       Text(
          //         'Block contact and delete chat',
          //         style: GoogleFonts.amaranth(),
          //       ),
          //     ],
          //   ),
          // )
          CheckboxListTile(
            value: blockAndDelete,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              'Block contact and delete chat',
              style: GoogleFonts.amaranth(
                fontSize: 14,
              ),
            ),
            onChanged: (value) {
              setState(() {
                blockAndDelete = value!;
              });
            },
          ),
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
            print('user reported');
            if (blockAndDelete) {
              print('user blocked');
              print('chat deleted');
            }
            Navigator.pop(context);
          },
          child: Text(
            'Report',
            style: GoogleFonts.amaranth(),
          ),
        ),
      ],
    );
  }
}
