class Story {
  final String username;
  final String profilePic;

  Story({
    required this.username,
    required this.profilePic,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      username: json['username'],
      profilePic: json['profile_pic'],
    );
  }
}
