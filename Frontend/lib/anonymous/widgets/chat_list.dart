import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flinnit/anonymous/data/chat_users.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatList extends StatefulWidget {
  const ChatList({
    super.key,
    required this.activeMode,
    required this.source,
    required this.searchText,
    required this.isSearching,
    required this.onSelect,
    required this.onOpenChat,
    required this.controller,
    required this.socket,
  });

  final Mode activeMode;
  final ChatListController controller;
  final ChatUsers source;
  final bool isSearching;
  final String searchText;
  final void Function(int) onSelect;
  final void Function() onOpenChat;
  final io.Socket socket;

  @override
  State<ChatList> createState() => _ChatListState(controller);
}

class _ChatListState extends State<ChatList> {

  _ChatListState(ChatListController _controller) {
    _controller.deselectAllChats = deselectAllChats;
  }

  List<ChatUsers> displayedChatUsers = chatUsers;
  var noOfSelectedChat = 0;

  void _sortListByDate() {
    for (int i = 0; i < displayedChatUsers.length; i++) {
      for (int j = 0; j < displayedChatUsers.length - i - 1; j++) {
        if (displayedChatUsers[j]
            .time
            .isBefore(displayedChatUsers[j + 1].time)) {
          final temp = displayedChatUsers[j];
          displayedChatUsers[j] = displayedChatUsers[j + 1];
          displayedChatUsers[j + 1] = temp;
        }
      }
    }
  }

  void deselectAllChats() {
    setState(() {
      for (int i = 0; i < displayedChatUsers.length; i++) {
        displayedChatUsers[i].isSelected = false;
      }
      noOfSelectedChat = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.searchText);

    _sortListByDate();

    if (widget.isSearching) {
      displayedChatUsers = chatUsers
          .where((element) => element.name
              .toLowerCase()
              .contains(widget.searchText.toLowerCase()))
          .toList();
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 12),
      itemCount: displayedChatUsers.length,
      itemBuilder: (ctx, index) => Column(
        children: [
          ChatTile(
            activeMode: widget.activeMode,
            chatUser: displayedChatUsers[index],
            source: widget.source,
            noOfSelectedChat: noOfSelectedChat,
            socket: widget.socket,
            onSelect: () {
              setState(() {
                displayedChatUsers[index].isSelected =
                    !displayedChatUsers[index].isSelected;
                noOfSelectedChat = displayedChatUsers
                    .where((element) => element.isSelected)
                    .length;
                widget.onSelect(noOfSelectedChat);
              });
            },
            onOpenChat: widget.onOpenChat,
          ),
          Container(
            height: 1,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}

class ChatListController {
  late void Function() deselectAllChats;
}