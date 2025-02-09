import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../models/profile_model.dart';
import '../models/story_model.dart';

class ApiService {
  static const String feedUrl = "https://api.mocklets.com/p6903/getFeedAPI";
  static const String postUrl = "https://api.mocklets.com/p6903/getPostAPI";
  static const String profileUrl = "https://api.mocklets.com/p6903/getProfileAPI";

  // Fetch Feed Data
  static Future<Map<String, dynamic>> fetchFeed() async {
    try {
      final response = await http.get(Uri.parse(feedUrl));
      print("API Response: ${response.body}"); // ✅ Debug API response

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Extract stories
        List<Story> stories =
        (jsonResponse["stories"] as List).map((json) => Story.fromJson(json)).toList();

        // Extract posts
        List<Post> posts =
        (jsonResponse["posts"] as List).map((json) => Post.fromJson(json)).toList();

        return {"stories": stories, "posts": posts};
      } else {
        throw Exception("Failed to load feed");
      }
    } catch (e) {
      print("Error fetching feed: $e");
      throw Exception("Error fetching data");
    }
  }

  // Fetch Single Post Data
  static Future<Post> fetchPost() async {
    try {
      final response = await http.get(Uri.parse(postUrl));
      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load post");
      }
    } catch (e) {
      throw Exception("Error fetching post: $e");
    }
  }

  // Fetch Profile Data
  static Future<Profile> fetchProfile() async {
    try {
      final response = await http.get(Uri.parse(profileUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Profile.fromJson(jsonData);
      } else {
        throw Exception("Failed to load profile: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching profile: ${e.toString()}");
    }
  }
}
