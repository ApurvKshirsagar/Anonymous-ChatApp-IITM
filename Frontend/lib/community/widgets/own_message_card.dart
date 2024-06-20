import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/community/models/community_message.dart';
import 'package:flinnit/community/widgets/message_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityOwnMessageCard extends StatelessWidget {
  const CommunityOwnMessageCard({
    super.key,
    required this.message,
    required this.time,
    required this.source,
  });

  final CommunityMessageModel message;
  final DateTime time;
  final ChatUsers source;

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
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: (source.gender == Gender.female)
                ? const Color.fromRGBO(255, 141, 199, 1)
                : const Color.fromRGBO(69, 109, 209, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                    left: 10,
                    right: 35,
                    top: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.message,
                        style: GoogleFonts.laila(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 3),
                          MessaageIcons(
                            content: message.comments,
                            icon: Icons.chat_bubble,
                          ),
                          // SizedBox(width: 10),
                          MessaageIcons(
                            content: message.views,
                            icon: Icons.remove_red_eye,
                          ),
                          MessaageIcons(
                            content: message.likes,
                            icon: Icons.heart_broken,
                          ),
                        ],
                      ),
                    ],
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
