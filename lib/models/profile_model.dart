class Profile {
  final String username;
  final String profilePic;
  final int posts;
  final int followers;
  final int following;
  final Bio bio;
  final List<Highlight> highlights;
  final List<String> gallery;

  Profile({
    required this.username,
    required this.profilePic,
    required this.posts,
    required this.followers,
    required this.following,
    required this.bio,
    required this.highlights,
    required this.gallery,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'] ?? '',
      profilePic: json['profile_pic'] ?? '',
      posts: json['posts'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      bio: Bio.fromJson(json['bio'] ?? {}),
      highlights: (json['highlights'] as List<dynamic>?)
          ?.map((item) => Highlight.fromJson(item))
          .toList() ??
          [],
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((item) => item['image'] as String)
          .toList() ??
          [],
    );
  }
}

class Bio {
  final String designation;
  final String description;
  final String website;

  Bio({
    required this.designation,
    required this.description,
    required this.website,
  });

  factory Bio.fromJson(Map<String, dynamic> json) {
    return Bio(
      designation: json['designation'] ?? '',
      description: json['description'] ?? '',
      website: json['website'] ?? '',
    );
  }
}

class Highlight {
  final String title;
  final String cover;

  Highlight({
    required this.title,
    required this.cover,
  });

  factory Highlight.fromJson(Map<String, dynamic> json) {
    return Highlight(
      title: json['title'] ?? '',
      cover: json['cover'] ?? '',
    );
  }
}
