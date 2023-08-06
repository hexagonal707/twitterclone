

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId;
  final String userId;
  final String content;
  final DateTime time;

  Post(
      {this.postId = '',
      required this.userId,
      required this.content,
      required this.time});

  Map<String, dynamic> toJson() => {'postId': postId, 'userId': userId, 'content': content, 'time': time};

  static Post fromJson(Map<String, dynamic> json) => Post(
        postId: json['postId'],
        userId: json['userId'],
        content: json['content'],
        time: (json["time"] as Timestamp).toDate());

}
