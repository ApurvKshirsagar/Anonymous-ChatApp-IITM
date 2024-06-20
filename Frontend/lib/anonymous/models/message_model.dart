enum Sender { source, target }

class MessageModel {
  const MessageModel({
    required this.message,
    required this.sender,
    required this.time,
  });

  final String message;
  final Sender sender;
  final DateTime time;
}
