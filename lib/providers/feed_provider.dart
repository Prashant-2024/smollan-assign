import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';
import '../services/api_service.dart';

class FeedProvider with ChangeNotifier {
  List<Story> _stories = [];
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Story> get stories => _stories;
  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchFeed() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await ApiService.fetchFeed();
      _stories = data["stories"];
      _posts = data["posts"];
      print("Feed Data Loaded: ${_stories.length} stories, ${_posts.length} posts"); // ✅ Debugging log
    } catch (e) {
      print("Feed Error: $e");
      _stories = [];
      _posts = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
