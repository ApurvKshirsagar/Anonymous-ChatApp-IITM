import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/models/message_model.dart';

class CommunityMessageModel {
  const CommunityMessageModel({
    required this.comments,
    required this.likes,
    required this.message,
    required this.time,
    required this.views,
    required this.senderDetails,
  });

  final DateTime time;
  final String message;
  final int comments;
  final int views;
  final int likes;
  final ChatUsers senderDetails;
}
 