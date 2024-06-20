import 'package:flinnit/anonymous/models/chat_users.dart';

enum CommunityType { private, public }

enum DisappearingMessage { oneDay, oneWeek, twoWeek, off }

enum Visible { admin, everyone }

enum CanJoin { male, female, all }

class Community {
  Community({
    required this.name,
    required this.id,
    required this.image,
    required this.isSelected,
    required this.time,
    required this.unreadMessages,
    required this.lastMessage,
    required this.type,
    required this.disappearing,
    required this.visibility,
    required this.canJoin,
    required this.members,
  });

  String name;
  String image;
  final DateTime time;
  final int unreadMessages;
  bool isSelected;
  final String lastMessage;
  final int id;
  final CommunityType type;
  DisappearingMessage disappearing;
  final Visible visibility;
  final CanJoin canJoin;
  final List<ChatUsers> members;
}
