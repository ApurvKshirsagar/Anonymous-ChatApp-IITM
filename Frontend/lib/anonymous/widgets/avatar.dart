import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    required this.mode,
    required this.outerRadius,
    required this.gender,
    super.key,
  });

  final Gender gender;
  final double outerRadius;
  final Mode mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (gender == Gender.female)
            ? const Color.fromRGBO(255, 141, 199, 1)
            : const Color.fromRGBO(69, 109, 209, 1),
      ),
      child: CircleAvatar(
        // backgroundImage: NetworkImage(widget.image),
        radius: outerRadius,
        backgroundColor: Colors.white,
        child: Icon(
          (mode == Mode.flinnMate) ? Icons.emoji_emotions : Icons.heart_broken,
          size: outerRadius * 2 - 4,
        ),
      ),
    );
  }
}
