

class Post {
  String id;
  final String userId;
  final String post;
  final DateTime time;

  Post({
    this.id = '',
    required this.userId,
    required this.post,
    required this.time
  });

  Map<String, dynamic> toJson() => {'id': id, 'post': post};

  static Post fromJson(Map<String, dynamic> json) =>
      Post(
          id: json['id'],
          post: json['post'],
          userId: json['userId'],
          time: json['time'],
      );
}
