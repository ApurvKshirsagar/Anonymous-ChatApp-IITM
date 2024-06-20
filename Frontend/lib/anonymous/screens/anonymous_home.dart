import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AnonymousHome extends StatelessWidget {
  const AnonymousHome({
    super.key,
    required this.activeMode,
    required this.source,
    required this.isSearching,
    required this.searchText,
    required this.onSelectAnonymous,
    required this.onOpenChat,
    required this.controller,
    required this.socket,
  });

  final Mode activeMode;
  final ChatUsers source;
  final String searchText;
  final bool isSearching;
  final void Function(int) onSelectAnonymous;
  final void Function() onOpenChat;
  final ChatListController controller;
  final io.Socket socket;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: (activeMode == Mode.flinnMate)
      //         ? [
      //             const Color.fromRGBO(225, 210, 239, 0.28),
      //             const Color.fromRGBO(253, 252, 255, 0),
      //           ]
      //         : [
      //             const Color.fromRGBO(254, 160, 189, 0.4615),
      //             const Color.fromRGBO(253, 252, 255, 0),
      //           ],
      //     stops: const [0.0, 0.2],
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //   ),
      // ),
      child: ChatList(
        activeMode: activeMode,
        source: source,
        socket: socket,
        isSearching: isSearching,
        searchText: searchText,
        onSelect: (value) {
          onSelectAnonymous(value);
        },
        onOpenChat: onOpenChat,
        controller: controller,
      ),
    );
  }
}
