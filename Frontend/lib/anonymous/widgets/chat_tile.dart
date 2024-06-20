// ignore_for_file: must_be_immutable

import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/screens/chat_screen.dart';
import 'package:flinnit/anonymous/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatTile extends StatefulWidget {
  const ChatTile({
    super.key,
    required this.chatUser,
    required this.activeMode,
    required this.source,
    required this.onSelect,
    required this.onOpenChat,
    required this.noOfSelectedChat,
    required this.socket,
  });

  final ChatUsers chatUser;
  final Mode activeMode;
  final ChatUsers source;
  final int noOfSelectedChat;
  final void Function() onSelect;
  final void Function() onOpenChat;
  final io.Socket socket;

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  final now = DateTime.now();
  late DateTime today;
  late DateTime dayOfMessage;

  @override
  void initState() {
    super.initState();
    today = DateTime(now.year, now.month, now.day);
    dayOfMessage = DateTime(
      widget.chatUser.time.year,
      widget.chatUser.time.month,
      widget.chatUser.time.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: (widget.noOfSelectedChat == 0)
              ? () {
                  print(widget.chatUser.id);
                  widget.onOpenChat();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ChatScreen(
                        chatUser: widget.chatUser,
                        activeMode: widget.activeMode,
                        source: widget.source,
                        socket: widget.socket,
                      ),
                    ),
                  );
                }
              : widget.onSelect,
          onLongPress: widget.onSelect,
          leading: Avatar(
            mode: widget.activeMode,
            gender: widget.chatUser.gender,
            outerRadius: 22,
          ),
          title: Text(
            widget.chatUser.name,
            style: GoogleFonts.amaranth(
              fontSize: 19,
              color: const Color.fromRGBO(70, 27, 106, 1),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: (widget.chatUser.messages.length == 0)
              ? null
              : Text(
                  widget.chatUser.messages[widget.chatUser.messages.length - 1]
                      .message,
                  style: GoogleFonts.amaranth(
                    fontSize: 15,
                    color: const Color.fromRGBO(50, 38, 83, .6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          trailing: (widget.noOfSelectedChat == 0)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 3),
                    Text(
                      (dayOfMessage == today)
                          ? formatterNew.format(widget.chatUser.time)
                          : formatterOld.format(widget.chatUser.time),
                      style: GoogleFonts.itim(
                        fontSize: 13,
                        color: const Color.fromRGBO(50, 38, 83, 0.77),
                      ),
                    ),
                    const SizedBox(height: 6),
                    (widget.chatUser.unreadMessages != 0)
                        ? Container(
                            height: 23,
                            width: 23,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(0, 80, 103, 1),
                            ),
                            child: Center(
                              child: Text(
                                widget.chatUser.unreadMessages.toString(),
                                style: GoogleFonts.itim(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : const Spacer(),
                  ],
                )
              : Container(
                  height: 20,
                  width: 20,
                  decoration: (!widget.chatUser.isSelected)
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Colors.black),
                        )
                      : BoxDecoration(
                          color: Color.fromRGBO(152, 103, 197, 1),
                        ),
                ),
        ),
      ],
    );
  }
}
