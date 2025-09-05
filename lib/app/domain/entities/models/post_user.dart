class PostUser {
  final String userId;
  final String listDescription;
  final String content;
  final String type;
  
  PostUser(this.userId, this.listDescription, this.content, this.type);

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      json['userId'] ?? '',
      json['listDescription'] ?? '',
      json['content'] ?? '',
      json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'listDescription': listDescription,
      'content': content,
      'type': type,
    };
  }
}
