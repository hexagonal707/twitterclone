

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  final String userId;
  final String content;
  final DateTime time;

  Post(
      {this.id = '',
      required this.userId,
      required this.content,
      required this.time});

  Map<String, dynamic> toJson() => {'id': id, 'userId': userId, 'content': content, 'time': time};

  static Post fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        userId: json['userId'],
        content: json['content'],
        time: (json["time"] as Timestamp).toDate());

}
