import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/community/data/communities.dart';
import 'package:flinnit/community/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flinnit/anonymous/data/chat_users.dart';
import 'package:flinnit/community/models/community.dart';

class CommunityChatList extends StatefulWidget {
  const CommunityChatList({
    super.key,
    required this.source,
    required this.searchText,
    required this.isSearching,
    required this.onOpenChat,
  });

  final ChatUsers source;
  final bool isSearching;
  final String searchText;
  final void Function() onOpenChat;

  @override
  State<CommunityChatList> createState() => _CommunityChatListState();
}

class _CommunityChatListState extends State<CommunityChatList> {
  List<Community> displayedCommunities = joinedCommunities;

  void _sortListByDate() {
    for (int i = 0; i < displayedCommunities.length; i++) {
      for (int j = 0; j < displayedCommunities.length - i - 1; j++) {
        if (displayedCommunities[j]
            .time
            .isBefore(displayedCommunities[j + 1].time)) {
          final temp = displayedCommunities[j];
          displayedCommunities[j] = displayedCommunities[j + 1];
          displayedCommunities[j + 1] = temp;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _sortListByDate();

    if (widget.isSearching) {
      displayedCommunities = joinedCommunities
          .where(
            (element) => element.name.toLowerCase().contains(
                  widget.searchText.toLowerCase(),
                ),
          )
          .toList();
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 12),
      itemCount: displayedCommunities.length,
      itemBuilder: (ctx, index) => Column(
        children: [
          CommunityChatTile(
            community: displayedCommunities[index],
            source: widget.source,
            onOpenChat: () {
              widget.onOpenChat();
            },
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
