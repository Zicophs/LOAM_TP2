class Fwitter{
  final String post;
  final int likes;
  final String date;
  final String user;
  final String avatarImg;

  Fwitter({
    required this.likes,
    required this.post,
    required this.date,
    required this.user,
    required this.avatarImg
  });

  Fwitter.fromJson(Map<String, Object?> json)
      : this(
          user: json['user']! as String,
          likes: json['likes']! as int,
          post: json['post']! as String,
          date: json['date']! as String,
          avatarImg: json['avatarImg']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'user' : user,
      'likes': likes,
      'post': post,
      'date': date,
      'avatarImg': avatarImg,
    };
  }
}