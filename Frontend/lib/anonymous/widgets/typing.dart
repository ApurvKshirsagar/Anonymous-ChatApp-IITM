import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flutter/material.dart';

class TypingBubble extends StatelessWidget {
  const TypingBubble({
    super.key,
    required this.activeMode,
    required this.chatUser,
  });

  final Mode activeMode;
  final ChatUsers chatUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 5,
        ),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: (activeMode == Mode.flinnMate)
              ? const Color.fromRGBO(137, 79, 191, 1)
              : (chatUser.gender == Gender.female)
                  ? const Color.fromRGBO(255, 141, 199, 1)
                  : const Color.fromRGBO(69, 109, 209, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Text('...'),
        ),
      ),
    );
  }
}
