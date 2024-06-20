// ignore_for_file: avoid_print

import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/community/models/community.dart';
import 'package:flinnit/anonymous/widgets/avatar.dart';
import 'package:flinnit/community/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityChatTile extends StatefulWidget {
  const CommunityChatTile({
    super.key,
    required this.community,
    required this.source,
    required this.onOpenChat,
  });

  final Community community;
  final ChatUsers source;
  final void Function() onOpenChat;

  @override
  State<CommunityChatTile> createState() => _CommunityChatTileState();
}

class _CommunityChatTileState extends State<CommunityChatTile> {
  final now = DateTime.now();
  late DateTime today;
  late DateTime dayOfMessage;

  @override
  void initState() {
    super.initState();
    today = DateTime(now.year, now.month, now.day);
    dayOfMessage = DateTime(widget.community.time.year,
        widget.community.time.month, widget.community.time.day);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            print(widget.community.id);
            widget.onOpenChat();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => CommunityChatScreen(
                  community: widget.community,
                  source: widget.source,
                ),
              ),
            );
          },
          onLongPress: () {
            print('Chat has been selected');
          },
          leading: const Avatar(
            mode: Mode.flinnMate,
            gender: Gender.male,
            outerRadius: 22,
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.community.name,
                style: GoogleFonts.amaranth(
                  fontSize: 19,
                  color: const Color.fromRGBO(70, 27, 106, 1),
                ),
              ),
              const SizedBox(width: 7),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color.fromRGBO(152, 103, 197, 1),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Text(
                      widget.community.type.name,
                      style: GoogleFonts.amaranth(
                        color: const Color.fromRGBO(152, 103, 197, 1),
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            widget.community.lastMessage,
            style: GoogleFonts.amaranth(
              fontSize: 15,
              color: const Color.fromRGBO(50, 38, 83, .6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 3),
              Text(
                (dayOfMessage == today)
                    ? formatterNew.format(widget.community.time)
                    : formatterOld.format(widget.community.time),
                style: GoogleFonts.itim(
                  fontSize: 13,
                  color: const Color.fromRGBO(50, 38, 83, 0.77),
                ),
              ),
              const SizedBox(height: 6),
              (widget.community.unreadMessages != 0)
                  ? Container(
                      height: 23,
                      width: 23,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 80, 103, 1),
                      ),
                      child: Center(
                        child: Text(
                          widget.community.unreadMessages.toString(),
                          style: GoogleFonts.itim(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
