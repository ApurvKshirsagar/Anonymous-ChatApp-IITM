import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/community/widgets/chat_list.dart';
import 'package:flutter/material.dart';

class CommunityHome extends StatefulWidget {
  const CommunityHome({
    super.key,
    required this.isSearching,
    required this.searchText,
    required this.source,
    required this.onOpenChat,
  });

  final ChatUsers source;
  final bool isSearching;
  final String searchText;
  final void Function() onOpenChat;

  @override
  State<CommunityHome> createState() {
    return _CommunityHomeState();
  }
}

class _CommunityHomeState extends State<CommunityHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [
      //       Color.fromRGBO(225, 210, 239, 0.28),
      //       Color.fromRGBO(253, 252, 255, 0),
      //     ],
      //     stops: [0.0, 0.2],
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //   ),
      // ),
      child: CommunityChatList(
        source: widget.source,
        searchText: widget.searchText,
        isSearching: widget.isSearching,
        onOpenChat: () {
          widget.onOpenChat();
        },
      ),
    );
  }
}
