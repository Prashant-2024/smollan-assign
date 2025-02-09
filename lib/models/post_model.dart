class Post {
  final String id;
  final String username;
  final String profilePic;
  final String imageUrl;
  final String caption;
  final int likes;
  final int comments;
  final String? postDate;
  final String? postText;

  Post({
    required this.id,
    required this.username,
    required this.profilePic,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.comments,
    this.postDate,
    this.postText,
  });

  // ✅ Factory method for JSON deserialization
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id']?.toString() ?? '',
      username: json['username'] ?? 'Unknown',
      profilePic: json['profile_pic'] ?? '',
      imageUrl: json['image'] ?? '',
      caption: json['caption'] ?? '',
      likes: _extractLikes(json['likes']), // ✅ Convert likes correctly
      comments: _parseToInt(json['comments']), // ✅ Convert comments correctly
      postDate: json['post_date'],
      postText: json['post_text'],
    );
  }

  // ✅ Extract numeric value from likes string
  static int _extractLikes(dynamic likesData) {
    if (likesData is int) {
      return likesData; // ✅ Already an integer
    } else if (likesData is String) {
      final match = RegExp(r'\d+').firstMatch(likesData);
      return match != null ? int.parse(match.group(0)!) : 0; // Extract first number
    }
    return 0; // Default if no valid number is found
  }

  // ✅ Ensure `comments` are properly converted to int
  static int _parseToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      final match = RegExp(r'\d+').firstMatch(value);
      return match != null ? int.parse(match.group(0)!) : 0;
    }
    return 0;
  }

  // ✅ Convert Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'profile_pic': profilePic,
      'image': imageUrl,
      'caption': caption,
      'likes': likes,
      'comments': comments,
      if (postDate != null) 'post_date': postDate,
      if (postText != null) 'post_text': postText,
    };
  }
}
