class MessageModel {
  final String id;
  final String senderId;
  final String text;
  final DateTime createdAt;

  MessageModel({required this.id, required this.senderId, required this.text, required this.createdAt});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'].toString(),
    senderId: json['senderId'].toString(),
    text: json['text'] ?? '',
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'senderId': senderId,
    'text': text,
    'createdAt': createdAt.toIso8601String(),
  };
}