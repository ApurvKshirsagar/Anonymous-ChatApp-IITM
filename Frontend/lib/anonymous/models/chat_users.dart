import 'package:flinnit/anonymous/models/message_model.dart';
import 'package:intl/intl.dart';

enum Gender { male, female }

enum Mode { flinnDate, flinnMate }

final formatterNew = DateFormat.Hm();
final formatterOld = DateFormat.MMMd();

class ChatUsers {
  ChatUsers({
    required this.name,
    required this.messages,
    required this.image,
    required this.time,
    required this.gender,
    required this.unreadMessages,
    required this.id,
    required this.isSelected,
    required this.activeDateChats,
    required this.activeMateChats,
    required this.dateID,
    required this.flinnID,
  });

  final String name;
  List<MessageModel> messages;
  final String image;
  final DateTime time;
  final Gender gender;
  final int unreadMessages;
  final int id;
  bool isSelected;
  final String flinnID;
  final String dateID;
  List<String> activeMateChats;
  List<String> activeDateChats;
}
